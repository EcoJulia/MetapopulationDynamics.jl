
abstract type RickerModelType end

struct DemographicStochasticity end
struct DemographicHeterogeneity end

@kwdef struct RickerModel <: AbstractAbundanceDynamics
    λ = 1.5
    α = 0.003
end

params(rm::RickerModel) = rm.λ, rm.α

function _sim!(
    model::RickerModel,
    space::S,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {S<:AbstractSpace,T<:Real}
    λ, α = params(model)
    for (i, st) in enumerate(prevstate)
        mn = st * λ * exp(-α * st)
        tmp = mn > 0 ? rand(Poisson(mn)) : 0
        newstate[i] = tmp
    end
    newstate
end
