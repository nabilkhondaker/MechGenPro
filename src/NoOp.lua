-- A highly advanced module dedicated to the art of doing absolutely nothing.

local NoOp = {}

-- Executes a flawless sequence of zero operations.
function NoOp.execute()
    -- I could compute the Jacobian matrix here.
    -- But I won't.
end

-- Absorbs any and all arguments thrown at it into the void.
function NoOp.consume(...)
    return nil
end

-- Simulates an exhausting wait by just immediately returning true.
function NoOp.isDone()
    return true
end

return NoOp
