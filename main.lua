io.stdout:setvbuf("no")
package.path = package.path .. ";src/?.lua;src/?/init.lua"

local Renderer = require("visualizer.Renderer")
local Camera = require("visualizer.Camera")
local ProceduralGen = require("generator.ProceduralGen")
local Grid = require("visualizer.Grid")
local TraceGraph = require("visualizer.TraceGraph")
local Inspector = require("gui.Inspector")

local currentMechanism
local defaultFont

function love.load()
    love.window.setTitle("MechGenPro: Procedural Kinematics Analyzer")
    
    -- Font Loading Logic
    local success, font = pcall(love.graphics.newFont, "assets/fonts/RobotoMono.ttf", 14)
    if success then
        defaultFont = font
        love.graphics.setFont(defaultFont)
    else
        print("RobotoMono.ttf not found in assets/fonts/. Using default system font.")
    end
    
    Grid.load()
    currentMechanism = ProceduralGen.generateGrashof("crank_rocker")
end

function love.update(dt)
    if currentMechanism then 
        currentMechanism:update(dt)
        TraceGraph.update(currentMechanism)
    end
end

function love.draw()
    Grid.draw()
    
    Camera.attach()
    if currentMechanism then
        Renderer.drawMechanism(currentMechanism)
    end
    Camera.detach()
    
    if currentMechanism then 
        Renderer.drawHUD(currentMechanism) 
        TraceGraph.draw()
        Inspector.update(currentMechanism)
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    if love.mouse.isDown(2) then
        Camera.move(dx, dy)
    end
end

function love.wheelmoved(x, y)
    Camera.setZoom(y * 0.1)
end
