#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "[ Python ] Installing..."

$CONDA_INSTDIR/bin/conda env create --force -n python -f setup/environment-python.yaml

echo "[ Python ] Done!"
