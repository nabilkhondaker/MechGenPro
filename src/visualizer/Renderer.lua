local Renderer = {}

function Renderer.drawGrid()
    love.graphics.setColor(0.2, 0.25, 0.3, 0.5)
    local w, h = love.graphics.getDimensions()
    for i = 0, w, 50 do love.graphics.line(i, 0, i, h) end
    for i = 0, h, 50 do love.graphics.line(0, i, w, i) end
end

function Renderer.drawMechanism(mech)
    -- Center mechanism in screen
    love.graphics.push()
    love.graphics.translate(love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2 + 100)
    love.graphics.scale(1, -1) -- Flip Y axis for standard Cartesian
    
    -- Draw Trace Path
    love.graphics.setColor(1, 0.8, 0.2, 0.8)
    love.graphics.setLineWidth(2)
    for i = 2, #mech.tracePath do
        local p1, p2 = mech.tracePath[i-1], mech.tracePath[i]
        love.graphics.line(p1.x, p1.y, p2.x, p2.y)
    end

    -- Draw Links
    love.graphics.setLineWidth(5)
    
    -- Ground
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.line(mech.joints.O2.x, mech.joints.O2.y, mech.joints.O4.x, mech.joints.O4.y)
    
    -- Crank (Red)
    love.graphics.setColor(1, 0.3, 0.3)
    love.graphics.line(mech.joints.O2.x, mech.joints.O2.y, mech.joints.A.x, mech.joints.A.y)
    
    -- Coupler (Blue)
    love.graphics.setColor(0.3, 0.6, 1)
    love.graphics.line(mech.joints.A.x, mech.joints.A.y, mech.joints.B.x, mech.joints.B.y)
    
    -- Rocker (Green)
    love.graphics.setColor(0.3, 1, 0.5)
    love.graphics.line(mech.joints.O4.x, mech.joints.O4.y, mech.joints.B.x, mech.joints.B.y)
    
    -- Draw Joints
    love.graphics.setColor(1, 1, 1)
    for _, joint in pairs(mech.joints) do
        love.graphics.circle("fill", joint.x, joint.y, 6)
        love.graphics.setColor(0,0,0)
        love.graphics.circle("line", joint.x, joint.y, 6)
        love.graphics.setColor(1,1,1)
    end
    
    love.graphics.pop()
end

function Renderer.drawHUD(mech)
    love.graphics.setColor(1, 1, 1)
    local tAngleDeg = math.deg(mech.transmissionAngle)
    love.graphics.print("MechGenPro Analyzer V1.0", 20, 20)
    
    -- Color code transmission angle (Bad < 40, Good > 40)
    if tAngleDeg < 40 or tAngleDeg > 140 then
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(0, 1, 0)
    end
    love.graphics.print(string.format("Transmission Angle (µ): %.2f°", tAngleDeg), 20, 40)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(string.format("Crank (a): %d", mech.a), 20, 60)
    love.graphics.print(string.format("Coupler (b): %d", mech.b), 20, 75)
    love.graphics.print(string.format("Rocker (c): %d", mech.c), 20, 90)
    love.graphics.print(string.format("Ground (d): %d", mech.d), 20, 105)
    love.graphics.print("Press SPACE to Procedurally Generate a new Linkage", 20, 135)
end

return Renderer
