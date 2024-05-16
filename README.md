# Openshift Content
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
./updates/<directory>/upload.sh <fqdn of registry>:<port>

# Example:

./updates/cluster/upload.sh my.registry.com:8443
```

These upload scripts are pre-configured to upload all tarballs within the `oc-mirror-workspace` folders.


## Toolbox Container

In many cases, you might need to be able to do this work from a system with updated packages, such as glibc 3.24+ in order for newer version of oc-mirror to work. 

For this reason, in this project repo there is also a `context/` folder with a Dockerfile that has all of the tooling binaries pre-installed, based on RHEL 9 UBI. This is a good way to get things working even on an older system such as a RHEL 7 host.

### Build the Toolbox Container
```bash
./scripts/build-images.sh
```

The above script will build fresh images from scratch.

### Download tools (images)

```bash
./scripts/download-tools.sh
```
The above script will pull the latest tagged images from Quay.io and save them to tarballs under `images/`

### Load tools (images)

The upload scripts should already be configured to determine if you already have an `oc-mirror` image loaded on your machine, and if not, it will `podman load -i` the image from the `images/` directory.

### Troubleshooting: Using the `toolbox` container

```bash
./scripts/enter-toolbox.sh
```

The above script will get you into an ephemeral toolbox container that has all the tools pre-installed, with this project mounted in it.
