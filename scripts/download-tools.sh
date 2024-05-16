#!/bin/bash

# This script is here to update local copy of images designed to be transferred into disconnected/private network.

podman pull quay.io/nswc-ccrn/toolbox:latest
podman pull quay.io/nswc-ccrn/oc-mirror:latest

rm -f images/toolbox.tar.gz
rm -f images/oc-mirror.tar.gz

podman save --format oci-archive -o images/toolbox.tar.gz quay.io/nswc-ccrn/toolbox:latest
podman save --format oci-archive -o images/oc-mirror.tar.gz quay.io/nswc-ccrn/mirror:latest
