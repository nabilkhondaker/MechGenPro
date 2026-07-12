local Joint = {}
Joint.__index = Joint

function Joint.new(type, x, y)
    return setmetatable({
        type = type, -- "revolute", "prismatic", "fixed"
        pos = require("math.Vector2").new(x, y),
        angle = 0    -- Relative to parent link
    }, Joint)
end

return Joint
