#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source setup/packages.sh

echo "[ Packages ] Downloading..."

mkdir -p $DOWNLOAD_DIR

if [ ! -f $DOWNLOAD_DIR/$CONDA_PKG ]; then
    curl -k -L -o $DOWNLOAD_DIR/$CONDA_PKG $CONDA_URL
fi

if [ ! -f $DOWNLOAD_DIR/$JULIA_PKG ]; then
    curl -k -L -o $DOWNLOAD_DIR/$JULIA_PKG $JULIA_URL
fi

md5sum --check setup/CHECKSUM.MD5

echo "[ Packages ] Done!"
