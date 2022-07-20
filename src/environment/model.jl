

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
struct OccupancyEnvironmentModel{T<:AbstractSpace}
    layer::EnvironmentLayer
    niche::Function
end


"""
    AbundanceEnvironmentalModel 

layer:

`niche`: A function that is defined over
        (min(layer), max(layer)) that gives a 
        multiplicative constant on [0, ∞) of what the actual
        growth in a location with environmental value x is, e.g.
        
        True Growth at location i = niche(x) * Intrinsic Growth 
"""
struct AbundanceEnvironmentalModel{T<:AbstractSpace}
    layer::EnvironmentLayer
    niche::Function
end
