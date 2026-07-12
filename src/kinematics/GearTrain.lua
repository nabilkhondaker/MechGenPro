local GearTrain = {}

-- Calculates planetary gear speeds based on Willis equation:
-- (w_sun - w_carrier) / (w_ring - w_carrier) = - (Z_ring / Z_sun)
function GearTrain.solvePlanetary(sunTeeth, ringTeeth, sunSpeed, carrierSpeed)
    local ratio = ringTeeth / sunTeeth
    
    -- If ring is fixed (common scenario), w_ring = 0
    local ringSpeed = 0 
    
    if not carrierSpeed then
        -- Solve for carrier speed if sun is driving and ring is fixed
        carrierSpeed = sunSpeed / (1 + ratio)
        return { carrier = carrierSpeed, ring = ringSpeed, sun = sunSpeed }
    end
end

return GearTrain
