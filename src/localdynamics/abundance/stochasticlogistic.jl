
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
Base.string(sl::StochasticLogistic) = """
{bold}$(typeof(sl)) <: $(supertype(typeof(sl))){/bold}
{bold}  <: $(supertype(supertype(typeof(sl)))) <: $(supertype(supertype(supertype(typeof(sl))))){/bold}

An {bold}Stochastic Logistic{/bold} model with parameters:

{bold}λ: {/bold}{yellow}$(sl.λ){/yellow}
{bold}K: {/bold}{yellow}$(sl.K){/yellow}
{bold}σ: {/bold}{yellow}$(sl.σ){/yellow}
{bold}dt: {/bold}{yellow}$(sl.dt){/yellow}
"""
Base.show(io::IO, ::MIME"text/plain", sl::StochasticLogistic) = print(
    io,
    string(
        Panel(
            string(sl),
            title = string(typeof(sl)),
            style = "blue dim",
            title_style = "default bright_blue bold",
            padding = (2, 2, 1, 1),
            width = 60,
        ),
    ),
)


params(sl::StochasticLogistic) = sl.λ, sl.K, sl.σ, sl.dt

function _sim!(
    model::StochasticLogistic,
    space::SpatialGraph,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {T<:Real}
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

function _sim!(
    model::StochasticLogistic,
    space::Raster,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {T<:Real}
    λ, K, σ, dt = params(model)
   
end

function _ruleify(model::StochasticLogistic)
    λ, K, σ, dt = params(model)
    neighbors_rule = let  λ=λ, K=K, σ=σ
        Cell() do data, N, I
            logisticgrowth = N > 0 ? λ * N * (1 - (N / K)) : 0
            drift = N > 0 ? rand(Normal(0, N * σ)) : 0
            delta = dt * (drift + logisticgrowth)
            tmp = delta + N
            return tmp > 0 ? tmp : 0
        end
    end
    return neighbors_rule
end