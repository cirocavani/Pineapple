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
    PackageSpec("IJulia"),
    PackageSpec("DataFrames"),
    PackageSpec("PrettyTables"),
    PackageSpec("DataStructures"),
    PackageSpec("Distributions"),
    PackageSpec("Images"),
    PackageSpec("ImageMagick"),
    PackageSpec("BSON"),
    PackageSpec("CSV"),
    PackageSpec("Plots"),
    PackageSpec("PyPlot"),
    PackageSpec("Flux"),
    PackageSpec("Zygote"),
    PackageSpec(url="https://github.com/cirocavani/Gym.jl"),
]

if hw_platform == "gpu"
    append!(deps, [
        PackageSpec("CUDA"),
    ])
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
        run(`$JULIA_BIN -e "println(\"$pkg_name\"); @time import $pkg_name"`)
    catch
    end
end

println("\nSetup done.")
