struct Levins1967{T<:Real} <: AbstractOccupancyDynamics
    c::T
    e::T
end

params(model::M) where {M<:Levins1967} = model.c, model.e

function _sim(model::M, space::S, prevstate::Vector{T}) where {M<:Levins1967,S<:AbstractSpace,T<:Real}
    c, e = params(model)
    newstate = similar(prevstate)
    for (i,st) in enumerate(prevstate)
        ns = st == 1 ? !(rand() <= e) : rand() <= c
        newstate[i] = ns
    end
    newstate
end

