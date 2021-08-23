using MAGMA
using Test, Random, LinearAlgebra, CUDA

using Test, LinearAlgebra, CUDA

@testset "dense linear algebra" begin
    include("dense/svd.jl")
    include("dense/linearsystemsolver.jl")
    include("dense/eigen.jl")
end
