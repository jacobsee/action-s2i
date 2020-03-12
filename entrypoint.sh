#!/bin/bash

set -e
echo "$5" | docker login "$6" --username "$4" --password-stdin
docker pull "$2"
s2i build "$1" "$2" "$3"
