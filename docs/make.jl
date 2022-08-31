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
        "Vignettes" => [
            "Overview" => "./overview.md",
        ],
    ],
    checkdocs = :all,
)

deploydocs(;
    deps = Deps.pip("pygments", "python-markdown-math"),
    repo = "github.com/EcoJulia/MetapopulationDynamics.jl.git",
    devbranch = "main",
    push_preview = true,
)


Uᵢ = ∑ⱼ Cov(i,j)