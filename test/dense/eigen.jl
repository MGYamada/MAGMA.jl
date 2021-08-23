@testset "test eigen $T by syevd $interface" for T in [Float32, Float64, ComplexF32, ComplexF64], interface in ["CPU", "GPU"]

    # randomly generate a 2 by 2 matrix for testing
    size = 2
    matrixToTest = rand(T, size, size)
    matrixToTest .+= matrixToTest'

    # use the default Linear Algebra lib to calculate the right answer for testing
    right_answer = eigvals(matrixToTest)
    S = right_answer

    # to test the GPU interface, one should convert the matrix data to cuda
    if interface == "GPU"
        matrixToTest = CuArray(matrixToTest)
    end

    # initialize the MAGMA lib, serving as a necessary part before working
    magma_init()

    # call the basic (overloaded) wrapper gesvd! for syevd subroutines
    result = magma_syevd!('V','U',matrixToTest)

    # in the result, the wanted answer lies in the second position
    s = result[1]

    # finalize the MAGMA lib, serving as a necessary part after working
    magma_finalize()

    # if S is approximately equal to s, we defined then it's alright
    @test S ≈ s

end
