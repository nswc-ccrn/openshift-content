#!/bin/bash
scriptDir=$(dirname $(readlink -fm $0))

[[ -f $scriptDir/../images/oc-mirror.tar.gz ]] || podman pull quay.io/nswc-ccrn/oc-mirror:latest && podman save --format=oci-archive -o $scriptDir/../images/oc-mirror.tar.gz quay.io/nswc-ccrn/oc-mirror:latest

podman image exists quay.io/nswc-ccrn/oc-mirror:latest || podman load -i $scriptDir/../images/oc-mirror.tar.gz

podman run -d --name oc-mirror-update-cluster \
	--workdir /content \
	-v $scriptDir/../pull-secret.txt:/root/.docker/config.json:z \
	-v $scriptDir/config.yaml:/config.yaml:z \
	-v $scriptDir/content:/content:z \
	quay.io/nswc-ccrn/oc-mirror:latest \
	--config=/config.yaml file://. --rebuild-catalogs
