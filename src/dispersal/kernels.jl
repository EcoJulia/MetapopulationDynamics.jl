abstract type AbstractDispersalKernel end

@kwdef struct DispersalKernel
    func::Function = (x, decay) -> exp(-x * decay)# a function mapping (x, decay) to a value in [0,1]
    decay = 1.0 # a positive real number 
    threshold = 0.01 # cutoff threshold for a value of func to be considered 0
end

function (dk::DispersalKernel)(x)
    f = dk.func(x, dk.decay)
    f > dk.threshold ? f : 0
end
ExponentialDispersalKernel(;
    func = (x, decay) -> exp(-x * decay),
    decay = 1.0,
    threshold = 0.01,
) = DispersalKernel(; func = func, decay = decay, threshold = threshold)
GaussianDispersalKernel(;
    func = (x, decay) -> exp(-(x * decay)^2),
    decay = 1.0,
    threshold = 0.01,
) = DispersalKernel(; func = func, decay = decay, threshold = threshold)

function kernelmatrix(space, kernel)
    distmat = distancematrix(space)
    broadcast(x -> x == 0 ? 0 : kernel(x), distmat)
end

struct DispersalPotential
    matrix::Any
end

function DispersalPotential(kernel::DispersalKernel, space::T) where {T<:AbstractSpace}
    ns = numsites(space)
    kernmat = kernelmatrix(space, kernel)
    mat = zeros(Float32, size(kernmat))

    for i = 1:ns, j = 1:ns
        mat[i, j] = kernmat[i, j] / sum(kernmat[i, :])
    end
    DispersalPotential(mat)
end

Base.getindex(potential::DispersalPotential, i::T, j::T) where {T<:Integer} =
    potential.matrix[i, j]
