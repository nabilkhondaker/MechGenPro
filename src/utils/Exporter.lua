local Exporter = {}

function Exporter.exportTraceToCSV(mechanism, filename)
    filename = filename or "kinematic_trace.csv"
    local file = io.open(filename, "w")
    
    if not file then
        print("Error: Could not open file for exporting.")
        return false
    end
    
    file:write("Point_X,Point_Y\n")
    for _, point in ipairs(mechanism.tracePath) do
        file:write(string.format("%.3f,%.3f\n", point.x, point.y))
    end
    
    file:close()
    print("Successfully exported trace data to " .. filename)
    return true
end

return Exporter
