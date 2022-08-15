#/bin/bash

name=$(docker ps |grep "celadon-build-environment:latest" | awk '{print $NF}' | head -2 | tail -1)

docker exec -it $name /bin/bash
