

@kwdef struct StochasticJumpDispersalModel{T} <: AbstractDispersalModel
    prob::T = 0.1 # probability an individual disperses in it's lifetime before reproducing
    potential::DispersalPotential =
        DispersalPotential(ExponentialDispersalKernel(), SpatialGraph())
end
params(model::StochasticJumpDispersalModel) = model.prob, model.potential

function _sim!(
    model::StochasticJumpDispersalModel,
    sg::SpatialGraph,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {T<:Number}

    delta = similar(newstate)
    p, ϕ = params(model)
    for (i, istate) in enumerate(prevstate)
        num_leaving_i = rand(Binomial(istate, p))
        possibletargs = filter!(x->x!=i, [i for i in 1:numsites(sg)])
        realizedtargs = num_leaving_i < length(possibletargs) ? sample(possibletargs, num_leaving_i, replace=false) : possibletargs
        for j in realizedtargs
            delta[j] += 1
        end
        delta[i] -= num_leaving_i
    end
    newstate = prevstate .+ delta
    newstate
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
