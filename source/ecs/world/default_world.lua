return core.WorldConstructor("DefaultWorld",function(...)
    return {
        systems = {
            core:createSystem("BoxDebugDrawSystem"),
        },
        entities = {
            core:createEntity("Box",0,0,100,100),
            core:createEntity("Box",0,200,100,100),
            core:createEntity("Box",0,300,100,100)
        },
        enterUpdate = function(self)end,
        exitUpdate = function(self)end,
    }
end)