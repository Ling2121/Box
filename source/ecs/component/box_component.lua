return core.ComponentConstructor("BoxComponent",{
    make = function(entity,w,h)
        entity.width = w or 0
        entity.height = h or 0
    end,

    remove = function(entity)
        entity.width = nil
        entity.height = nil
    end
})