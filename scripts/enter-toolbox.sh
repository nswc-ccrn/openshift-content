#!/bin/bash
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
podman image exists quay.io/nswc-ccrn/toolbox:latest || podman load -i $scriptDir/../images/toolbox.tar.gz

podman run -it --rm --entrypoint /bin/sh \
	--privileged \
	-v $scriptDir/../:/workspace:z \
	-v $scriptDir/../pull-secret.txt:/root/.docker/config.json:z \
	quay.io/nswc-ccrn/toolbox:latest
