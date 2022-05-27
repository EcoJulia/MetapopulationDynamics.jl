@kwdef struct Hanski1994{T<:Real} <: AbstractOccupancyDynamics
    c::T = 0.1
    e::T = 0.05
    α::T = 10.
    x::T = 1.0
    A::Vector{T} = rand(Exponential(1.5), 20) 
    kernel = ExponentialDispersalKernel(;decay=α, threshold=0.01)
end

params(model::M) where {M<:Hanski1994} = model.c, model.e, model.α, model.x, model.A, model.kernel

function _kernelmatrix(space, kernel)
    distmat = distancematrix(space)
    broadcast(x-> x == 0 ? 0 : kernel(x), distmat)
end

function _hanski1994_extinction(extprob, A_i, x) 
    A_i < extprob^(1/x) ? 1 : extprob/(A_i^x)
end 

function _hanski1994_colonization(oldstate, i, c, A, kernmat,) 
    nsites = length(oldstate)
    S_i = 0.0
    for j in 1:nsites
        if i != j && oldstate[j] == 1 
            S_i += A[j]*kernmat[j,i]
        end
    end
    C_i = S_i^2/((S_i)^2+(1/c))
    return C_i
end 

function _sim(model::M, space::S, prevstate::Vector{T}) where {M<:Hanski1994,S<:AbstractSpace,T<:Real}
    @assert numsites(space) == length(model.A)
    c, e, α, x, A, kern = params(model)
    kernmat = _kernelmatrix(space, kern)
    newstate = similar(prevstate)
    for (i,st) in enumerate(prevstate)
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

