using Documenter, NeutralLandscapes

# For GR docs bug
ENV["GKSwstype"] = "100"

makedocs(
    sitename="MetapopulationDynamics.jl",
    authors="Michael Catchen",
    modules=[MetapopulationDynamics],
    pages=[
        "Index" => "index.md",
        ],
    checkdocs=:all,
    strict=true,
)

deploydocs(
    deps=Deps.pip("pygments", "python-markdown-math"),
    repo="github.com/EcoJulia/MetapopulationDyanmics.jl.git",
    devbranch="main",
    push_preview=true
)