
"""
    StochasticLogistic <: AbstractAbundanceDynamics

The stochastic logistic model, `AbstractLocalDynamics`. 
"""
@kwdef struct StochasticLogistic <: AbstractAbundanceDynamics
    λ = 2.5
    K = 100.0
    σ = 0.1
    dt = 0.01
end

params(sl::StochasticLogistic) = sl.λ, sl.K, sl.σ, sl.dt

function _sim!(
    model::StochasticLogistic,
    space::S,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {S<:AbstractSpace,T<:Real}
    λ, K, σ, dt = params(model)
    for (i, N) in enumerate(prevstate)
        logisticgrowth = N > 0 ? λ * N * (1 - (N / K)) : 0
        drift = N > 0 ? rand(Normal(0, N * σ)) : 0
        delta = dt * (drift + logisticgrowth)
        tmp = delta + N
        newstate[i] = tmp > 0 ? tmp : 0
    end
    newstate
end
