local CostFunctions = {}

-- Penalizes mechanisms with transmission angles outside 40-140 degrees
function CostFunctions.evaluateTransmission(mechanism)
    local minAngle = math.rad(40)
    local maxAngle = math.rad(140)
    local penalty = 0
    
    if mechanism.transmissionAngle < minAngle then
        penalty = penalty + (minAngle - mechanism.transmissionAngle) * 100
    elseif mechanism.transmissionAngle > maxAngle then
        penalty = penalty + (mechanism.transmissionAngle - maxAngle) * 100
    end
    
    return penalty
end

-- Compares the generated coupler curve to a target path
function CostFunctions.evaluatePathDeviation(mechanism, targetPath)
    if #mechanism.tracePath == 0 then return 99999 end
    
    local errorTotal = 0
    -- Simple Hausdorff distance approximation for path comparison
    for i, p1 in ipairs(mechanism.tracePath) do
        local target = targetPath[1 + (i % #targetPath)]
        if target then
            errorTotal = errorTotal + p1:distance(target)
        end
    end
    
    return errorTotal / #mechanism.tracePath
end

return CostFunctions
