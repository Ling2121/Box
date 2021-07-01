return core.ComponentConstructor("PositionComponent",{
    make = function(entity,x,y)
        entity.x = x or 0
        entity.y = y or 0
    end,

    remove = function(entity)
        entity.x = nil
    entity.y = nil
    end
})