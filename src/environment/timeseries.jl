"""
    EnvironmentTimeseries{T<:Union{EnvironmentLayer,EnvironmentLayerSet}}

A time-series of `EnvironmentLayers` or `EnvironmentLayerSets`.
"""
struct EnvironmentTimeseries{T<:Union{EnvironmentLayer,EnvironmentLayerSet}}
    timeseries::Vector{T}
end

Base.length(lt::EnvironmentTimeseries) = length(lt.timeseries)
Base.getindex(lt::EnvironmentTimeseries, i) = lt.timeseries[i]

Base.iterate(et, i=1) = i <= length(et) ? (et[i],i+1) : nothing

Base.string(et::EnvironmentTimeseries) = """
[bold]$(typeof(et))[/bold]

An [bold]timeseries[/bold] of environmental layers with [bold][yellow]$(length(et.timeseries))[/yellow][/bold] timesteps.
"""


Base.show(io::IO, ::MIME"text/plain", et::EnvironmentTimeseries) = begin 
    print(
        io,
        string(
            Panel(
                string(et),
                title = "EnvironmentTimeseries",
                style = "blue dim",
                title_style = "default blue bold",
                padding = (2, 2, 1, 1),
                width = 70,
            ),
        ),
    )
end 
