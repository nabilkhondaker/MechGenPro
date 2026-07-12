local Timeline = {
    isPlaying = true,
    currentTime = 0,
    speedMultiplier = 1.0
}

function Timeline.togglePlay()
    Timeline.isPlaying = not Timeline.isPlaying
end

function Timeline.update(dt, mechanism)
    if Timeline.isPlaying then
        Timeline.currentTime = Timeline.currentTime + (dt * Timeline.speedMultiplier)
        mechanism.theta2 = Timeline.currentTime -- Force mechanism to timeline
    end
end

function Timeline.scrubTo(time)
    Timeline.currentTime = time
end

return Timeline
