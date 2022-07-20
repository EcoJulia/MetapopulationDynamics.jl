struct EnvironmentLayerSet
    layers::Vector{EnvironmentLayer}
end

Base.size(els::EnvironmentLayerSet) = length(els.layers)
numlayers(els::EnvironmentLayerSet) = size(els)
