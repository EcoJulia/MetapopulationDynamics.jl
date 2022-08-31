var documenterSearchIndex = {"docs":
[{"location":"vignettes/incidence_function/","page":"-","title":"-","text":"EditURL = \"https://github.com/EcoJulia/MetapopulationDynamics.jl/blob/main/docs/src/vignettes/incidence_function.jl\"","category":"page"},{"location":"overview/#Overview","page":"Overview","title":"Overview","text":"","category":"section"},{"location":"overview/","page":"Overview","title":"Overview","text":"Population dynamics across space, in Julia. ","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"Includes high-performance implementations of classic and modern metapopulation models, raster simulations of populations and occurrence, selection on environmental variables, stochasticity of demography and environment, and more. ","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"AbstractSpace\nRaster\nSpatialGraph\nPatches\nnumsites\ndistancematrix\nModel\nAbstractLocalDynamics\nAbstractOccupancyDynamics\nAbstractAbundanceDynamics\nAbstractDispersalModel\nmodelset\nModelSet\nDispersalKernel\nExponentialDispersalKernel\nGaussianDispersalKernel\nDispersalPotential\nStochasticJumpDispersalModel\nDeterministicJumpDispersalModel\nHanski1994\nLevins1967\nRickerModel\nStochasticLogistic\nsimulate\nsimulate!\nAbundanceOutput\nOccupancyOutput\npcc\nEnvironmentLayer\nEnvironmentLayerSet\nAbstractEnvironmentModel\nOccupancyEnvironmentModel\nAbundanceEnvironmentModel\nnumlayers\nEnvironmentTimeseries","category":"page"},{"location":"overview/#MetapopulationDynamics.AbstractSpace","page":"Overview","title":"MetapopulationDynamics.AbstractSpace","text":"AbstractSpace\n\nAbstract type for spatial domains.\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.Raster","page":"Overview","title":"MetapopulationDynamics.Raster","text":"Raster{T} <: AbstractSpace where T\n\nA Raster is an AbstractSpace consisting of a grid of sites.\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.SpatialGraph","page":"Overview","title":"MetapopulationDynamics.SpatialGraph","text":"SpatialGraph{T} <: AbstractSpace\n\nAn SpatialGraph is anAbstractSpace` that consists of a set of discrete  coordinates.\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.Patches","page":"Overview","title":"MetapopulationDynamics.Patches","text":"Patches <: AbstractSpace\n\nTBD\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.numsites","page":"Overview","title":"MetapopulationDynamics.numsites","text":"numsites(r::Raster)\n\nReturns the number of nodes in a spatial graph.\n\n\n\n\n\nnumsites(sg::SpatialGraph)\n\nReturns the number of nodes in a spatial graph.\n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.distancematrix","page":"Overview","title":"MetapopulationDynamics.distancematrix","text":"distancematrix(r::Raster; distance = Euclidean())\n\nReturns a matrix of pairwise distances for all cells in a Raster \n\n\n\n\n\ndistancematrix(sg::SpatialGraph; distance = Euclidean())\n\nReturns a matrix of pairwise distances for all nodes in a SpatialGraph \n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.AbstractLocalDynamics","page":"Overview","title":"MetapopulationDynamics.AbstractLocalDynamics","text":"abstract type AbstractLocalDynamics <: MetapopulationModel end\n\nAbstract supertype for all models of local dynamics.\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.AbstractOccupancyDynamics","page":"Overview","title":"MetapopulationDynamics.AbstractOccupancyDynamics","text":"abstract type AbstractOccupancyDynamics <: AbstractLocalDynamics end\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.AbstractAbundanceDynamics","page":"Overview","title":"MetapopulationDynamics.AbstractAbundanceDynamics","text":"abstract type AbstractAbundanceDynamics <: AbstractLocalDynamics end\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.AbstractDispersalModel","page":"Overview","title":"MetapopulationDynamics.AbstractDispersalModel","text":"abstract type AbstractDispersalModel <: MetapopulationModel end\n\nAbstract supertype for all dispersal models.\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.modelset","page":"Overview","title":"MetapopulationDynamics.modelset","text":"modelset()\n\nBuilds a ModelSet.\n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.ModelSet","page":"Overview","title":"MetapopulationDynamics.ModelSet","text":"ModelSet{\n    L<:Union{AbstractLocalDynamics,Missing},\n    D<:Union{AbstractDispersalModel,Missing},\n    E<:Union{AbstractEnvironmentModel,Missing},\n}\n\nA set of local, environmental, and dispersal models.\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.DispersalKernel","page":"Overview","title":"MetapopulationDynamics.DispersalKernel","text":"DispersalKernel\n\nA DispersalKernel defines a function that describes the probability of dispersal, with a rate of decay and a threshold, which defines the value at which any result  of func is considered to be 0. \n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.ExponentialDispersalKernel","page":"Overview","title":"MetapopulationDynamics.ExponentialDispersalKernel","text":"ExponentialDispersalKernel\n\nConstructs a DispersalKernel using an exponential function\n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.GaussianDispersalKernel","page":"Overview","title":"MetapopulationDynamics.GaussianDispersalKernel","text":"GaussianDispersalKernel\n\nConstructs a DispersalKernel using an Gaussian function\n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.DispersalPotential","page":"Overview","title":"MetapopulationDynamics.DispersalPotential","text":"DispersalPotential\n\nA dispersal potential is a matrix that contains the pairwise  probability of dispersal between sites in an AbstractSpace.\n\nNote this is a doubly-stochastic matrix, meaning all rows  and columns sum to 0.  \n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.StochasticJumpDispersalModel","page":"Overview","title":"MetapopulationDynamics.StochasticJumpDispersalModel","text":"StochasticJumpDispersalModel{T} <: AbstractDispersalModel\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.DeterministicJumpDispersalModel","page":"Overview","title":"MetapopulationDynamics.DeterministicJumpDispersalModel","text":"DeterministicJumpDispersalModel{T} <: AbstractDispersalModel\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.Hanski1994","page":"Overview","title":"MetapopulationDynamics.Hanski1994","text":"Hanski1994{T<:Real} <: AbstractOccupancyDynamics\n\nAn incidence-function model of metapopulation dynamics, as defined  in Hanski 1994 (citation).\n\nParameters: \n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.Levins1967","page":"Overview","title":"MetapopulationDynamics.Levins1967","text":"Levins1967{T<:Real} <: AbstractOccupancyDynamics\n\nA Levins metapopulatoin model. Two parameters: c and e.\n\nCitation:\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.RickerModel","page":"Overview","title":"MetapopulationDynamics.RickerModel","text":"RickerModel <: AbstractAbundanceDynamics\n\nA AbstractLocalDyanmics model based on Ricker (citation). \n\nDifferent sources of stochasticity: \n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.StochasticLogistic","page":"Overview","title":"MetapopulationDynamics.StochasticLogistic","text":"StochasticLogistic <: AbstractAbundanceDynamics\n\nThe stochastic logistic model, AbstractLocalDynamics. \n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.simulate","page":"Overview","title":"MetapopulationDynamics.simulate","text":"simulate(\n    modelset::M,\n    space::S;\n    numtimesteps = 100,\n) where {M<:ModelSet,S<:AbstractSpace}\n\nSimulation of of ModelSet\n\n\n\n\n\nsimulate(model::M, space::S; numtimesteps = 100) where {M,S<:AbstractSpace}\n\nSimulation of a single Model.\n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.simulate!","page":"Overview","title":"MetapopulationDynamics.simulate!","text":"simulate!(modelset::M, space::S, output) where {M<:ModelSet,S<:AbstractSpace}\n\nSimulation of a ModelSet with an already pre-allocated output.\n\n\n\n\n\nsimulate!(\n    model::M,\n    space::S,\n    output;\n    init = rand(Bernoulli(0.5), numsites(space)),\n) where {M<:AbstractOccupancyDynamics,S<:AbstractSpace}\n\nSimulation of a single AbstractOccupancyDynamics model.\n\n\n\n\n\nsimulate!(\n    model::M,\n    space::SpatialGraph,\n    output;\n    init = rand(Poisson(100), numsites(space)),\n) where {M<:AbstractAbundanceDynamics,S}\n\nSimulation of a single AbstractAbundanceDynamics model.\n\n\n\n\n\n# TODO This should be moved into a different file for dispatch \nspecifically on rasters.\n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.AbundanceOutput","page":"Overview","title":"MetapopulationDynamics.AbundanceOutput","text":"AbundanceOutput\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.OccupancyOutput","page":"Overview","title":"MetapopulationDynamics.OccupancyOutput","text":"OccupancyOutput\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.pcc","page":"Overview","title":"MetapopulationDynamics.pcc","text":"pcc(timeseries)\n\nComputes the mean Pairwise-Crosscorrelation for a timeseries that is an AbundanceOutput.\n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.EnvironmentLayer","page":"Overview","title":"MetapopulationDynamics.EnvironmentLayer","text":"EnvironmentLayer{S,T}\n\nAn environmental layer built on an AbstractSpace. \n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.EnvironmentLayerSet","page":"Overview","title":"MetapopulationDynamics.EnvironmentLayerSet","text":"EnvironmentLayerSet\n\nA set of EnvironmentLayers.\n\n\n\n\n\n","category":"type"},{"location":"overview/#MetapopulationDynamics.numlayers","page":"Overview","title":"MetapopulationDynamics.numlayers","text":"numlayers(els::EnvironmentLayerSet)\n\nReturns the number of layers in an EnvironmentLayerSet.\n\n\n\n\n\n","category":"function"},{"location":"overview/#MetapopulationDynamics.EnvironmentTimeseries","page":"Overview","title":"MetapopulationDynamics.EnvironmentTimeseries","text":"EnvironmentTimeseries{T<:Union{EnvironmentLayer,EnvironmentLayerSet}}\n\nA time-series of EnvironmentLayers or EnvironmentLayerSets.\n\n\n\n\n\n","category":"type"},{"location":"","page":"Index","title":"Index","text":"(Image: )","category":"page"},{"location":"","page":"Index","title":"Index","text":"MetapopulationDynamics is a package for generalizable simulation of population dynamics across space, including models of occurrence, occupancy, and abundance, dispersal, response to environmental conditions, and more. In addition, these models can be run on different geometries (rasters, patches, and spatial we are graphs).","category":"page"},{"location":"","page":"Index","title":"Index","text":"warning: This package is in development\nThe MetapopulationDynamics.jl package is currently under development. The API is not expected to change a lot, but it may change in order to facilitate the integration of new features. Not all functionality is guaranteed to function until the first production release.","category":"page"}]
}
