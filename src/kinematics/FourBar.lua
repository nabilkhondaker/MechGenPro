local Vector2 = require("math.Vector2")

local FourBar = {}
FourBar.__index = FourBar

function FourBar.new(ground, crank, coupler, rocker)
    local self = setmetatable({}, FourBar)
    -- Link lengths
    self.d = ground  -- Ground link (fixed)
    self.a = crank   -- Input link
    self.b = coupler -- Coupler link
    self.c = rocker  -- Output link
    
    self.theta2 = 0 -- Input crank angle
    self.speed = 1.0 
    
    -- Joint coordinates
    self.joints = {
        O2 = Vector2.new(0, 0),
        A = Vector2.new(0, 0),
        B = Vector2.new(0, 0),
        O4 = Vector2.new(ground, 0)
    }
    
    self.transmissionAngle = 0
    self.tracePath = {} -- For the coupler curve
    return self
end

function FourBar:setSpeed(omega)
    self.speed = omega
end

function FourBar:update(dt)
    self.theta2 = (self.theta2 + self.speed * dt) % (2 * math.pi)
    self:solveKinematics()
end

function FourBar:solveKinematics()
    -- 1. Position of input joint A
    self.joints.A.x = self.a * math.cos(self.theta2)
    self.joints.A.y = self.a * math.sin(self.theta2)
    
    -- 2. Diagonal distance from A to O4
    local S = math.sqrt(self.joints.A.x^2 + (self.joints.A.y - self.d)^2) 
    -- Vector loop closure using Freudenstein's approach
    local K1 = self.d / self.a
    local K2 = self.d / self.c
    local K3 = (self.a^2 - self.b^2 + self.c^2 + self.d^2) / (2 * self.a * self.c)
    
    local A = math.cos(self.theta2) - K1 - K2 * math.cos(self.theta2) + K3
    local B = -2 * math.sin(self.theta2)
    local C = K1 - (K2 + 1) * math.cos(self.theta2) + K3
    
    -- Solve for rocker angle (theta4)
    local disc = B^2 - 4 * A * C
    if disc < 0 then return false end -- Mechanism locked/broken
    
    local theta4 = 2 * math.atan((-B - math.sqrt(disc)) / (2 * A))
    
    -- Position of output joint B
    self.joints.B.x = self.d + self.c * math.cos(theta4)
    self.joints.B.y = self.c * math.sin(theta4)
    
    -- 3. Calculate Transmission Angle (Gamma)
    -- Optimal is 90 degrees (pi/2). Below 40 or above 140 is poor force transmission.
    local cosGamma = (self.b^2 + self.c^2 - self.joints.A:distance(self.joints.O4)^2) / (2 * self.b * self.c)
    self.transmissionAngle = math.acos(cosGamma)
    
    -- Record coupler curve (midpoint of coupler for demo)
    local midX = (self.joints.A.x + self.joints.B.x) / 2
    local midY = (self.joints.A.y + self.joints.B.y) / 2
    table.insert(self.tracePath, Vector2.new(midX, midY))
    if #self.tracePath > 200 then table.remove(self.tracePath, 1) end
    
    return true
end

return FourBar
