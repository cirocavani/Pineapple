#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..

mkdir -p .cache

CONDA_PKG=Miniconda3-4.6.14-Linux-x86_64.sh
CONDA_URL=https://repo.anaconda.com/miniconda/$CONDA_PKG

if [ ! -f .cache/$CONDA_PKG ]; then
    curl -k -L -o .cache/$CONDA_PKG $CONDA_URL
fi

JULIA_PKG=julia-1.1.1-linux-x86_64.tar.gz
JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.1/$JULIA_PKG

if [ ! -f .cache/$JULIA_PKG ]; then
    curl -k -L -o .cache/$JULIA_PKG $JULIA_URL
fi

md5sum --check setup/CHECKSUM.MD5
