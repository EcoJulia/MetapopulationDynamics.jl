using MetapopulationDynamics
using Plots

sl = StochasticLogistic(dt = 0.01, σ = 1.0)
rm = RickerModel()


sg = SpatialGraph()
djdm = DeterministicJumpDispersalModel(
    0.8,
    DispersalPotential(ExponentialDispersalKernel(decay = 10.0, threshold = 0.01), sg),
)

sjdm = StochasticJumpDispersalModel(
    0.1,
    DispersalPotential(ExponentialDispersalKernel(decay = 1, threshold = 0.01), sg),
)
fullmodel = modelset(djdm, rm)
results = simulate(fullmodel, sg; numtimesteps = 100)
computepcc(results)

plt = plot(legend = :outerright, xlabel = "time", ylabel = "Abundance")
for i = 1:size(results.timeseries, 1)
    plot!(1:size(results.timeseries, 2), results.timeseries[i, :], label = "Pop $i")
end
plt
