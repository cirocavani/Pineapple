println("Setup...\n")

hw_platform = "cpu"
if length(ARGS) > 0
    hw_platform = ARGS[1]
end
if hw_platform ∉ ["cpu", "gpu"]
    println("Hardware platform unknown ('cpu' or 'gpu'): '", hw_platform, "'\n")
    exit(-1)
end

println("Hardware platform: '", hw_platform, "'\n")

using Pkg

Pkg.instantiate()

deps = [
    "IJulia",
    "DataFrames",
    "PrettyTables",
    "DataStructures",
    "Distributions",
    "Images",
    "ImageMagick",
    "BSON",
    "CSV",
    "Plots",
    "PyPlot",
    "Flux",
    "Zygote",
    "Gym",
]

if hw_platform == "gpu"
    append!(deps, ["CUDAdrv", "CUDAnative", "CuArrays"])
end

ENV["PYTHON"] = joinpath(ENV["CONDA_INSTDIR"], "envs", "python", "bin", "python")

Pkg.add(deps)

# Precompiling
Pkg.update()
Pkg.gc()
JULIA_BIN = joinpath(ENV["JULIA_INSTDIR"], "bin", "julia")
for (_, pkg) in Pkg.dependencies()
    pkg.is_direct_dep && pkg.version !== nothing || continue
    try
        pkg_name = pkg.name
        run(`$JULIA_BIN -e "println(\"$pkg_name\"); import $pkg_name"`)
    catch
    end
end

println("\nSetup done.")
