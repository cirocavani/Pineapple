#!/usr/bin/env bash
set -xeu

cd $(dirname "$0")/..

HW_PLATFORM=${1:-gpu}

case $HW_PLATFORM in
    cpu)
        IMAGE_BASE="ubuntu:18.04"
        DOCKER_ARGS=""
        ;;
    gpu)
        # devel -> CUDAnative.jl
        IMAGE_BASE="nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04"
        DOCKER_ARGS="--gpus all"
        ;;
    *)
        echo "Unsupported platform: $HW_PLATFORM"
        exit 1
esac

IMAGE_TAG="julia-abc-${HW_PLATFORM}:latest"
CONTAINER_NAME="julia-abc-${HW_PLATFORM}"

if [ ! -z "$(docker ps -q -a -f name=$CONTAINER_NAME$)" ]; then
    docker rm -f $CONTAINER_NAME
fi

setup/downloads.sh

docker pull $IMAGE_BASE

docker build \
    --build-arg baseimage=$IMAGE_BASE \
    --build-arg hw_platform=$HW_PLATFORM \
    -t $IMAGE_TAG \
    -f docker/Dockerfile \
    .

docker create \
    --name $CONTAINER_NAME \
    $DOCKER_ARGS \
    -t \
    -p 8888:8888 \
    -v $(pwd):/home/user/julia-abc \
    $IMAGE_TAG
