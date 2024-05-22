#!/bin/bash
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
podman image exists quay.io/nswc-ccrn/oc-mirror:latest || podman pull quay.io/nswc-ccrn/oc-mirror:latest

podman run -d --rm --name oc-mirror-update-cluster \
	-v $scriptDir/../../pull-secret.txt:/root/.docker/config.json:z \
	-v $scriptDir/config.yaml:/config.yaml:z \
	-v $scriptDir/content:/content:z \
	quay.io/nswc-ccrn/oc-mirror:latest \
	--config=/config.yaml file://content
