#!/bin/bash

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
podman image exists quay.io/nswc-ccrn/oc-mirror:latest || podman load -i $scriptDir/../../images/oc-mirror.tar.gz

podman run -it --rm --name oc-mirror-upload-cluster-updates \
	-v /run/user/1000/containers/auth.json:/root/.docker/config.json:z \
	-v $scriptDir/content:/content:z \
	quay.io/nswc-ccrn/oc-mirror:latest \
	--dest-skip-tls --from=/content docker://$1
