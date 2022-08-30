"""
    abstract type MetapopulationModel end

Abstract supertype for all models.
"""
abstract type MetapopulationModel end

"""
    abstract type AbstractLocalDynamics <: MetapopulationModel end

Abstract supertype for all models of local dynamics.
"""
abstract type AbstractLocalDynamics <: MetapopulationModel end

"""
    abstract type AbstractOccupancyDynamics <: AbstractLocalDynamics end


"""
abstract type AbstractOccupancyDynamics <: AbstractLocalDynamics end

"""
    abstract type AbstractAbundanceDynamics <: AbstractLocalDynamics end

"""
abstract type AbstractAbundanceDynamics <: AbstractLocalDynamics end

"""
    abstract type AbstractDispersalModel <: MetapopulationModel end

Abstract supertype for all dispersal models.
"""
abstract type AbstractDispersalModel <: MetapopulationModel end

"""
    AbstractEnvironmentModel <: MetapopulationModel 

Abstract supertype for all environmental models
"""
abstract type AbstractEnvironmentModel <: MetapopulationModel end


"""
    ModelSet{
        L<:Union{AbstractLocalDynamics,Missing},
        D<:Union{AbstractDispersalModel,Missing},
        E<:Union{AbstractEnvironmentModel,Missing},
    }

A set of local, environmental, and dispersal models.
"""
@kwdef struct ModelSet{
    L<:Union{AbstractLocalDynamics,Missing},
    D<:Union{AbstractDispersalModel,Missing},
    E<:Union{AbstractEnvironmentModel,Missing},
}
    localdynamics::L
    dispersal::D
    environment::E
end


# TODO 
# Alias handle <: AbstractModel 
# 




"""
    modelset()

Builds a ModelSet.
"""
modelset(
    l::L,
    d::D,
    e::E,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, d, e)
modelset(
    l::L,
    e::E,
    d::D,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, d, e)
modelset(
    d::D,
    l::L,
    e::E,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, d, e)
modelset(
    d::D,
    e::E,
    l::L,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, d, e)
modelset(
    e::E,
    l::L,
    d::D,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, d, e)
modelset(
    e::E,
    d::D,
    l::L,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, d, e)

modelset(e::E, d::D) where {D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(missing, d, e)
modelset(d::D, e::E) where {D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(missing, d, e)

modelset(
    d::D,
    l::L,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, d, missing)
modelset(
    l::L,
    d::D,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, d, missing)

modelset(
    e::E,
    l::L,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, missing, e)
modelset(
    l::L,
    e::E,
) where {L<:AbstractLocalDynamics,D<:AbstractDispersalModel,E<:AbstractEnvironmentModel} =
    ModelSet(l, missing, e)
