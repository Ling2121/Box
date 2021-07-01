return function(name,make_fn)
    return {
        name = name,
        make = function(...)
            local e = make_fn(...)
            e._entity_type = name
            return e
        end,
    }
end