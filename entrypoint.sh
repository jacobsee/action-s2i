#!/bin/bash

set -e
if [ "$5" = "" ]; then
    echo "Skipping login for image pull - username not set."
else
    echo "Credentials for builder image registry detected - logging in."
    echo "$6" | docker login "$4" --username "$5" --password-stdin
fi
# We will always need to login to the registry we intend to push to
echo "$9" | docker login "$7" --username "$8" --password-stdin
# Grab builder image
docker pull "$2"
# Build
s2i build "$1" "$2" "$3"

# Read tags (if any)
TAGS="${10}"

if [ "$TAGS" = "" ]; then
    echo "Skipping custom tagging, using latest - tags not set."
else
    for TAG in ${TAGS//,/ }
    do
        echo "Tagging image ${3} with ${TAG}"
        docker tag "${3}" "${3}:${TAG}"
    done
fi
# Push to output registry
docker push "$3"