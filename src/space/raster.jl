"""
    Raster{T} <: AbstractSpace where T

A `Raster` is an `AbstractSpace` consisting of a grid of sites.
"""
struct Raster{T} <: AbstractSpace where T
    matrix::Matrix{T}
end

Base.size(r::Raster) = size(r.matrix)
"""
    numsites(r::Raster) 

Returns the number of nodes in a spatial graph.
"""
numsites(r::Raster) = prod(size(r.matrix))
coordinates(r::Raster) = CartesianIndices(size(r))

"""
    distancematrix(r::Raster; distance = Euclidean())

Returns a matrix of pairwise distances for all cells in a `Raster` 
"""
function distancematrix(r::Raster; distance = Euclidean())
    distmat = zeros(numsites(r), numsites(r))
    ci = coordinates(r)
    for i = 1:numsites(r), j = 1:numsites(r)
        x,y = ci[i], ci[j]
        distmat[i, j] = evaluate(distance, (x[1], x[2]), (y[1], y[2]))
    end
    distmat
end




Base.string(r::Raster) = """
[bold]$(typeof(r)) <: $(supertype(typeof(r)))[/bold]

An [bold]spatial graph[/bold] with [bold][yellow]$(numsites(r)))[/yellow][/bold] locations.

"""

Base.show(io::IO, ::MIME"text/plain", r::Raster) = print(
    io,
    string(
        Panel(
            #string(r),
            title = string(typeof(r)),
            style = "green dim",
            title_style = "default green bold",
            padding = (2, 2, 1, 1),
            width = 60,
            #Panel(r.matrix, style = "green", width = 60),
        ),
    ),
)

