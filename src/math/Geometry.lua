local Geometry = {}

-- Returns the intersection points of two circles
-- Used to find Joint B in a four-bar linkage
function Geometry.circleIntersection(p1, r1, p2, r2)
    local d = p1:distance(p2)
    if d > r1 + r2 or d < math.abs(r1 - r2) then return nil end -- No intersection
    
    local a = (r1^2 - r2^2 + d^2) / (2 * d)
    local h = math.sqrt(math.max(0, r1^2 - a^2))
    
    local x2 = p1.x + a * (p2.x - p1.x) / d
    local y2 = p1.y + a * (p2.y - p1.y) / d
    
    return {
        x = x2 + h * (p2.y - p1.y) / d,
        y = y2 - h * (p2.x - p1.x) / d
    }, {
        x = x2 - h * (p2.y - p1.y) / d,
        y = y2 + h * (p2.x - p1.x) / d
    }
end

return Geometry
