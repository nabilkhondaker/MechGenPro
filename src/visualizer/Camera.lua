local Camera = {
    x = 0, y = 0, zoom = 1
}

function Camera.attach()
    love.graphics.push()
    love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    love.graphics.scale(Camera.zoom)
    love.graphics.translate(-Camera.x, -Camera.y)
end

function Camera.detach()
    love.graphics.pop()
end

function Camera.move(dx, dy)
    Camera.x = Camera.x - (dx / Camera.zoom)
    Camera.y = Camera.y - (dy / Camera.zoom)
end

function Camera.setZoom(amount)
    Camera.zoom = math.max(0.1, math.min(Camera.zoom + amount, 5.0))
end

return Camera
