using Documenter, MetapopulationDynamics
import Literate

# For GR docs bug
ENV["GKSwstype"] = "100"

vignettes = filter(
    endswith(".jl"),
    readdir(joinpath(@__DIR__, "src", "vignettes"); join = true, sort = true),
)
for vignette in vignettes
    Literate.markdown(
        vignette,
        joinpath(@__DIR__, "src", "vignettes");
        config = Dict("credit" => false, "execute" => true),
    )
end

makedocs(;
    sitename = "MetapopulationDynamics",
    authors = "Michael D. Catchen",
    modules = [MetapopulationDynamics],
    pages = [
        "Index" => "index.md",
        "Overview" => "overview.md",
        "Vignettes" => [
            "Incidence-Function (Hanski 1994) model" => "./incidence_function.md",
        ],
        "Documentation" => [
            "Space" => [
                "Rasters" => "./documentation/space/raster.md", 
                "Spatial graphs" => "./documentation/spaces/spatialgraph.md"
            ],
            "Models" => [
                "Occupancy" => "./documentations/models/occupancy.md",
                "Abundance" => "./documentation/models/abundance.md"
            ],
            "Simulation" => [
                "Simulation" => "./documentations/simulation/simulation.md"
            ]
        ]
    ],
    checkdocs = :all,
)

deploydocs(;
    deps = Deps.pip("pygments", "python-markdown-math"),
    repo = "github.com/EcoJulia/MetapopulationDynamics.jl.git",
    devbranch = "main",
    push_preview = true,
)
