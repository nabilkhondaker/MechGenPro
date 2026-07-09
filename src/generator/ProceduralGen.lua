local FourBar = require("kinematics.FourBar")

local ProceduralGen = {}

-- Checks Grashof condition: S + L <= P + Q
-- Where S=shortest, L=longest, P,Q=intermediate links
local function isGrashof(a, b, c, d)
    local links = {a, b, c, d}
    table.sort(links)
    return (links[1] + links[4]) <= (links[2] + links[3])
end

function ProceduralGen.generateGrashof(type)
    local a, b, c, d
    local maxIter = 1000
    local iter = 0
    
    math.randomseed(os.time())
    
    repeat
        -- Base scale
        local scale = math.random(100, 300)
        a = math.random(30, 100) -- Crank usually shortest for crank-rocker
        b = math.random(100, scale)
        c = math.random(100, scale)
        d = math.random(100, scale)
        
        local valid = isGrashof(a, b, c, d)
        
        -- Force specific configuration
        if type == "crank_rocker" then
            -- For crank rocker, shortest link (a) must be adjacent to fixed link (d)
            local minLink = math.min(a, b, c, d)
            if minLink ~= a then valid = false end
        end
        
        iter = iter + 1
    until (valid or iter > maxIter)
    
    if iter > maxIter then
        print("Warning: Procedural generation failed to find pure Grashof in bounds, falling back to safe defaults.")
        return FourBar.new(200, 50, 200, 200)
    end
    
    return FourBar.new(d, a, b, c)
end

return ProceduralGen
