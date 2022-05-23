abstract type AbstractDispersalKernel end

@kwdef struct DispersalKernel where T,V
    func::Function # a function mapping (x, decay) to a value in [0,1]
    decay::T # a positive real number 
    threshold::V # cutoff threshold for a value of func to be considered 0
end

ExponentialDispersalKernel(; func= (x, decay) -> exp(-x*decay), kwawgs...) = DispersalKernel(; func=func, kwargs...)
GaussianDispersalKernel(; func= (x, decay) -> exp(-(x*decay)^2), kwawgs...) = DispersalKernel(; func=func, kwargs...)