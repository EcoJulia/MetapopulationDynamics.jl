"""
    Should patches be a type wrapper than converts
    to a raster with explicit grain? 

    Should there be generators for patches with 
    area distribution and distance to patch dist? 

    I think develop raster and spatial graph first and 
    then implement this and decide whether it should
    be its own package. 

"""

struct Patches <: AbstractSpace end 

numsites() = nothing

