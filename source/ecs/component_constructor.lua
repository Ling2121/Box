return function(name,constructor)
    return {
        name = name,
        make = function(e,...)
            constructor.make(e,...)
            e[name] = true
        end,
        remove = function(e)
            constructor.remove(e)
            e[name] = nil
        end,
    }
end