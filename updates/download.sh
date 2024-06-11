#!/bin/bash
scriptDir=$(realpath $0)

[[ -f $(pwd)/../images/oc-mirror.tar.gz ]] || podman pull quay.io/nswc-ccrn/oc-mirror:latest && podman save --format=oci-archive -o $(pwd)/../images/oc-mirror.tar.gz quay.io/nswc-ccrn/oc-mirror:latest

podman image exists quay.io/nswc-ccrn/oc-mirror:latest || podman load -i $(pwd)/../images/oc-mirror.tar.gz

podman run -d --rm --name oc-mirror-update-cluster \
	--workdir /content \
	-v $scriptDir/../../pull-secret.txt:/root/.docker/config.json:z \
	-v ./config.yaml:/config.yaml:z \
	-v ./content:/content:z \
	quay.io/nswc-ccrn/oc-mirror:latest \
	--config=/config.yaml file://.
