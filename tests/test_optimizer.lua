package.path = package.path .. ";../src/?.lua;../src/?/init.lua;src/?.lua"

local CostFunctions = require("optimization.CostFunctions")
local GeneticOptimizer = require("optimization.GeneticOptimizer")
local FourBar = require("kinematics.FourBar")

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

print("=== Running Optimization & GA Tests ===")

it("CostFunctions: should heavily penalize locked transmission angles", function()
    local badMech = FourBar.new(200, 50, 150, 150)
    -- Force a terrible transmission angle (10 degrees)
    badMech.transmissionAngle = math.rad(10)
    
    local penalty = CostFunctions.evaluateTransmission(badMech)
    assert(penalty > 0, "Failed to penalize poor transmission angle")
end)

it("CostFunctions: should give zero penalty to ideal transmission angles", function()
    local goodMech = FourBar.new(200, 50, 150, 150)
    -- Force an ideal transmission angle (90 degrees)
    goodMech.transmissionAngle = math.rad(90)
    
    local penalty = CostFunctions.evaluateTransmission(goodMech)
    assert(penalty == 0, "Penalized an ideal transmission angle unnecessarily")
end)

it("GeneticOptimizer: should evolve a valid mechanism without crashing", function()
    -- Run a very small, fast evolution (pop: 10, gens: 5)
    local bestMech = GeneticOptimizer.evolve(10, 5, "transmission")
    
    assert(bestMech ~= nil, "Optimizer returned nil instead of a mechanism")
    assert(bestMech.a > 0, "Optimizer generated impossible link lengths")
    assert(type(bestMech.solveKinematics) == "function", "Optimizer returned corrupted object data")
end)

print(string.format("\nResults: %d Passed, %d Failed\n", passes, fails))
os.exit(fails == 0 and 0 or 1)
