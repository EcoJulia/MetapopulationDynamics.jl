module MetapopulationDynamics
    using Base: @kwdef
    using Distances
    using Distributions 

    abstract type AbstractSpace end
    include(joinpath("space", "patches.jl"))
    include(joinpath("space", "raster.jl"))
    include(joinpath("space", "spatialgraph.jl"))
    export Raster, SpatialGraph, Patches, numsites, distancematrix
    


    abstract type AbstractDynamics end 
    abstract type AbstractOccupancyDynamics <: AbstractDynamics end 
    abstract type AbstractAbundanceDynamics <: AbstractDynamics end 

    include(joinpath("localdynamics", "occupancy", "levins1967.jl"))
    export Levins1967

    include(joinpath("localdynamics", "occupancy", "incidencefunction.jl"))
    export Hanski1994

    include(joinpath("dispersal","kernels.jl"))
    export DispersalKernel, ExponentialDispersalKernel, GaussianDispersalKernel

    include(joinpath(joinpath("simulate.jl")))
    export simulate, simulate!


    include(joinpath(joinpath("simulate.jl")))
    export simulate, simulate!

end # module
