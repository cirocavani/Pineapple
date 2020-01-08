#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "Updating..."

$JULIA_INSTDIR/bin/julia -e "
import Pkg
Pkg.update()
Pkg.gc()
foreach(keys(Pkg.installed())) do m
    try
        eval(Meta.parse(string(\"import \", m)))
    catch
    end
end
"

$CONDA_INSTDIR/bin/conda update -y -n base -c defaults conda
$CONDA_INSTDIR/bin/conda update -y -n base -c defaults --all
$CONDA_INSTDIR/bin/conda update -y -n jupyter -c conda-forge --all
$CONDA_INSTDIR/bin/conda update -y -n tensorflow -c defaults --all

echo "Update done!"