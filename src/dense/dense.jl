function char_to_magmaInt(option::AbstractChar)
    if option == 'A'
        return MagmaAllVec
    elseif option == 'S'
        return MagmaSomeVec
    elseif option == 'O'
        return MagmaOverwriteVec
    elseif option == 'V'
        return MagmaVec
    elseif option == 'N'
        return MagmaNoVec
    end
end
function char_to_magmaIntUplo(option::AbstractChar)
    if option == 'U'
        return MagmaUpper
    elseif option == 'L'
        return MagmaLower
    end
end

subsetrows(X::AbstractVector, Y::AbstractArray, k) = Y[1:k]
subsetrows(X::AbstractMatrix, Y::AbstractArray, k) = Y[1:k, :]

include("svd.jl")
include("linearsystemsolver.jl")
include("eigen.jl")