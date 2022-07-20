abstract type AbstractOutput end


"""
    AbundanceOutput

"""
struct AbundanceOutput 
    timeseries
end 



Base.string(output::AbundanceOutput) = """
[bold]$(typeof(output)) <: $(supertype(typeof(output)))[/bold]

An ::AbundanceOutput output with $(size(output.timeseries,2)) time points.
"""

Base.show(io::IO, ::MIME"text/plain", output::AbundanceOutput) = print(
    io,
    string(
       Panel(_abundanceplot(output))
    ),
)

function _abundanceplot(output::AbundanceOutput)
    grid = output.timeseries
    nt = size(grid, 2)
    np = size(grid, 1)
    totalabundance = zeros(Float64, nt)
    for t in 1:nt
        totalabundance[t] = sum(grid[:,t])
    end
    string(lineplot(1:nt, totalabundance, xlabel="Time", ylabel="N"))
end



"""
    OccupancyOutput

"""

struct OccupancyOutput 
    timeseries
end 

OccupancyOutput(t::Vector{T}) where {T<:Matrix} = OccupancyOutput(t)

Base.string(output::OccupancyOutput) = """
[bold]$(typeof(output)) <: $(supertype(typeof(output)))[/bold]

An ::OccupancyModel output with $(size(output.timeseries,2)) time points.
"""

Base.show(io::IO, ::MIME"text/plain", output::OccupancyOutput) = print(
    io,
    string(
       Panel(_occupancyplot(output))
    ),
)

function _occupancyplot(output::OccupancyOutput)
    grid = output.timeseries
    nt = size(grid, 2)
    np = size(grid, 1)
    prop = zeros(Float64, nt)
    for t in 1:nt
        prop[t] = sum(grid[:,t])/np
    end
    string(lineplot(1:nt, prop, ylim=(0,1), xlabel="Time", ylabel="p"))
end
