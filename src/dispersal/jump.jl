

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

    delta = zeros(size(newstate))
    p, ϕ = params(model)
    for (i, istate) in enumerate(prevstate)
        if istate > 0 && sum(ϕ.matrix[i, :]) > 0
            num_leaving_i = min(rand(Binomial(floor(istate), p)), Int32(floor(istate)))
            realizedtargs = rand(Categorical(ϕ.matrix[i, :]), num_leaving_i)
            #@info num_leaving_i, realizedtargs
            for j in realizedtargs
                delta[j] += 1
            end
            delta[i] -= num_leaving_i
        end
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
    np = length(newstate)
    p, ϕ = params(model)

    diffusionmatrix = zeros(np,np)
    for (i, istate) in enumerate(prevstate)
        for (j, jstate) in enumerate(prevstate)
            diffusionmatrix[i,j] = i == j ? 1-p : ϕ[i,j] * p
        end
    end
    newstate = diffusionmatrix*prevstate
    @info newstate
    newstate
end
