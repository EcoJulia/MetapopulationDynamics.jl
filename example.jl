using MetapopulationDynamics
using Plots

sg = SpatialGraph()
sjdm = StochasticJumpDispersalModel(
    0.8,
    DispersalPotential(ExponentialDispersalKernel(decay = 0.5, threshold = 10^-4), sg),
)
rm = RickerModel()

fullmodel = modelset(sjdm, rm)

results = simulate(fullmodel, sg)

plt = plot(legend = :outerright, xlabel = "time", ylabel = "Abundance")
for i = 1:size(results, 1)
    plot!(1:size(results, 2), results[i, :], label = "Pop $i")
end
plt
