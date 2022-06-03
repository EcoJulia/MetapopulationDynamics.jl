module MetapopulationDynamics
using Base: @kwdef
using Distances
using Distributions

abstract type AbstractSpace end
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


include(joinpath("simulate.jl"))
export simulate, simulate!

end # module
