@kwdef struct SpatialGraph{T} <: AbstractSpace where T
    coordinates::Vector{Tuple{T,T}} = [(x[1], x[2]) for x in [rand(2)]  for _ in 1:20]
end 

coordinates(sg::SpatialGraph) = sg.coordinates
numsites(sg::SpatialGraph) = length(coordinates(sg))