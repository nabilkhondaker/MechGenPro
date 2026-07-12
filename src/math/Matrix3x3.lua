local Matrix3x3 = {}
Matrix3x3.__index = Matrix3x3

-- Creates a standard transformation matrix for 2D
function Matrix3x3.new(a, b, c, d, e, f, g, h, i)
    return setmetatable({
        {a or 1, b or 0, c or 0},
        {d or 0, e or 1, f or 0},
        {g or 0, h or 0, i or 1}
    }, Matrix3x3)
end

function Matrix3x3.translation(tx, ty)
    return Matrix3x3.new(1, 0, tx, 0, 1, ty, 0, 0, 1)
end

function Matrix3x3.rotation(theta)
    local c, s = math.cos(theta), math.sin(theta)
    return Matrix3x3.new(c, -s, 0, s, c, 0, 0, 0, 1)
end

-- Matrix-Vector multiplication
function Matrix3x3:multiplyVector(v)
    local x = self[1][1]*v.x + self[1][2]*v.y + self[1][3]
    local y = self[2][1]*v.x + self[2][2]*v.y + self[2][3]
    return require("math.Vector2").new(x, y)
end

return Matrix3x3
