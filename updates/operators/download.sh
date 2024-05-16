#!/bin/bash

podman run -d --rm --name oc-mirror-update-operators \
	-v ../pull-secret.txt:/root/.docker/config.json:z \
	-v ./config.yaml:/config.yaml:z \
	-v ./oc-mirror-workspace:/oc-mirror-workspace:z \
	-v ./publish:/publish:z \
	quay.io/nswc-ccrn/oc-mirror:latest
