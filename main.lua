local core = require"source/core"

function love.load()
    local camera_module = require"source/ecs/module/camera"
    local collision_module = require"source/ecs/module/collision"
    core:addModule("Camera",camera_module)
    core:addModule("Collision",collision_module)
    
    local world = core:addWorld("source/ecs/world/default_world")
    core:switchWorld(world)
end