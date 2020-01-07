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
    "Flux",
    "Distributions",
    "Images",
    "ImageMagick",
    "BSON",
    "Plots",
    "PyPlot",
]

if hw_platform == "gpu"
    push!(deps, "CuArrays")
end

ENV["PYTHON"] = joinpath(ENV["CONDA_INSTDIR"], "envs", "julia", "bin", "python")

Pkg.add(deps)

Pkg.API.precompile()

for m in deps
    try
        eval(Meta.parse(string("import ", m)))
    catch
    end
end

println("\nSetup done.")
