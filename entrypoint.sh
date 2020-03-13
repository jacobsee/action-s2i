#!/bin/bash

set -e
echo "$6" | docker login "$4" --username "$5" --password-stdin
echo "$9" | docker login "$7" --username "$8" --password-stdin
docker pull "$2"
s2i build "$1" "$2" "$3"
docker tag "$3" "$7/$3"
docker push "$7/$3"