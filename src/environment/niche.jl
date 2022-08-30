
abstract type AbstractNiche end 

"""
    OccupancyEnvironmentModel 

layer: 

`niche`: A function that is defined over
(min(layer), max(layer)) that sum to 1 over
that interval and at a particular value on
that domain, x, niche(x) returns the probability
that an observed occurrence would occur at a location
with environment value x. 
"""
struct OccupancyNiche{T<:AbstractSpace} <: AbstractNiche
    layer::EnvironmentLayer{T}
    fitness::Function # absolute fitness, [0,1]
end


# OccupancyNiche(space::Type{T}) where {T<:AbstractSpace} = Occuap



"""
    AbundanceEnvironmentModel 

layer:

`niche`: A function that is defined over
        (min(layer), max(layer)) that gives a 
        multiplicative constant on [0, ∞) of what the actual
        growth in a location with environmental value x is, e.g.
        
        True Growth at location i = niche(x) * Intrinsic Growth 
"""
struct AbundanceNiche{T<:AbstractSpace} <: AbstractNiche
    layer::EnvironmentLayer{T}
    fitness::Function  # relative fitness, [0, ∞), mean 1.0
end


"""
    fitness(niche::N, i) 
"""
fitness(niche::N, i) where N<:AbstractNiche = niche.fitness(niche.layer[i])
