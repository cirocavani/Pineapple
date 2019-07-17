#!/usr/bin/env bash
set -xeu

cd $(dirname "$0")/..

HW_PLATFORM=${1:-gpu}

case $HW_PLATFORM in
    cpu)
        ;;
    gpu)
        ;;
    *)
        echo "Unsupported platform: $HW_PLATFORM"
        exit 1
esac

docker start pineapple-${HW_PLATFORM}
