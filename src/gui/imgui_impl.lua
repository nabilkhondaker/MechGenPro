local UI = {
    mouseX = 0, mouseY = 0,
    mouseDown = false,
    activeItem = nil,
    hotItem = nil
}

function UI.update()
    UI.mouseX, UI.mouseY = love.mouse.getPosition()
    UI.mouseDown = love.mouse.isDown(1)
    UI.hotItem = nil -- Reset hot item every frame
end

-- A simple slider for adjusting link lengths
function UI.slider(id, x, y, width, label, value, min, max)
    local height = 20
    local handleWidth = 10
    
    -- Check if mouse is hovering
    if UI.mouseX >= x and UI.mouseX <= x + width and UI.mouseY >= y and UI.mouseY <= y + height then
        UI.hotItem = id
    end
    
    -- Interaction logic
    if UI.hotItem == id and UI.mouseDown and UI.activeItem == nil then
        UI.activeItem = id
    end
    
    if UI.activeItem == id then
        -- Calculate new value based on mouse X position
        local percent = math.max(0, math.min(1, (UI.mouseX - x) / width))
        value = min + percent * (max - min)
    end
    
    if not UI.mouseDown and UI.activeItem == id then
        UI.activeItem = nil -- Release
    end
    
    -- Drawing
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", x, y, width, height)
    
    -- Draw filled portion
    local percent = (value - min) / (max - min)
    love.graphics.setColor(0.4, 0.6, 0.9)
    love.graphics.rectangle("fill", x, y, width * percent, height)
    
    -- Label and Value Text
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(string.format("%s: %.1f", label, value), x + 5, y + 2)
    
    return value
end

return UI
