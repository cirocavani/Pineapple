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

. setup/downloads.sh

rm -rf $CONDA_INSTDIR
rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR

bash .cache/$CONDA_PKG -b -p $CONDA_INSTDIR

$CONDA_INSTDIR/bin/conda update -y -n base -c defaults conda
$CONDA_INSTDIR/bin/conda update -y -n base --all

# Jupyter

$CONDA_INSTDIR/bin/conda env create -n jupyter -f setup/environment-jupyter.yaml

# TensorFlow

$CONDA_INSTDIR/bin/conda env create -n tensorflow -f setup/environment-tensorflow-${HW_PLATFORM}.yaml

mkdir -p $JUPYTER_DATA_DIR/kernels/tensorflow
sed -e "s#{{CONDA_INSTDIR}}#$CONDA_INSTDIR#g" setup/jupyter-tensorflow.json \
    > $JUPYTER_DATA_DIR/kernels/tensorflow/kernel.json

# Conda clean ...

$CONDA_INSTDIR/bin/conda clean -y --all


# Julia

rm -rf $JULIA_INSTDIR
rm -rf $JULIA_DEPOT_PATH
rm -f Project.toml Manifest.toml
mkdir -p $JULIA_INSTDIR

tar zxf .cache/$JULIA_PKG -C $JULIA_INSTDIR --strip-components=1

$JULIA_INSTDIR/bin/julia setup/setup.jl


echo "Install done!"
