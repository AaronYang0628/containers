#!/bin/bash

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
IMAGE=${IMAGE:-docker.io/aaron666/slurm-munged:latest}
OS_BASE_IMAGE=${OS_BASE_IMAGE:-docker.io/aaron666/slurm-base:latest}
TLS_VERIFY=${TLS_VERIFY:-false}
docker build \
    --build-arg OS_BASE_IMAGE=${OS_BASE_IMAGE} \
    -f $SCRIPT_DIR/Dockerfile \
    -t $IMAGE $SCRIPT_DIR
