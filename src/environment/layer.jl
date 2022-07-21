"""
    EnvironmentLayer{S,T}

An environmental layer built on an `AbstractSpace`. 
"""
struct EnvironmentLayer{S<:AbstractSpace,T} 
    space::S
    values::T
end

function EnvironmentLayer(sg::SpatialGraph; dist = MidpointDisplacement(0.5))  
    ns = numsites(sg)
    layer = rand(dist, (100,100))

    values = []
    EnvironmentLayer(sg, values)
end 

EnvironmentLayer(raster::Raster) = EnvironmentLayer(raster, raster.matrix) 
EnvironmentLayer(mat::Matrix) = EnvironmentLayer(Raster(similar(mat)), mat)

Base.string(el::EnvironmentLayer{ST,ET}) where {ST,ET} = """
An [bold]environmental layer[/bold] with [bold][yellow]$(length(el.values))[/yellow][/bold] locations
based on a $(ST).
"""


function layer_plot(layer)
    plt = heatmap(layer.values, xlabel="x", label="y")
    io = IOBuffer()
    print(IOContext(io, :color => true), plt)
    return String(take!(io))
end

Base.show(io::IO, ::MIME"text/plain", el::EnvironmentLayer) = print(
    io,
    string(
        "\n",
        Panel(
            string(el),
            layer_plot(el),
            title = string(typeof(el)),
            style = "green dim",
            title_style = "default green bold",
            padding = (2, 2, 1, 1),
            width = 60,
        ),
    ),
)
