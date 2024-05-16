# Openshift Content (NSWC CCRN)
Project for managing connected to disconnected openshift content

## Description

In this repository there are folders that contain imageSetConfigs for oc-mirror, a Dockerfile for building a container image that has all of the tooling built in so mirror can be done inside of a disconnected network, and some helper tooling for generating the lists of operators from the red hat distributed operatorhub catalog manifest images.

## Downloading content

Modify the `ImageSetConfiguration` you desire under the `updates/` folder.
Examples on how to fill out these configs can be found at [Red Hat Openshift Product Documentation Site](https://docs.openshift.com/container-platform/4.15/installing/disconnected_install/installing-mirroring-disconnected.html#oc-mirror-image-set-examples_installing-mirroring-disconnected)

Download the content by running the oc-mirror container image and mount the following:

- `pull-secret.txt` into `/root/.docker/config.json` so that `oc-mirror` has credentials to authorize the pull from the repositories you're pulling content from.
- an `ImageSetConfiguration`.yaml file mounted into `/config.yaml` so that `oc-mirror` knows what you're wanting to pull down.
- `updates/<directory>/oc-mirror-workspace` or equivalent into `/oc-mirror-workspace` which is where `oc-mirror` dumps it's data, including the tarballs that you'll need to move into your network.
- `updates/<directory>/publish` or equivalent into `/publish` so `oc-mirror` has a place to put its metadata regarding download and upload. Preserving this between runs will speed things up.

*Alternatively*:
- put your `pull-secret.txt` in the root of the project directory, and run the `download.sh` scripts in `updates/<dir>/`. The scripts should be located beside the `ImageSetConfiguration` yaml files.

The download script will run a container in the background that is downloading your content. you can use `podman ps -a` and `podman logs -f <container name>` to check the progress and status of those containers.

## Uploading Content

```bash
oc mirror --from=<directory> docker://<fqdn of registry>:<PORT>
```

If you use a directory path such as a folder that contains multiple tarballs, it will upload all of those tarballs and perform pruning accordingly based on the metadata carried inside of them.

For advanced usage, check `oc mirror --help`.


## Toolbox Container

In many cases, you might need to be able to do this work from a system with updated packages, such as glibc 3.24+ in order for newer version of oc-mirror to work. 

For this reason, in this project repo there is also a `context/` folder with a Dockerfile that has all of the tooling binaries pre-installed, based on RHEL 9 UBI. This is a good way to get things working even on an older system such as a RHEL 7 host.

### Build the Toolbox Container

```bash
podman build -f context/Dockerfile -t quay.io/nswc-ccrn/toolbox:latest
```

The above command will build a fresh container with tools.

### Save/Export the Container Archive (Tarball)

```bash
podman save quay.io/nswc-ccrn/toolbox:latest nswc-ccrn-toolbox.tar.gz --format oci-archive
```

Export and save the container as a local tar file with the oci-archive format in order to preserve manifest metadata and compress the image.

### Load the Container Archive

```bash
podman load -i nswc-ccrn-toolbox.tar.gz
```

### Shell into the container

```bash
podman run --it --rm --entrypoint /bin/bash \
  -v ./:/workspace:z \
  -v /run/user/1000/containers/auth.json:/root/.docker/config \
  quay.io/nswc-ccrn/toolbox:latest
```

If you get authentication errors when trying to perform uploads while in the container, you can `podman login <registry>:<port>` to generate your auth.json file. 

Your auth file will either be in $XDG_HOME_DIR/containers/auth.json (usually /run/user/1000/containers/auth.json) or $HOME/.docker/config. 
