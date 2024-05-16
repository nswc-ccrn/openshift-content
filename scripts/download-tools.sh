#!/bin/bash

# This script is here to update local copy of images designed to be transferred into disconnected/private network.
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
podman pull quay.io/nswc-ccrn/toolbox:latest
podman pull quay.io/nswc-ccrn/oc-mirror:latest

podman save --format oci-archive -o $scriptDir/../images/toolbox.tar.gz quay.io/nswc-ccrn/toolbox:latest
podman save --format oci-archive -o $scriptDir/../images/oc-mirror.tar.gz quay.io/nswc-ccrn/oc-mirror:latest
