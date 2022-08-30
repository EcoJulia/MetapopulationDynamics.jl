"""

    Arbitrary C_i function supplied by user 
"""

@kwdef struct Colonization{P,T<:AbstractNiche} <: AbstractLocalDynamics
    probability::P = 0.1
    niche::Union{T, Missing} = OccupancyNiche()
end



params(model::M) where {M<:Hanski1994} =
    model.c, model.e, model.α, model.x, model.A, model.kernel

"""
    _sim!

This dispatch should occur on a file that is for after simulate! abundance/occ
"""
function _sim!(
    model::M,
    space::S,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {M<:Colonization,S<:AbstractSpace,T<:Real}
    c, e = params(model)
    for (i, st) in enumerate(prevstate)
        ns = st == 1 ? !(rand() <= e) : rand() <= c
        newstate[i] = ns
    end
    newstate
end
