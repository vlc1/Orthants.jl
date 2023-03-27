using Orthants
using Test

@testset "encode" begin
    # 2d example from Peter's chapter (Fig. 1.4)
    x, y = 0x00000016, 0x0000005b
    orthant = Orthant(x, y)
    morton = Morton(orthant)
    val = Unsigned(morton)
    @test isequal(val, 0x0000239e)

    # 3d
    x, y, z = 0x0000024b, 0x000000cd, 0x0000031f
    orthant = Orthant(x, y, z)
    morton = Morton(orthant)
    val = Unsigned(morton)
    @test isequal(val, 0x2c4c4faf)
end

@testset "decode" begin
    # 2d example from Peter's chapter (Fig. 1.4)
    val = 0x0000239e
    morton = Morton{2}(val)
    orthant = Orthant(morton)
    x, y = values(orthant)
    @test isequal(x, 0x00000016)
    @test isequal(y, 0x0000005b)

    # 3d
    val = 0x2c4c4faf
    morton = Morton{3}(val)
    orthant = Orthant(morton)
    x, y, z = values(orthant)
    @test isequal(x, 0x0000024b)
    @test isequal(y, 0x000000cd)
    @test isequal(z, 0x0000031f)
end
