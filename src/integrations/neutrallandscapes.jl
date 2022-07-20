# WARNING this file is only loaded if NeutralLandscapes.jl is also active
# This all happens thanks to the Requires.jl package

using NeutralLandscapes

const NLMaker = NeutralLandscapes.NeutralLandscapeMaker
const NLUpdater = NeutralLandscapes.NeutralLandscapeUpdater


EnvironmentLayer(maker::NLMaker; dims=(50,50)) = EnvironmentLayer(Raster(rand(maker, dims)))

NeutralLandscapes.update(up::T, layer::EnvironmentLayer) where T<:NLUpdater = begin
    EnvironmentLayer(NeutralLandscapes.update(up, layer.values))
end
NeutralLandscapes.update(up::T, layer::EnvironmentLayer, n::I) where {T<:NLUpdater,I<:Integer} = begin 
    EnvironmentTimeseries(EnvironmentLayer.(NeutralLandscapes.update(up, layer.values, n)))
end 

NeutralLandscapes.normalize(layers::Vector{L}) where {L<:EnvironmentLayer} = begin
   EnvironmentTimeseries(EnvironmentLayer.(NeutralLandscapes.normalize[l.values for l in layers]))
end