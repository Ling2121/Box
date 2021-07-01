local core = require"source.core"

function love.load()
    local camera_module = require"source/ecs/module/camera"
    core:addModule("Camera",camera_module)
    core:addWorld("DefaultWorld","source/ecs/world/default_world")
    core:switchWorld("DefaultWorld")
end