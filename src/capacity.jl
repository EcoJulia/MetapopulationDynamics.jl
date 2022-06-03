"""
    Metapop capacity a la Hanski & Ovaskainen 2003:
        If the lead eigenvalue of the matirx M < (c/e),
        the system is not stable.

        Where matrix M is defined differently in discrete and continuous time.
        In continuous time, as M_ij = A_i * A_j * e^(-d_ij * \alpha)
        where e^(-d_{ij} * alpha) is dispersal kernel.
"""

function capacity(sg::SpatialGraph, kern::DispersalKernel)

end
