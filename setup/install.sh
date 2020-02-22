#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

HW_PLATFORM=${1:-cpu}

case $HW_PLATFORM in
    cpu)
        ;;
    gpu)
        ;;
    *)
        echo "Unsupported platform: $HW_PLATFORM"
        exit 1
esac

echo "Installing..."

setup/downloads.sh
setup/install-conda.sh
setup/install-jupyter.sh
setup/install-python.sh
setup/install-julia.sh $HW_PLATFORM

# Conda clean ...

$CONDA_INSTDIR/bin/conda clean -q -y --all

echo "Install done!"
