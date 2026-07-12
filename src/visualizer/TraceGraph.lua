local TraceGraph = {
    history = {},
    maxDataPoints = 300,
    width = 300,
    height = 100
}

function TraceGraph.update(mechanism)
    -- Store the transmission angle in degrees
    table.insert(TraceGraph.history, math.deg(mechanism.transmissionAngle))
    
    -- Keep the array size manageable
    if #TraceGraph.history > TraceGraph.maxDataPoints then
        table.remove(TraceGraph.history, 1)
    end
end

function TraceGraph.draw()
    if #TraceGraph.history < 2 then return end
    
    local w, h = love.graphics.getDimensions()
    local graphX = w - TraceGraph.width - 20
    local graphY = h - TraceGraph.height - 20
    
    -- Draw Background
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", graphX, graphY, TraceGraph.width, TraceGraph.height)
    love.graphics.setColor(1, 1, 1, 0.3)
    love.graphics.rectangle("line", graphX, graphY, TraceGraph.width, TraceGraph.height)
    
    -- Draw ideal bounds (40 to 140 degrees)
    local minOptimalY = graphY + TraceGraph.height - (40 / 180 * TraceGraph.height)
    local maxOptimalY = graphY + TraceGraph.height - (140 / 180 * TraceGraph.height)
    
    love.graphics.setColor(0, 1, 0, 0.2)
    love.graphics.rectangle("fill", graphX, maxOptimalY, TraceGraph.width, minOptimalY - maxOptimalY)
    
    -- Plot Data
    love.graphics.setColor(1, 0.8, 0.2)
    love.graphics.setLineWidth(2)
    
    for i = 2, #TraceGraph.history do
        local x1 = graphX + ((i - 1) / TraceGraph.maxDataPoints) * TraceGraph.width
        local x2 = graphX + (i / TraceGraph.maxDataPoints) * TraceGraph.width
        
        -- Map 0-180 degrees to graph height (inverted Y axis for screen space)
        local y1 = graphY + TraceGraph.height - ((TraceGraph.history[i-1] / 180) * TraceGraph.height)
        local y2 = graphY + TraceGraph.height - ((TraceGraph.history[i] / 180) * TraceGraph.height)
        
        love.graphics.line(x1, y1, x2, y2)
    end
    
    -- Labels
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Transmission Angle (deg)", graphX + 5, graphY + 5)
    love.graphics.setLineWidth(1)
end

return TraceGraph
