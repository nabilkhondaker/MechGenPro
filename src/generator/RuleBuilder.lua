local RuleBuilder = {}
RuleBuilder.__index = RuleBuilder

function RuleBuilder.new()
    local self = setmetatable({}, RuleBuilder)
    self.rules = {}
    return self
end

function RuleBuilder:addMaxLength(maxLen)
    table.insert(self.rules, function(mech)
        return mech.a <= maxLen and mech.b <= maxLen and mech.c <= maxLen and mech.d <= maxLen
    end)
    return self
end

function RuleBuilder:addMinMechanicalAdvantage(minMA)
    table.insert(self.rules, function(mech)
        -- Rough estimate of mechanical advantage for crank-rocker
        local ma = mech.c / mech.a
        return ma >= minMA
    end)
    return self
end

-- Evaluates if a generated mechanism passes all strict engineering rules
function RuleBuilder:validate(mechanism)
    for _, rule in ipairs(self.rules) do
        if not rule(mechanism) then return false end
    end
    return true
end

return RuleBuilder
