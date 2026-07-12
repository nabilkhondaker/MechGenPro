package.path = package.path .. ";../src/?.lua;../src/?/init.lua;src/?.lua"

local Vector2 = require("math.Vector2")
local FourBar = require("kinematics.FourBar")
local ProceduralGen = require("generator.ProceduralGen")

-- Custom Unit Test Runner
local passes, fails = 0, 0
local function it(description, test_func)
    local status, err = pcall(test_func)
    if status then
        passes = passes + 1
        print("  [PASS] " .. description)
    else
        fails = fails + 1
        print("  [FAIL] " .. description)
        print("         -> " .. tostring(err))
    end
end

print("=== Running Kinematics & Math Tests ===")

it("Vector2: should add and subtract vectors correctly", function()
    local v1 = Vector2.new(10, 20)
    local v2 = Vector2.new(5, 5)
    
    local v3 = v1:add(v2)
    assert(v3.x == 15 and v3.y == 25, "Addition failed")
    
    local v4 = v1:sub(v2)
    assert(v4.x == 5 and v4.y == 15, "Subtraction failed")
end)

it("Vector2: should calculate distance correctly", function()
    local v1 = Vector2.new(0, 0)
    local v2 = Vector2.new(3, 4)
    assert(v1:distance(v2) == 5, "Distance math is incorrect (Pythagorean theorem failed)")
end)

it("FourBar: should initialize and solve initial joint positions", function()
    local mech = FourBar.new(200, 50, 150, 150)
    assert(mech.d == 200, "Ground link initialization failed")
    
    -- Run one frame of kinematics
    local success = mech:solveKinematics()
    assert(success == true, "Solver failed to find a valid geometric configuration")
    
    -- Crank is 50, at theta=0, Joint A should be at (50, 0)
    assert(math.abs(mech.joints.A.x - 50) < 0.001, "Joint A X-coordinate solved incorrectly")
    assert(math.abs(mech.joints.A.y - 0) < 0.001, "Joint A Y-coordinate solved incorrectly")
end)

it("ProceduralGen: should generate valid Grashof Crank-Rocker linkages", function()
    for i = 1, 10 do
        local mech = ProceduralGen.generateGrashof("crank_rocker")
        
        local links = {mech.a, mech.b, mech.c, mech.d}
        table.sort(links)
        local S = links[1]
        local L = links[4]
        local P = links[2]
        local Q = links[3]
        
        assert(S + L <= P + Q, "Grashof condition failed on iteration " .. i)
        assert(S == mech.a, "Shortest link is not the crank (a) - invalid crank-rocker")
    end
end)

print(string.format("\nResults: %d Passed, %d Failed\n", passes, fails))
os.exit(fails == 0 and 0 or 1)
