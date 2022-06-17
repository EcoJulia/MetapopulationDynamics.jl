struct EnvironmentLayer{S}
    name::Any
    space::S
    values::Any
end

EnvironmentLayer(name, sg::SpatialGraph) = EnvironmentLayer(name, sg)
EnvironmentLayer(name, sg::Raster) = EnvironmentLayer(name, sg)
