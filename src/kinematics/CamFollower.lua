local Vector2 = require("math.Vector2")
local CamFollower = {}
CamFollower.__index = CamFollower

function CamFollower.new(baseRadius, followerType)
    local self = setmetatable({}, CamFollower)
    self.baseRadius = baseRadius or 50
    self.type = followerType or "knife_edge"
    self.profile = {}
    return self
end

function CamFollower:generateProfile(lift, dwell1, returnRise, dwell2)
    -- Uses standard Simple Harmonic Motion (SHM) for smooth acceleration
    self.profile = {}
    for theta = 0, 360, 2 do
        local rad = math.rad(theta)
        local r = self.baseRadius
        
        -- Dwell-Rise-Dwell-Return logic (Simplified for SHM)
        if theta < 180 then
            r = self.baseRadius + (lift / 2) * (1 - math.cos(math.pi * theta / 180))
        end
        
        table.insert(self.profile, Vector2.new(r * math.cos(rad), r * math.sin(rad)))
    end
    return self.profile
end

return CamFollower
