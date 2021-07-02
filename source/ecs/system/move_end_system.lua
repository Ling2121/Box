return core.SystemConstructor("MoveEndSystem",function(...)
    return {
        filter = core.tiny.requireAll(
            "PositionComponent",
            "MoveComponent"
        ),
        process = function(self,entity,dt)
            entity.velocity.x = 0
            entity.velocity.y = 0
        end
    }
end)