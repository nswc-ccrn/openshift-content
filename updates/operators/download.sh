#!/bin/bash
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
podman run -d --rm --name oc-mirror-update-operators \
	-v $scriptDir/../../pull-secret.txt:/root/.docker/config.json:z \
	-v $scriptDir/config.yaml:/config.yaml:z \
	-v $scriptDir/oc-mirror-workspace:/oc-mirror-workspace:z \
	-v $scriptDir/publish:/publish:z \
	quay.io/nswc-ccrn/oc-mirror:latest
