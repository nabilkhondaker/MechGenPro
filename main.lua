-- main.lua
io.stdout:setvbuf("no") -- Enable live console debugging

-- Add src to package path for cleaner requires
package.path = package.path .. ";src/?.lua;src/?/init.lua"

local Engine = require("core.Engine")
local Renderer = require("visualizer.Renderer")
local FourBar = require("kinematics.FourBar")
local ProceduralGen = require("generator.ProceduralGen")

local currentMechanism

function love.load()
    love.window.setTitle("MechGenPro: Procedural Kinematics Analyzer By Nabil Khondaker")
    love.graphics.setBackgroundColor(0.1, 0.12, 0.15)
    
    -- Generate a random valid Crank-Rocker four-bar linkage
    currentMechanism = ProceduralGen.generateGrashof("crank_rocker")
    currentMechanism:setSpeed(2.5) -- rad/s
end

function love.update(dt)
    if currentMechanism then
        currentMechanism:update(dt)
    end
end

function love.draw()
    Renderer.drawGrid()
    if currentMechanism then
        Renderer.drawMechanism(currentMechanism)
        Renderer.drawHUD(currentMechanism)
    end
end

function love.keypressed(key)
    if key == "space" then
        -- Regenerate on spacebar
        currentMechanism = ProceduralGen.generateGrashof("crank_rocker")
    end
end
