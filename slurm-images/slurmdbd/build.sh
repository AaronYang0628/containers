#!/bin/bash

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
IMAGE=${IMAGE:-docker.io/aaron666/slurm-slurmdbd:latest}
OS_BASE_IMAGE=${OS_BASE_IMAGE:-docker.io/aaron666/slurm-base:latest}
BUILDER_IMAGE=${BUILDER_IMAGE:-docker.io/aaron666/slurm-builder:latest}
TLS_VERIFY=${TLS_VERIFY:-false}
buildah --tls-verify=${TLS_VERIFY} build-using-dockerfile \
    --build-arg OS_BASE_IMAGE=${OS_BASE_IMAGE} \
    --build-arg BUILDER_IMAGE=${BUILDER_IMAGE} \
    -f $SCRIPT_DIR/Dockerfile \
    -t $IMAGE $SCRIPT_DIR
