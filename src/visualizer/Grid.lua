local Grid = {}
local shader

function Grid.load()
    -- Load the shader safely
    local success, loadedShader = pcall(love.graphics.newShader, "assets/shaders/blueprint.glsl")
    if success then
        shader = loadedShader
    else
        print("Warning: Could not load blueprint shader. Falling back to solid color.")
    end
end

function Grid.draw()
    local w, h = love.graphics.getDimensions()
    
    if shader then
        shader:send("screenSize", {w, h})
        shader:send("time", love.timer.getTime())
        love.graphics.setShader(shader)
        love.graphics.rectangle("fill", 0, 0, w, h)
        love.graphics.setShader() -- Reset shader so it doesn't affect the mechanism
    else
        -- Fallback if shader file is missing
        love.graphics.setColor(0.04, 0.11, 0.18)
        love.graphics.rectangle("fill", 0, 0, w, h)
    end
end

return Grid
