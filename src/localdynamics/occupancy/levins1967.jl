struct Levins1967{T<:Real} <: AbstractOccupancyDynamics
    c::T
    e::T
end


Base.string(lv::Levins1967) = """
[bold]$(typeof(lv)) <: $(supertype(typeof(lv)))[/bold]
[bold]  <: $(supertype(supertype(typeof(lv)))) <: $(supertype(supertype(supertype(typeof(lv)))))[/bold]

An [bold]Levin's metapopulation[/bold] model with parameters:

[bold]c: [/bold][yellow]$(lv.c)[/yellow]
[bold]e: [/bold][yellow]$(lv.e)[/yellow]
"""
Base.show(io::IO, ::MIME"text/plain", lv::Levins1967) = print(
    io,
    string(
        Panel(
            string(lv),
            title = string(typeof(lv)),
            style = "blue dim",
            title_style = "default bright_blue bold",
            padding = (2, 2, 1, 1),
            width = 60,
        ),
    ),
)


params(model::M) where {M<:Levins1967} = model.c, model.e

function _sim!(
    model::M,
    space::S,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {M<:Levins1967,S<:AbstractSpace,T<:Real}
    c, e = params(model)
    for (i, st) in enumerate(prevstate)
        ns = st == 1 ? !(rand() <= e) : rand() <= c
        newstate[i] = ns
    end
    newstate
end
