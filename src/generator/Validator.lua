local Validator = {}

function Validator.checkSingularity(mechanism)
    local mu = mechanism.transmissionAngle
    local epsilon = 0.05 -- Radian threshold for "dangerously close to lockup"
    
    if mu < epsilon or math.abs(mu - math.pi) < epsilon then
        return true, "Singularity reached: Linkage locked."
    end
    return false, "Safe"
end

function Validator.checkSelfIntersection(mechanism)
    -- In a real physical system, links can't clip through each other.
    -- This checks if the coupler crosses the ground link.
    local A, B = mechanism.joints.A, mechanism.joints.B
    local O2, O4 = mechanism.joints.O2, mechanism.joints.O4
    
    -- Fast cross-product intersection test
    local function ccw(p1, p2, p3)
        return (p3.y - p1.y) * (p2.x - p1.x) > (p2.y - p1.y) * (p3.x - p1.x)
    end
    
    local intersect = ccw(A, O2, O4) ~= ccw(B, O2, O4) and ccw(A, B, O2) ~= ccw(A, B, O4)
    return intersect, intersect and "Collision detected" or "Clear"
end

return Validator
