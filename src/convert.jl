Morton(this::Orthant) = Morton(values(this))

Orthant(this::Morton{1}) = Orthant(Unsigned(this))

function Orthant(this::Morton{2})
    val = Unsigned(this)
    Orthant(decode2(val >> 0), decode2(val >> 1))
end

function Orthant(this::Morton{3})
    val = Unsigned(this)
    Orthant(decode3(val >> 0), decode3(val >> 1), decode3(val >> 2))
end
