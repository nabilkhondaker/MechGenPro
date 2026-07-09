local Vector2 = {}
Vector2.__index = Vector2

function Vector2.new(x, y)
    return setmetatable({x = x or 0, y = y or 0}, Vector2)
end

function Vector2:add(v)
    return Vector2.new(self.x + v.x, self.y + v.y)
end

function Vector2:sub(v)
    return Vector2.new(self.x - v.x, self.y - v.y)
end

function Vector2:distance(v)
    local dx, dy = self.x - v.x, self.y - v.y
    return math.sqrt(dx^2 + dy^2)
end

-- Rotates vector by angle theta (radians)
function Vector2:rotate(theta)
    local cosTheta, sinTheta = math.cos(theta), math.sin(theta)
    return Vector2.new(
        self.x * cosTheta - self.y * sinTheta,
        self.x * sinTheta + self.y * cosTheta
    )
end

return Vector2
