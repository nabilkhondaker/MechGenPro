local Engine = { state = "SIMULATING" }

function Engine.switchState(newState)
    Engine.state = newState
    print("Engine transitioning to: " .. newState)
end

return Engine
