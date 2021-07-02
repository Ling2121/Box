local vector = require"library/vector"
local is_keyDown = love.keyboard.isDown

return core.SystemConstructor("MoveControlSystem",function(...)
    return {
        filter = core.tiny.requireAll(
            "MoveComponent",
            "MoveControlComponent"
        ),
        process = function(self,entity,dt)
            local vx,vy = 0,0
            if is_keyDown("w") then
                vy = -entity.speed
            end

            if is_keyDown("s") then
                vy = entity.speed
            end
            
            if is_keyDown("a") then
                vx = -entity.speed
            end

            if is_keyDown("d") then
                vx = entity.speed
            end

            entity.velocity.x,entity.velocity.y = vector.normalize(vx,vy)
        end
    }
end)