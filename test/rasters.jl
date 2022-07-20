using MetapopulationDynamics
using Test

r = Raster(zeros(50,50))
@test typeof(r) <: AbstractSpace 