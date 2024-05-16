#!/bin/bash

podman run -it --rm --entrypoint /bin/sh \
	--privileged \
	-v ../:/workspace:z \
	-v ../pull-secret.txt:/root/.docker/config.json:z \
	quay.io/nswc-ccrn/toolbox:latest
