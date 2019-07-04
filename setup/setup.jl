println("Setup...\n")

using Pkg

Pkg.instantiate()

deps = [
    "IJulia",
    "Flux",
]

Pkg.add.(deps)
#Pkg.build("IJulia")

Pkg.add("CUDAapi")
import CUDAapi

toolkit_dirs = CUDAapi.find_toolkit()
cuda_lib = CUDAapi.find_cuda_library("cuda", toolkit_dirs)

Pkg.rm("CUDAapi")

if cuda_lib === nothing
    println("CUDA not found!")
else
    println("CUDA found!")
    Pkg.add("CuArrays")
end

println("\nSetup done.")
