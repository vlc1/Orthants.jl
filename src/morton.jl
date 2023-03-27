struct Morton{N,T<:Unsigned}
    val::T

    Morton{N}(val::Unsigned) where {N} =
        new{N,typeof(val)}(val)
end

Base.valtype(::Morton{N,T}) where {N,T} = T

Core.Unsigned(ind::Morton) = ind.val

Morton(vals::NTuple{N,Unsigned}) where {N} =
    Morton(vals...)

Morton(x::Unsigned) = Morton{1}(x)

function Morton(x::T, y::T) where {T<:Unsigned}
    val = (encode2(y) << 1) | encode2(x)
    Morton{2}(val)
end

function Morton(x::T, y::T, z::T) where {T<:Unsigned}
    val = (encode3(z) << 2) | (encode3(y) << 1) | encode3(x)
    Morton{3}(val)
end
