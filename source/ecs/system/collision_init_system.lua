return core.SystemConstructor("CollisionInitSystem",function(...)
    return {
        system_type = "init",

        filter = core.tiny.requireAll(
            "PositionComponent",
            "BoxComponent",
            "CollsionInitSystem"
        ),

        init = function(self,entity)
            local collision = core:getModule("Collision")
            if collision ~= nil then
                collision:add(entity)
            end
        end
    }
end)