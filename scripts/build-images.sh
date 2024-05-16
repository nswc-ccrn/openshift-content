#!/bin/bash

podman build -f ../context/toolbox/Dockerfile -t quay.io/nswc-ccrn/toolbox:latest ../context/toolbox
podman build -f ../context/oc-mirror/Dockerfile -t quay.io/nswc-ccrn/oc-mirror:latest ../context/oc-mirror
