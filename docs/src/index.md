# NeutralLandscapes.jl

Population dynamics across space, in Julia. 

Includes high-performance implementations of classic and modern metapopulation models,
raster simulations of populations and occurrence, selection on environmental variables,
stochasticity of demography and environment, and more. 

```@docs
AbstractSpace
Raster
SpatialGraph
Patches
numsites
distancematrix
Model
AbstractLocalDynamics
AbstractOccupancyDynamics
AbstractAbundanceDynamics
AbstractDispersalModel
modelset
ModelSet
DispersalKernel
ExponentialDispersalKernel
GaussianDispersalKernel
DispersalPotential
StochasticJumpDispersalModel
DeterministicJumpDispersalModel
Hanski1994
Levins1967
RickerModel
StochasticLogistic
simulate
simulate!
AbundanceOutput
OccupancyOutput
pcc
EnvironmentLayer
OccupancyEnvironmentModel
AbundanceEnvironmentModel
numlayers
EnvironmentTimeseries
```
