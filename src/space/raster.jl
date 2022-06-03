struct Raster <: AbstractSpace
    matrix::Matrix
end


numsites(r::Raster) = prod(size(r.matrix)...)
