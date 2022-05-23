module MetapopulationDynamics
    using Base: @kwdef
    using Distributions 

    abstract type AbstractSpace end
    include(joinpath("space", "patches.jl"))
    include(joinpath("space", "raster.jl"))
    include(joinpath("space", "spatialgraph.jl"))
    export Raster, SpatialGraph, Patches, numsites
    


    abstract type AbstractDynamics end 
    abstract type AbstractOccupancyDynamics <: AbstractDynamics end 
    abstract type AbstractAbundanceDynamics <: AbstractDynamics end 

    include(joinpath("localdynamics", "levins", "levins1967.jl"))
    export Levins1967

    include(joinpath(joinpath("simulate.jl")))
    export simulate, simulate!

end # module
