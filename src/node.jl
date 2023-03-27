struct Orthant{N,S<:Union{Integer,Colon},T<:Unsigned}
    heigth::S
    vals::NTuple{N,T}
end

Orthant(vals::T...) where {T<:Unsigned} = Orthant(:, vals)

values(this::Orthant) = this.vals
height(this::Orthant) = this.height

const Ray{S,T} = Orthant{1,S,T}
const Quadrant{S,T} = Orthant{2,S,T}
const Octant{S,T} = Orthant{3,S,T}
