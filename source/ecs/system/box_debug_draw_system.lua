return core.SystemConstructor("BoxDebugDrawSystem",function(...)
    return {
        filter = core.tiny.requireAll(
            "PositionComponent",
            "BoxComponent"
        ),

        draw = function(self,entity)
            love.graphics.rectangle("line",entity.x,entity.y,entity.width,entity.height)
        end
    }
end)