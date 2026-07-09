local EventBus = {
    listeners = {}
}

function EventBus.subscribe(event, callback)
    if not EventBus.listeners[event] then
        EventBus.listeners[event] = {}
    end
    table.insert(EventBus.listeners[event], callback)
end

function EventBus.publish(event, ...)
    if EventBus.listeners[event] then
        for _, callback in ipairs(EventBus.listeners[event]) do
            callback(...)
        end
    end
end

return EventBus
