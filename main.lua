-- main.lua (UPDATED)
io.stdout:setvbuf("no")
package.path = package.path .. ";src/?.lua;src/?/init.lua"

local Renderer = require("visualizer.Renderer")
local Camera = require("visualizer.Camera")
local ProceduralGen = require("generator.ProceduralGen")
local Exporter = require("utils.Exporter")
local GeneticOptimizer = require("optimization.GeneticOptimizer")

local currentMechanism

function love.load()
    love.graphics.setBackgroundColor(0.1, 0.12, 0.15)
    currentMechanism = ProceduralGen.generateGrashof("crank_rocker")
end

function love.update(dt)
    if currentMechanism then currentMechanism:update(dt) end
end

function love.draw()
    Camera.attach()
    Renderer.drawGrid()
    if currentMechanism then
        Renderer.drawMechanism(currentMechanism)
    end
    Camera.detach()
    
    -- HUD stays outside camera so it doesn't move/zoom
    if currentMechanism then Renderer.drawHUD(currentMechanism) end
end

function love.keypressed(key)
    if key == "space" then
        currentMechanism = ProceduralGen.generateGrashof("crank_rocker")
    elseif key == "o" then
        -- Run the genetic algorithm for 50 generations to find an optimal mechanism
        print("Running optimization...")
        currentMechanism = GeneticOptimizer.evolve(20, 50, "transmission")
        print("Optimization complete!")
    elseif key == "e" then
        -- Export data
        Exporter.exportTraceToCSV(currentMechanism, "mech_data.csv")
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    if love.mouse.isDown(2) then -- Right click to pan
        Camera.move(dx, dy)
    end
end

function love.wheelmoved(x, y)
    Camera.setZoom(y * 0.1) -- Scroll to zoom
end
