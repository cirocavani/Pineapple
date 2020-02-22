#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "[ Jupyter ] Installing..."

rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR

$CONDA_INSTDIR/bin/conda env create --force -n jupyter -f setup/environment-jupyter.yaml

echo "[ Jupyter ] Done!"
