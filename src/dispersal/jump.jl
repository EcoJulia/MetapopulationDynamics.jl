

@kwdef struct StochasticJumpDispersalModel{T} <: AbstractDispersalModel
    prob::T = 0.1 # probability an individual disperses in it's lifetime before reproducing
    potential::DispersalPotential =
        DispersalPotential(ExponentialDispersalKernel(), SpatialGraph())
end

@kwdef struct DeterministicJumpDispersalModel{T} <: AbstractDispersalModel
    prob::T = 0.1 # probability an individual disperses in it's lifetime before reproducing
    potential::DispersalPotential =
        DispersalPotential(ExponentialDispersalKernel(), SpatialGraph())
end

params(model::DeterministicJumpDispersalModel) = model.prob, model.potential


function _sim!(
    model::DeterministicJumpDispersalModel,
    sg::SpatialGraph,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {T<:Number}

    delta = similar(newstate)
    p, ϕ = params(model)
    for (i, istate) in enumerate(prevstate)
        for (j, jstate) in enumerate(prevstate)
            if i != j
                itoj = p * istate * ϕ[i, j]
                delta[j] += itoj
                delta[i] -= itoj
            end
        end
    end
    newstate = prevstate .+ delta
    newstate
end
