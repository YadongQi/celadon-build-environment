#!/bin/bash

export WORKSPACE=$PWD/CIV_WORK



docker run \
	-d \
	-it \
	-v $WORKSPACE:/data/ \
	--user celadon \
	-e http_proxy=$http_proxy -e https_proxy=$http_proxy \
	celadon-build-environment:latest /bin/bash
