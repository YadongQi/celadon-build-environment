#!/bin/bash

export WORKSPACE=$PWD/CIV_WORK

docker run -it -v $WORKSPACE:/data/ --user root celadon-build-environment:latest /bin/bash
