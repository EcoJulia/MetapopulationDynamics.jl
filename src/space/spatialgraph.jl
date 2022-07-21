"""
    SpatialGraph{T} <: AbstractSpace

An `SpatialGraph is an `AbstractSpace` that consists of a set of discrete 
coordinates.
"""

@kwdef struct SpatialGraph{T} <: AbstractSpace where {T}
    coordinates::Vector{Tuple{T,T}} = [(rand(), rand()) for _ = 1:20]
end
SpatialGraph(n::Integer) = SpatialGraph([(rand(), rand()) for _ = 1:n])

"""
    numsites(sg::SpatialGraph) 

Returns the number of nodes in a spatial graph.
"""
numsites(sg::SpatialGraph) = length(coordinates(sg))
coordinates(sg::SpatialGraph) = sg.coordinates


function _spatialgraph_to_text(sg)
    str = string(
        scatterplot(
            [x[1] for x in sg.coordinates],
            [x[2] for x in sg.coordinates],
            xlim = (0, 1),
            ylim = (0, 1),
        ),
    )
    replace(str, "." => "[green].[/green]")
end

Base.string(sg::SpatialGraph) = """
[bold]$(typeof(sg)) <: $(supertype(typeof(sg)))[/bold]

An [bold]spatial graph[/bold] with [bold][yellow]$(length(sg.coordinates))[/yellow][/bold] locations.

"""

Base.show(io::IO, ::MIME"text/plain", sg::SpatialGraph) = print(
    io,
    string(
        Panel(
            string(sg),
            title = string(typeof(sg)),
            style = "green dim",
            title_style = "default green bold",
            padding = (2, 2, 1, 1),
            width = 60,
            Panel(_spatialgraph_to_text(sg), style = "green", width = 60),
        ),
    ),
)



"""
    distancematrix(sg::SpatialGraph; distance = Euclidean())
    
Returns a matrix of pairwise distances for all nodes in a `SpatialGraph` 
"""
function distancematrix(sg::SpatialGraph; distance = Euclidean())
    distmat = zeros(numsites(sg), numsites(sg))

    for i = 1:numsites(sg), j = 1:numsites(sg)
        x, y = sg.coordinates[i], sg.coordinates[j]
        distmat[i, j] = evaluate(distance, (x[1], x[2]), (y[1], y[2]))
    end
    distmat
end
