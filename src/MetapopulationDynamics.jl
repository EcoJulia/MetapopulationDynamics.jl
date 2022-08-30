module MetapopulationDynamics
using Base: @kwdef
using Distances
using Distributions
using StatsBase
using Term
using CodeTracking: @code_string
using UnicodePlots
using DynamicGrids
using ColorSchemes

include(joinpath("models.jl"))
export MetapopulationModel,
    AbstractLocalDynamics,
    AbstractOccupancyDynamics,
    AbstractAbundanceDynamics,
    AbstractDispersalModel

"""
    AbstractSpace

Abstract type for spatial domains.
"""
abstract type AbstractSpace end
export AbstractSpace
include(joinpath("space", "patches.jl"))
include(joinpath("space", "raster.jl"))
include(joinpath("space", "spatialgraph.jl"))
export Raster, SpatialGraph, Patches, numsites, distancematrix


include(joinpath("environment", "layer.jl"))
export EnvironmentLayer
include(joinpath("environment", "niche.jl"))
export AbstractNiche, OccupancyNiche, AbundanceNiche
include(joinpath("environment", "layerset.jl"))
export EnvironmentLayerSet, numlayers
include(joinpath("environment", "timeseries.jl"))
export EnvironmentTimeseries


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

include(joinpath("localdynamics", "occupancy", "extinction.jl"))
export Extinction 
include(joinpath("localdynamics", "occupancy", "colonization.jl"))
export Colonization

include(joinpath("localdynamics", "abundance", "ricker.jl"))
export RickerModel

include(joinpath("localdynamics", "abundance", "stochasticlogistic.jl"))
export StochasticLogistic



include(joinpath("simulate.jl"))
export simulate, simulate!

include(joinpath("outputs.jl"))
export AbstractOutput, AbundanceOutput, OccupancyOutput

include(joinpath("summarizers", "synchrony.jl"))
export pcc

# Load integrations

using Requires
function __init__()
    # If 

    #@require DiffferentialEquations="0c46a032-eb83-5123-abaf-570d42b7fbaaz" 

    @require NeutralLandscapes="71847384-8354-4223-ac08-659a5128069f" include(joinpath("integrations", "neutrallandscapes.jl"))
end


end # module
