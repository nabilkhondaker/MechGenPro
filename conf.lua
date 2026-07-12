function love.conf(t)
    t.window.title = "MechGenPro - Kinematics Engine"
    t.window.width = 1280
    t.window.height = 720
    t.window.vsync = 1
    t.window.resizable = true
    t.window.msaa = 4 -- Anti-aliasing for smooth mechanical lines
    t.console = true  -- Windows only: attach a console
end
