"""

    Arbitrary C_i function supplied by user 
"""

struct Extinction{P,T<:AbstractNiche} <: AbstractOccupancyDynamics
    probability::P
    niche::Union{T, Missing}
end

params(model::Extinction) =
    model.probability, model.niche

"""
    _sim!

This dispatch should occur on a file that is for after simulate! abundance/occ
"""
function _sim!(
    model::M,
    space::S,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {M<:Extinction,S<:AbstractSpace,T<:Real}
    probability, niche = params(model)

    for (i, st) in enumerate(prevstate)
        weighted_prob = fitness(niche, i)
        ns = st == 1 ? !(rand() <= weighted_prob) : st
        newstate[i] = ns
    end
    newstate
end