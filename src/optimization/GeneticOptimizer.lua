local ProceduralGen = require("generator.ProceduralGen")
local CostFunctions = require("optimization.CostFunctions")

local GeneticOptimizer = {}

function GeneticOptimizer.evolve(populationSize, generations, targetMode)
    local population = {}
    
    -- 1. Initialize random population
    for i = 1, populationSize do
        table.insert(population, ProceduralGen.generateGrashof("crank_rocker"))
    end
    
    for g = 1, generations do
        -- 2. Evaluate Fitness (lower score is better)
        local scoredPopulation = {}
        for _, mech in ipairs(population) do
            local score = CostFunctions.evaluateTransmission(mech)
            table.insert(scoredPopulation, {mech = mech, score = score})
        end
        
        -- Sort by best score
        table.sort(scoredPopulation, function(a, b) return a.score < b.score end)
        
        -- 3. Selection & Crossover (Keep top 20%, mutate the rest)
        local nextGen = {}
        for i = 1, math.floor(populationSize * 0.2) do
            table.insert(nextGen, scoredPopulation[i].mech)
        end
        
        -- 4. Mutation
        while #nextGen < populationSize do
            local parent = scoredPopulation[math.random(1, #nextGen)].mech
            local mutationRate = 0.1
            
            -- Slightly mutate link lengths
            local mutatedMech = require("kinematics.FourBar").new(
                parent.d * (1 + (math.random() * mutationRate - mutationRate/2)),
                parent.a * (1 + (math.random() * mutationRate - mutationRate/2)),
                parent.b * (1 + (math.random() * mutationRate - mutationRate/2)),
                parent.c * (1 + (math.random() * mutationRate - mutationRate/2))
            )
            table.insert(nextGen, mutatedMech)
        end
        
        population = nextGen
    end
    
    -- Return the best mechanism found
    return population[1]
end

return GeneticOptimizer
