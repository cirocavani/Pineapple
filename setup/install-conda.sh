#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh
source setup/packages.sh

echo "[ Conda ] Installing..."

rm -rf $CONDA_INSTDIR

bash $DOWNLOAD_DIR/$CONDA_PKG -b -p $CONDA_INSTDIR

$CONDA_INSTDIR/bin/conda update -y -n base -c defaults conda
$CONDA_INSTDIR/bin/conda update -y -n base --all

echo "[ Conda ] Done!"
