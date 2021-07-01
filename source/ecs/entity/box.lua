local PositionComponent =require"source/ecs/component/position_component"
local BoxComponent = require"source/ecs/component/box_component"

return core.EntityConstructor("Box",function(x,y,w,h)
    local entity = {}
    PositionComponent.make(entity,x,y)
    BoxComponent.make(entity,w,h)
    return entity
end)