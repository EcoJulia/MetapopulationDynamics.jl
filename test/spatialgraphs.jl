using MetapopulationDynamics
using Test

sg = SpatialGraph()
@test typeof(sg) <: AbstractSpace 