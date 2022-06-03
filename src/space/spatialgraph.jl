@kwdef struct SpatialGraph{T} <: AbstractSpace where {T}
    coordinates::Vector{Tuple{T,T}} = [(rand(), rand()) for _ = 1:20]
end

coordinates(sg::SpatialGraph) = sg.coordinates
numsites(sg::SpatialGraph) = length(coordinates(sg))
SpatialGraph(n::Integer) = SpatialGraph([(rand(), rand()) for _ = 1:n])

function distancematrix(sg::SpatialGraph; distance = Euclidean())
    distmat = zeros(numsites(sg), numsites(sg))

    for i = 1:numsites(sg), j = 1:numsites(sg)
        x, y = sg.coordinates[i], sg.coordinates[j]
        distmat[i, j] = evaluate(distance, (x[1], x[2]), (y[1], y[2]))
    end
    distmat
end
