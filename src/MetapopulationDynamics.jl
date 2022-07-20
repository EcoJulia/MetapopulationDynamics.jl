module MetapopulationDynamics
using Base: @kwdef
using Distances
using Distributions
using StatsBase
using Term
using CodeTracking: @code_string
using UnicodePlots

abstract type AbstractSpace end
export AbstractSpace
include(joinpath("space", "patches.jl"))
include(joinpath("space", "raster.jl"))
include(joinpath("space", "spatialgraph.jl"))
export Raster, SpatialGraph, Patches, numsites, distancematrix

include(joinpath("models.jl"))
export Model,
    AbstractLocalDynamics,
    AbstractOccupancyDynamics,
    AbstractAbundanceDynamics,
    AbstractDispersalModel

include(joinpath("modelset.jl"))
export modelset, ModelSet

include(joinpath("dispersal", "kernels.jl"))
export DispersalKernel,
    ExponentialDispersalKernel, GaussianDispersalKernel, DispersalPotential, kernelmatrix

include(joinpath("dispersal", "jump.jl"))
export StochasticJumpDispersalModel, DeterministicJumpDispersalModel

include(joinpath("localdynamics", "occupancy", "levins1967.jl"))
include(joinpath("localdynamics", "occupancy", "incidencefunction.jl"))
export Hanski1994, Levins1967

include(joinpath("localdynamics", "abundance", "ricker.jl"))
export RickerModel

include(joinpath("localdynamics", "abundance", "stochasticlogistic.jl"))
export StochasticLogistic



include(joinpath("simulate.jl"))
export simulate, simulate!

include(joinpath("outputs.jl"))
export AbstractOutput, AbundanceOutput, OccupancyOutput

include(joinpath("summarizers", "synchrony.jl"))
export computepcc

include(joinpath("environment", "layer.jl"))
export EnvironmentLayer
include(joinpath("environment", "model.jl"))
export OccupancyEnvironmentModel, AbundanceEnvironmentModel
include(joinpath("environment", "layerset.jl"))
export EnvironmentLayerSet, numlayers

include(joinpath("environment", "timeseries.jl"))
export EnvironmentTimeseries


# Load integrations

using Requires
function __init__()
    @info "Loading NeutralLandscapes.jl support..."
    @require NeutralLandscapes="71847384-8354-4223-ac08-659a5128069f" include(joinpath("integrations", "neutrallandscapes.jl"))
end


end # module
