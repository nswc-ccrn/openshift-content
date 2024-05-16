#!/bin/bash

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
podman image exists quay.io/nswc-ccrn/oc-mirror:latest || podman load -i $scriptDir/../../images/oc-mirror.tar.gz
touch .oc-mirror.log

podman run -it --rm --name oc-mirror-upload-cluster-updates \
	-v /run/user/1000/containers/auth.json:/root/.docker/config.json:ro \
	-v $scriptDir/oc-mirror-workspace:/oc-mirror-workspace:z \
	-v $scriptDir/publish:/publish:z \
	-v $scriptDir/.oc-mirror.log:/.oc-mirror.log:z \
	quay.io/nswc-ccrn/oc-mirror:latest \
	-- "--from=/oc-mirror-workspace docker://$1"
