return core.WorldConstructor("DefaultWorld",function(...)
    return {
        systems = {
            core:createSystem("CollisionInitSystem"),

            core:createSystem("MoveControlSystem"),
            core:createSystem("MoveSystem"),
            core:createSystem("MoveEndSystem"),

            core:createSystem("BoxDebugDrawSystem"),
        },
        entities = {
            core:createEntity("Box",0,0,100,100),
            core:createEntity("Box",200,200,100,100),
            core:createEntity("Box",400,400,100,100)
        },
        enterUpdate = function(self)
            local player = core:createEntity("Box",150,50,50,50)
            core:getComponentConstructor("MoveControlComponent").make(player)
            core:getComponentConstructor("MoveComponent").make(player,200)
            self:addEntity(player)
        end,
        exitUpdate = function(self)end,
    }
end)