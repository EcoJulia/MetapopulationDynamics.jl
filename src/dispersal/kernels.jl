abstract type AbstractDispersalKernel end

@kwdef struct DispersalKernel
    func::Function = (x, decay) -> exp(-x * decay)# a function mapping (x, decay) to a value in [0,1]
    decay = 1.0 # a positive real number 
    threshold = 0.01 # cutoff threshold for a value of func to be considered 0
end
Base.string(kern::DispersalKernel) = """
[bold]Kernel: [/bold][green]$(kern.func)[/green]
[bold]Decay: [/bold][yellow]$(kern.decay)[/yellow]
[bold]Threshold: [/bold][yellow]$(kern.threshold)[/yellow]
"""
Base.show(io::IO, ::MIME"text/plain", kern::DispersalKernel) = print(
    io,
    string(
        Panel(
            string(kern);
            title = string(typeof(kern)),
            style = "#a686eb  dim",
            title_style = "default #a686eb bold",
            width = 25,
            padding = (2, 2, 1, 1),
        ),
    ),
)


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
        if (sum(kernmat[i, :]) > 0)
            mat[i, j] = kernmat[i, j] / sum(kernmat[i, :])
        end
    end
    DispersalPotential(mat)
end

Base.getindex(potential::DispersalPotential, i::T, j::T) where {T<:Integer} =
    potential.matrix[i, j]
