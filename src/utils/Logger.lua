local Logger = {
    LEVELS = { INFO = 1, WARN = 2, ERROR = 3 },
    currentLevel = 1
}

function Logger.log(level, msg)
    if level >= Logger.currentLevel then
        local prefix = "[INFO] "
        if level == Logger.LEVELS.WARN then prefix = "[WARN] " end
        if level == Logger.LEVELS.ERROR then prefix = "[ERROR] " end
        
        -- Write to console and append to a debug file
        local fullMsg = os.date("%H:%M:%S ") .. prefix .. msg
        print(fullMsg)
        
        local f = io.open("mechgen_debug.log", "a")
        if f then
            f:write(fullMsg .. "\n")
            f:close()
        end
    end
end

function Logger.info(msg) Logger.log(Logger.LEVELS.INFO, msg) end
function Logger.warn(msg) Logger.log(Logger.LEVELS.WARN, msg) end
function Logger.error(msg) Logger.log(Logger.LEVELS.ERROR, msg) end

return Logger
