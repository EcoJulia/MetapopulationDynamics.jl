function simulate(
    modelset::M,
    space::S;
    numtimesteps = 100,
) where {M<:ModelSet,S<:AbstractSpace}
    output = zeros(Float32, numsites(space), numtimesteps)
    simulate!(modelset, space, output)
    output
end


function simulate(model::M, space::S; numtimesteps = 100) where {M,S<:AbstractSpace}
    output = zeros(Float32, numsites(space), numtimesteps)
    simulate!(model, space, output)
    output
end

_initcondition(::AbstractAbundanceDynamics, space; λ = 30) =
    rand(Poisson(λ), numsites(space))
_initcondition(::AbstractOccupancyDynamics, space; p = 0.3) =
    rand(Bernoulli(p), numsites(space))

_sim!(::Missing, space, oldarray, newarray) = oldarray

function simulate!(modelset::M, space::S, output) where {M<:ModelSet,S<:AbstractSpace}
    nt = size(output, 2)
    init = _initcondition(modelset.localdynamics, space)
    output[:, begin] .= init
    for t = 2:nt
        # need to think aobut order and memory here
        output[:, t] .= _sim!(modelset.environment, space, output[:, t-1], output[:, t])
        output[:, t] .= _sim!(modelset.dispersal, space, output[:, t], output[:, t])
        output[:, t] .= _sim!(modelset.localdynamics, space, output[:, t], output[:, t])
    end
    output
end


function simulate!(
    model::M,
    space::S,
    output;
    init = rand(Bernoulli(0.5), numsites(space)),
) where {M<:AbstractOccupancyDynamics,S<:AbstractSpace}
    nt = size(output, 2)
    output[:, begin] .= init
    for t = 2:nt
        output[:, t] .= _sim!(model, space, output[:, t-1], output[:, t])
    end
end

function simulate!(
    model::M,
    space::S,
    output;
    init = rand(Poisson(30), numsites(space)),
) where {M<:AbstractAbundanceDynamics,S<:AbstractSpace}
    nt = size(output, 2)
    output[:, begin] .= init
    for t = 2:nt
        output[:, t] .= _sim!(model, space, output[:, t-1], output[:, t])
    end
end
