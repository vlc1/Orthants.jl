"""

    encode2(x::UInt32)

Insert one 0 bit after each of the 16 low bits of `x`.

"""
function encode2(x::UInt32)
    x &= 0x0000ffff                  # x = ---- ---- ---- ---- fedc ba98 7654 3210
    x = (x | (x <<  8)) & 0x00ff00ff # x = ---- ---- fedc ba98 ---- ---- 7654 3210
    x = (x | (x <<  4)) & 0x0f0f0f0f # x = ---- fedc ---- ba98 ---- 7654 ---- 3210
    x = (x | (x <<  2)) & 0x33333333 # x = --fe --dc --ba --98 --76 --54 --32 --10
    x = (x | (x <<  1)) & 0x55555555 # x = -f-e -d-c -b-a -9-8 -7-6 -5-4 -3-2 -1-0
end

"""

    encode3(x::UInt32)

Insert two 0 bits after each of the 10 low bits of `x`.

"""
function encode3(x::UInt32)
    x &= 0x000003ff                  # x = ---- ---- ---- ---- ---- --98 7654 3210
    x = (x | (x << 16)) & 0xff0000ff # x = ---- --98 ---- ---- ---- ---- 7654 3210
    x = (x | (x <<  8)) & 0x0300f00f # x = ---- --98 ---- ---- 7654 ---- ---- 3210
    x = (x | (x <<  4)) & 0x030c30c3 # x = ---- --98 ---- 76-- --54 ---- 32-- --10
    x = (x | (x <<  2)) & 0x09249249 # x = ---- 9--8 --7- -6-- 5--4 --3- -2-- 1--0
end

"""

    decode2(x::UInt32)

Pack all even-indexed bits into low bits set all odd-indexed bits to 0.

!!! note

    Inverse of `encode2`.

"""
function decode2(x::UInt32)
    x &= 0x55555555                  # x = -f-e -d-c -b-a -9-8 -7-6 -5-4 -3-2 -1-0
    x = (x | (x >>  1)) & 0x33333333 # x = --fe --dc --ba --98 --76 --54 --32 --10
    x = (x | (x >>  2)) & 0x0f0f0f0f # x = ---- fedc ---- ba98 ---- 7654 ---- 3210
    x = (x | (x >>  4)) & 0x00ff00ff # x = ---- ---- fedc ba98 ---- ---- 7654 3210
    x = (x | (x >>  8)) & 0x0000ffff # x = ---- ---- ---- ---- fedc ba98 7654 3210
end

"""

    decode3(x::UInt32)

Pack every other three bits into low bits and set others to 0.

!!! note

    Inverse of `encode3`.

"""
function decode3(x::UInt32)
    x &= 0x09249249                  # x = ---- 9--8 --7- -6-- 5--4 --3- -2-- 1--0
    x = (x | (x >>  2)) & 0x030c30c3 # x = ---- --98 ---- 76-- --54 ---- 32-- --10
    x = (x | (x >>  4)) & 0x0300f00f # x = ---- --98 ---- ---- 7654 ---- ---- 3210
    x = (x | (x >>  8)) & 0xff0000ff # x = ---- --98 ---- ---- ---- ---- 7654 3210
    x = (x | (x >> 16)) & 0x000003ff # x = ---- ---- ---- ---- ---- --98 7654 3210
end
