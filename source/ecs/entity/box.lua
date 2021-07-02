local PositionComponent =require"source/ecs/component/position_component"
local BoxComponent = require"source/ecs/component/box_component"
local CollisionComponent = require"source/ecs/component/collision_component"

return core.EntityConstructor("Box",function(x,y,w,h)
    local entity = {}
    PositionComponent.make(entity,x,y)
    BoxComponent.make(entity,w,h)
    CollisionComponent.make(entity)
    return entity
end)