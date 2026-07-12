local KinematicHessian = {}

-- Approximates the gradient of the cost function with respect to link lengths
function KinematicHessian.computeGradient(mech, costFunc, targetPath, epsilon)
    epsilon = epsilon or 0.001
    local grad = {a = 0, b = 0, c = 0, d = 0}
    
    local baseCost = costFunc(mech, targetPath)
    
    -- Perturb 'a' (crank)
    mech.a = mech.a + epsilon
    grad.a = (costFunc(mech, targetPath) - baseCost) / epsilon
    mech.a = mech.a - epsilon -- restore
    
    -- Perturb 'b' (coupler)
    mech.b = mech.b + epsilon
    grad.b = (costFunc(mech, targetPath) - baseCost) / epsilon
    mech.b = mech.b - epsilon
    
    -- (Would repeat for c and d)
    
    return grad
end

return KinematicHessian
