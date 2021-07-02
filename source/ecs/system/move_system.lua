return core.SystemConstructor("MoveSystem",function(...)
    return {
        filter = core.tiny.requireAll(
            "PositionComponent",
            "MoveComponent"
        ),
        process = function(self,entity,dt)
            --带碰撞的移动需要Collision(bump.lua)模块的支持
            local is_collision_move = entity.CollisionComponent ~= nil and core:hasModule("Collision")
            local vx = ((entity.velocity.x * entity.speed) * dt)
            local vy = ((entity.velocity.y * entity.speed) * dt)
            if is_collision_move then
                local collision_world = core:getModule("Collision")
                collision_world:move(entity,entity.x + vx,entity.y + vy)
            else
                entity.x = entity.x + vx
                entity.y = entity.y + vy
            end
        end
    }
end)