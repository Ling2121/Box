return core.ComponentConstructor("MoveComponent",{
    make = function(entity,speed)
        entity.speed = speed or 100
        entity.velocity = {x = 0,y = 0}
    end,

    remove = function(entity)
        entity.speed = nil
        entity.velocity = nil
    end
})