#!/bin/bash

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
IMAGE=${IMAGE:-docker.io/aaron666/slurm-login}
BUILDER_IMAGE=${BUILDER_IMAGE:-docker.io/aaron666/slurm-builder:latest}
OS_BASE_IMAGE=${OS_BASE_IMAGE:-docker.io/aaron666/slurm-base:latest}
MPI_TYPE=${MPI_TYPE:-intel-mpi}
TLS_VERIFY=${TLS_VERIFY:-false}
buildah --tls-verify=${TLS_VERIFY} build-using-dockerfile \
    --build-arg OS_BASE_IMAGE=${OS_BASE_IMAGE} \
    --build-arg BUILDER_IMAGE=${BUILDER_IMAGE} \
    --build-arg MPI_TYPE=${MPI_TYPE} \
    -f $SCRIPT_DIR/Dockerfile \
    -t $IMAGE:$MPI_TYPE $SCRIPT_DIR