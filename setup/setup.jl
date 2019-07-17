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
    "Statistics",
    "Distributions",
    "Images",
    "ImageMagick",
]

if hw_platform == "gpu"
    push!(deps, "CuArrays")
end

Pkg.add(deps)
#Pkg.build("IJulia")

Pkg.API.precompile()

println("\nSetup done.")
