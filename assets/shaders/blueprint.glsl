extern number time;
extern vec2 screenSize;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // Blueprint background color (dark engineering blue)
    vec3 bgBase = vec3(0.04, 0.11, 0.18);
    
    // Dynamic grid sizing based on screen coordinates
    float gridSize = 50.0;
    float minorGridSize = 10.0;
    
    // Calculate grid lines
    float gridX = mod(screen_coords.x, gridSize);
    float gridY = mod(screen_coords.y, gridSize);
    float minorX = mod(screen_coords.x, minorGridSize);
    float minorY = mod(screen_coords.y, minorGridSize);
    
    // Line intensities (anti-aliased mathematically using smoothstep)
    float majorLine = (1.0 - smoothstep(0.0, 1.5, gridX)) + (1.0 - smoothstep(0.0, 1.5, gridY));
    float minorLine = (1.0 - smoothstep(0.0, 1.0, minorX)) + (1.0 - smoothstep(0.0, 1.0, minorY));
    
    vec3 lineColor = vec3(0.3, 0.5, 0.8);
    vec3 finalColor = bgBase + (lineColor * majorLine * 0.4) + (lineColor * minorLine * 0.1);
    
    // Vignette effect (darken the edges)
    vec2 center = screenSize * 0.5;
    float dist = distance(screen_coords, center);
    float vignette = smoothstep(screenSize.x * 0.7, screenSize.x * 0.2, dist);
    
    return vec4(finalColor * vignette, 1.0);
}
