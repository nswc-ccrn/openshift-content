#!/bin/bash
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
podman run -d --rm --name oc-mirror-update-operators \
	--workdir /content \
	-v $scriptDir/../../pull-secret.txt:/root/.docker/config.json:z \
	-v $scriptDir/content:/content:z \
	-v $scriptDir/config.yaml:/config.yaml:z \
	quay.io/nswc-ccrn/oc-mirror:latest \
	--config=/config.yaml file://.
