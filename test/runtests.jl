using Test, SafeTestsets

@time @safetestset "spatial graphs" begin include("spatialgraphs.jl") end
@time @safetestset "rasters" begin include("rasters.jl") end
@time @safetestset "Levins 1967" begin include("levins1967.jl") end
@time @safetestset "Hanski 1994" begin include("hanski1994.jl") end
@time @safetestset "Occupancy environmental model" begin include("environment_occupancy.jl") end
@time @safetestset "Abundance environmental model" begin include("environment_abundance.jl") end
@time @safetestset "Ricker model" begin include("ricker.jl") end
@time @safetestset "Stochastic logistic model" begin include("stochasticlogistic.jl") end
@time @safetestset "Jump dispersal" begin include("jumpdispersal.jl") end
