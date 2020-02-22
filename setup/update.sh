#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "Updating..."

$JULIA_INSTDIR/bin/julia -e '
import Pkg
Pkg.update()
Pkg.gc()
JULIA_BIN = joinpath(ENV["JULIA_INSTDIR"], "bin", "julia")
for pkg_name in keys(Pkg.installed())
    try
        run(`$JULIA_BIN -e "println(\"$pkg_name\"); import $pkg_name"`)
    catch
    end
end
'

$CONDA_INSTDIR/bin/conda update -y -n base -c defaults conda
$CONDA_INSTDIR/bin/conda update -y -n base -c defaults --all
$CONDA_INSTDIR/bin/conda update -y -n jupyter -c conda-forge --all
$CONDA_INSTDIR/bin/conda update -y -n python -c defaults --all

echo "Update done!"