#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..

DOWNLOAD_DIR=downloads

mkdir -p $DOWNLOAD_DIR

CONDA_PKG=Miniconda3-4.7.12.1-Linux-x86_64.sh
CONDA_URL=https://repo.anaconda.com/miniconda/$CONDA_PKG

if [ ! -f $DOWNLOAD_DIR/$CONDA_PKG ]; then
    curl -k -L -o $DOWNLOAD_DIR/$CONDA_PKG $CONDA_URL
fi

JULIA_PKG=julia-1.3.1-linux-x86_64.tar.gz
JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.3/$JULIA_PKG

if [ ! -f $DOWNLOAD_DIR/$JULIA_PKG ]; then
    curl -k -L -o $DOWNLOAD_DIR/$JULIA_PKG $JULIA_URL
fi

md5sum --check setup/CHECKSUM.MD5
