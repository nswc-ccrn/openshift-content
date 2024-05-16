#!/bin/bash
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

podman build -f $scriptDir/../context/toolbox/Dockerfile -t quay.io/nswc-ccrn/toolbox:latest $scriptDir/../context/toolbox
podman build -f $scriptDir/../context/oc-mirror/Dockerfile -t quay.io/nswc-ccrn/oc-mirror:latest $scriptDir/../context/oc-mirror
