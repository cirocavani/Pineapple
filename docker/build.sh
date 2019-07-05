#!/usr/bin/env bash
set -xeu

cd $(dirname "$0")/..

HW_PLATFORM=${1:-cpu}

case $HW_PLATFORM in
    cpu)
        IMAGE_BASE="ubuntu:16.04"
        DOCKER_RUNTIME=""
        ;;
    gpu)
        # devel -> CUDAnative.jl
        IMAGE_BASE="nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04"
        DOCKER_RUNTIME="--runtime=nvidia"
        ;;
    *)
        echo "Unsupported platform: $HW_PLATFORM"
        exit 1
esac

IMAGE_TAG="pineapple-${HW_PLATFORM}:latest"
CONTAINER_NAME="pineapple-${HW_PLATFORM}"

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
    $DOCKER_RUNTIME \
    -t \
    -p 8888:8888 \
    -v $(pwd)/workspace:/home/user/workspace \
    $IMAGE_TAG
