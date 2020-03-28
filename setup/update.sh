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
for (_, pkg) in Pkg.dependencies()
    pkg.is_direct_dep && pkg.version !== nothing || continue
    try
        pkg_name = pkg.name
        run(`$JULIA_BIN -e "println(\"$pkg_name\"); @time import $pkg_name"`)
    catch
    end
end
'

$CONDA_INSTDIR/bin/conda update -y -n base -c defaults conda
$CONDA_INSTDIR/bin/conda update -y -n base -c defaults --all
$CONDA_INSTDIR/bin/conda update -y -n jupyter -c conda-forge --all
$CONDA_INSTDIR/bin/conda update -y -n python  -c pytorch -c defaults --all

echo "Update done!"