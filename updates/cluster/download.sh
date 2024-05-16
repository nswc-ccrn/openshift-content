#!/bin/bash
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
podman image exists quay.io/nswc-ccrn/oc-mirror:latest || podman pull quay.io/nswc-ccrn/oc-mirror:latest

podman run -d --rm --name oc-mirror-update-cluster \
	-v ./pull-secret.txt:/root/.docker/config.json:z \
	-v ./configs/cluster.yaml:/config.yaml:z \
	-v ./cluster-updates/oc-mirror-workspace:/oc-mirror-workspace:z \
	-v ./cluster-updates/publish:/publish:z \
	quay.io/nswc-ccrn/oc-mirror:latest
