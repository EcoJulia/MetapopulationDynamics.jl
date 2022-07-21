"""
    pcc(timeseries)

Computes the mean Pairwise-Crosscorrelation for a timeseries
that is an `AbundanceOutput`.
"""
function pcc(timeseries)
    n_pops = length(timeseries[:, 1])
    mean_cc::Float64 = 0.0
    s::Float64 = 0.0
    ct::Int64 = 0
    for p1 = 1:n_pops
        for p2 = (p1+1):n_pops
            v1 = timeseries[p1, :]
            v2 = timeseries[p2, :]
            cc = crosscor((v1), (v2), [0])
            s += cc[1]
            ct += 1
        end
    end
    mean_cc = s / ct
    return mean_cc
end
