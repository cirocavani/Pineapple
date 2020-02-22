#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "[ Python ] Installing..."

$CONDA_INSTDIR/bin/conda env create --force -n python -f setup/environment-python.yaml

PYTHON_KERNEL=$JUPYTER_DATA_DIR/kernels/python-abc

mkdir -p $PYTHON_KERNEL

echo "{
    \"display_name\": \"Python ABC\",
    \"language\": \"python\",
    \"argv\": [
        \"$CONDA_INSTDIR/envs/python/bin/python\",
        \"-c\",
        \"from ipykernel.kernelapp import main; main()\",
        \"-f\",
        \"{connection_file}\"
     ]
}" > $PYTHON_KERNEL/kernel.json

echo "[ Python ] Done!"
