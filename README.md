
![](./docs/src/assets/mpd_header.png)

[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://ecojulia.github.io/MetapopulationDynamics.jl/dev)

MetapopulationDynamics is a package for generalizable simulation of
population dynamics across space, including models of occurrence,
occupancy, and abundance, dispersal, response to environmental
conditions, and more. In addition, these models can be run on
different geometries (rasters, patches, and spatial graphs). The package includes many 'classic' models from population,
metapopulation, and spatial ecology, but enables extension by allowing
users to define custom models.

[Here's the link to the documentation](https://ecojulia.github.io/MetapopulationDynamics.jl/dev).


> **Warning**
> The MetapopulationDynamics.jl package is currently under development. The API is not expected to change a lot, but it may change in order to facilitate the integration of new features. Not all functionality is guaranteed to function until the first production release.


Here's an simple example that runs the stochastic logistic model on a spatial graph.

```
using MetapopulationDynamics
using NeutralLandscapes

sg = SpatialGraph()
sl = StochasticLogistic(σ=5.)

@time timeseries = simulate(sl, sg)
```
