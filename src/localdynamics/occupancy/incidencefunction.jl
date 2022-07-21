"""
    Hanski1994{T<:Real} <: AbstractOccupancyDynamics

An incidence-function model of metapopulation dynamics, as defined 
in Hanski 1994 (citation).

Parameters: 
"""

@kwdef struct Hanski1994{T<:Real} <: AbstractOccupancyDynamics
    c::T = 0.1
    e::T = 0.05
    α::T = 10.0
    x::T = 1.0
    numlocations = 20
    areadistribution=Exponential(1.5)
    A::Vector{T} = rand(areadistribution, numlocations)
    kernel = ExponentialDispersalKernel(; decay = α, threshold = 0.01)
end

Base.string(ifm::Hanski1994) = """
[bold]$(typeof(ifm)) <: $(supertype(typeof(ifm)))[/bold]
[bold]  $(supertype(supertype(typeof(ifm)))) <: $(supertype(supertype(supertype(typeof(ifm)))))[/bold]

An [bold]incidence function[/bold] model with parameters:

[bold]c: [/bold][yellow]$(ifm.c)[/yellow]
[bold]e: [/bold][yellow]$(ifm.e)[/yellow]
[bold]α: [/bold][yellow]$(ifm.α)[/yellow]
[bold]x (area-extinction dependence):[/bold] [yellow]$(ifm.x)[/yellow]
[bold]A (areas vector):[/bold] Vector of [yellow]::$(typeof(ifm.A[begin]))[/yellow] of length [red]$(length(ifm.A))[/red] 
    with [bold]mean[/bold] [green]$(round(mean(ifm.A),digits=3))[/green] and [bold]variance[/bold] [green]$(round(var(ifm.A), digits=3))[/green]

[bold]Kernel:[/bold]
"""
Base.show(io::IO, ::MIME"text/plain", ifm::Hanski1994) = print(
    io,
    string(
        Panel(
            string(ifm),
            Panel(
                string(ifm.kernel);
                title = string(typeof(ifm.kernel)),
                style = "yellow dim",
                title_style = "default yellow bold",
                width = 24,
            );
            title = string(typeof(ifm)),
            style = "blue dim",
            title_style = "default bright_blue bold",
            padding = (2, 2, 1, 1),
            width = 60,
        ),
    ),
)



params(model::M) where {M<:Hanski1994} =
    model.c, model.e, model.α, model.x, model.A, model.kernel

function _hanski1994_extinction(extprob, A_i, x)
    A_i < extprob^(1 / x) ? 1 : extprob / (A_i^x)
end

function _hanski1994_colonization(oldstate, i, c, A, kernmat)
    nsites = length(oldstate)
    S_i = 0.0
    for j = 1:nsites
        if i != j && oldstate[j] == 1
            S_i += A[j] * kernmat[j, i]
        end
    end
    C_i = S_i^2 / ((S_i)^2 + (1 / c))
    return C_i
end

function _sim!(
    model::M,
    space::S,
    prevstate::Vector{T},
    newstate::Vector{T},
) where {M<:Hanski1994,S<:AbstractSpace,T<:Real}
    @assert numsites(space) == length(model.A)
    c, e, α, x, A, kern = params(model)
    kernmat = kernelmatrix(space, kern)
    for (i, st) in enumerate(prevstate)
        if st == 1
            extprob = _hanski1994_extinction(e, A[i], x)
            newstate[i] = rand() < extprob ? 0 : 1
        elseif st == 0
            colprob = _hanski1994_colonization(prevstate, i, c, A, kernmat)
            newstate[i] = rand() < colprob
        end
    end
    newstate
end
