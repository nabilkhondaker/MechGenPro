local Solvers = {}

-- Newton-Raphson root finder for non-linear equations
-- f: function to solve, df: derivative of the function, x0: initial guess
function Solvers.newtonRaphson(f, df, x0, tol, maxIter)
    tol = tol or 1e-6
    maxIter = maxIter or 20
    
    local x = x0
    for i = 1, maxIter do
        local fx = f(x)
        local dfx = df(x)
        
        if math.abs(dfx) < 1e-10 then break end -- Avoid division by zero
        
        local dx = fx / dfx
        x = x - dx
        
        if math.abs(dx) < tol then return x end
    end
    return x -- Return best approximation
end

return Solvers
