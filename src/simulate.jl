function simulate(model::M, space::S; init=rand(Bernoulli(0.5), numsites(space)), numtimesteps=100) where {M<:AbstractDynamics,S<:AbstractSpace}
    output = zeros(numsites(space), numtimesteps)
    simulate!(model, space, output; init=init)
    output
end

function simulate!(model::M, space::S, outarray; init=rand(Bernoulli(0.5), size(model,1))) where {M<:AbstractDynamics,S<:AbstractSpace}
    nt = size(outarray,2)
    outarray[:,begin] .= init
    for t in 2:nt
        outarray[:,t] .= _sim(model, space, outarray[:, t-1])
    end
end