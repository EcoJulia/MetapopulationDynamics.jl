"""
    simulate(
        modelset::M,
        space::S;
        numtimesteps = 100,
    ) where {M<:ModelSet,S<:AbstractSpace}

Simulation of of `ModelSet`
"""
function simulate(
    modelset::M,
    space::S;
    numtimesteps = 100,
) where {M<:ModelSet,S<:AbstractSpace}
    output = zeros(Float32, numsites(space), numtimesteps)
    simulate!(modelset, space, output)
    AbundanceOutput(output)
end


"""
    simulate(model::M, space::S; numtimesteps = 100) where {M,S<:AbstractSpace}

Simulation of a single `Model`.
"""
function simulate(model::M, space::S; numtimesteps = 100) where {M,S<:AbstractSpace}
    output = zeros(Float32, numsites(space), numtimesteps)
    simulate!(model, space, output)
end

_initcondition(::AbstractAbundanceDynamics, space; λ = 100) =
    rand(Poisson(λ), numsites(space))
_initcondition(::AbstractOccupancyDynamics, space; p = 0.3) =
    rand(Bernoulli(p), numsites(space))

"""
    ! TODO: this function shouldn't dispatch at all on missing env,
    this should be @info'd 
"""
_sim!(::Missing, space, oldarray, newarray) = oldarray

"""
    simulate!(modelset::M, space::S, output) where {M<:ModelSet,S<:AbstractSpace}

Simulation of a `ModelSet` with an already pre-allocated `output`.
"""
function simulate!(modelset::M, space::S, output) where {M<:ModelSet,S<:AbstractSpace}
    nt = size(output, 2)
    init = _initcondition(modelset.localdynamics, space)
    output[:, begin] .= init
    for t = 2:nt
        # need to think aobut order and memory here
        output[:, t] .= _sim!(modelset.environment, space, output[:, t-1], output[:, t])
        output[:, t] .= _sim!(modelset.localdynamics, space, output[:, t], output[:, t])
        output[:, t] .= _sim!(modelset.dispersal, space, output[:, t], output[:, t])

    end
end

"""
    simulate!(
        model::M,
        space::S,
        output;
        init = rand(Bernoulli(0.5), numsites(space)),
    ) where {M<:AbstractOccupancyDynamics,S<:AbstractSpace}

Simulation of a single `AbstractOccupancyDynamics` model.
""" 
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

    OccupancyOutput(output)
end


"""
    simulate!(
        model::M,
        space::SpatialGraph,
        output;
        init = rand(Poisson(100), numsites(space)),
    ) where {M<:AbstractAbundanceDynamics,S}

Simulation of a single `AbstractAbundanceDynamics` model.
""" 
function simulate!(
    model::M,
    space::SpatialGraph,
    output;
    init = rand(Poisson(100), numsites(space)),
) where {M<:AbstractAbundanceDynamics}
    nt = size(output, 2)
    output[:, begin] .= init
    for t = 2:nt
        output[:, t] .= _sim!(model, space, output[:, t-1], output[:, t])
    end

    # compute params 
    # params = (...)
    # AbundanceOutput(output, model, space)
    AbundanceOutput(output)
end

# Wastes an allocation, fix later by avoiding simulate! call

"""
    # TODO This should be moved into a different file for dispatch 
    specifically on rasters.

"""
function simulate!(
    model::M,
    space::Raster,
    output;
    init = rand(Exponential(100), numsites(space)),
) where {M<:AbstractAbundanceDynamics}
    nt = size(output, 2)

    # pass model M to ruleify()
    # setup output 
    # cal DG.sim!
    rule = ruleify(model)

    out = ArrayOutput(Float32.(init),tspan=1:nt)
    simout = sim!(out, rule)  

    abdout = hcat([vec(simout.frames[t]) for t in 1:nt]...)
    AbundanceOutput(abdout)
end
