"""
    EnvironmentLayerSet

A set of `EnvironmentLayer`s.
"""
struct EnvironmentLayerSet
    layers::Vector{EnvironmentLayer}
end

Base.size(els::EnvironmentLayerSet) = length(els.layers)

"""
    numlayers(els::EnvironmentLayerSet)

Returns the number of layers in an `EnvironmentLayerSet`.
"""
numlayers(els::EnvironmentLayerSet) = size(els)
