local UI = require("gui.imgui_impl")
local Inspector = {}

function Inspector.update(mechanism)
    UI.update()
    
    local startX = 20
    local startY = 160
    local spacing = 30
    local sliderWidth = 200
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("LINKAGE PROPERTIES", startX, startY - 20)
    
    -- Sliders modify the mechanism directly in real-time
    mechanism.a = UI.slider("crank", startX, startY, sliderWidth, "Crank (a)", mechanism.a, 10, 200)
    mechanism.b = UI.slider("coupler", startX, startY + spacing, sliderWidth, "Coupler (b)", mechanism.b, 50, 400)
    mechanism.c = UI.slider("rocker", startX, startY + spacing * 2, sliderWidth, "Rocker (c)", mechanism.c, 50, 400)
    mechanism.d = UI.slider("ground", startX, startY + spacing * 3, sliderWidth, "Ground (d)", mechanism.d, 50, 400)
    mechanism.speed = UI.slider("speed", startX, startY + spacing * 4, sliderWidth, "Speed (rad/s)", mechanism.speed, -10, 10)
    
    -- Automatically clear trace path if geometry changes to prevent messy ghost lines
    if UI.activeItem ~= nil then
        mechanism.tracePath = {}
    end
end

return Inspector
