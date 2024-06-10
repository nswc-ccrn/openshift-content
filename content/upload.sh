#!/bin/bash

scriptDir=$(realpath $0)
podman image exists quay.io/nswc-ccrn/oc-mirror:latest || podman load -i $scriptDir/../../images/oc-mirror.tar.gz

podman run -it --rm --name oc-mirror-upload-cluster-updates \
	--workdir /content \
	-v /run/user/1000/containers/auth.json:/root/.docker/config.json:z \
	-v $scriptDir/../content:/content:z \
	quay.io/nswc-ccrn/oc-mirror:latest \
	--dest-skip-tls --from=. docker://$1
