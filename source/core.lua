--[[
    整个框架以ECS模式为核心，需要高度的解耦合以及模块化。tiny-ecs库为ECS的核心实现，
    通过一个全局Core对象管理整个游戏系统的调度。

    World 游戏世界，用来管理System和Entity
    System 系统，用于逻辑更新
    Entity 实体，Component集合
    Component 组件，数据集合
    Module 模块，World之外的独立模块,可以是任意对象
--]]

local tiny = require"library/tiny-ecs/tiny"
local ComponentConstructor = require"source/ecs/component_constructor"
local EntityConstructor = require"source/ecs/entity_constructor"
local SystemConstructor = require"source/ecs/system_constructor"
local WorldConstructor = require"source/ecs/world_constructor"
local Utilities = require"source/utilities"

core = {
    tiny = tiny,
    world = nil,
    worlds = {},
    modules = {},
    component_constructors = {},
    entity_constructors = {},
    system_constructors = {},

    callback_list = {	
        "quit",
        "draw",
        "update",
        "directorydropped",
        "filedropped",
        "keypressed",
        "keyreleased",
        "textedited",
        "textinput",
        "mousemoved",
        "mousepressed",
        "mousereleased",
        "wheelmoved",
    },

    ComponentConstructor = ComponentConstructor,
    EntityConstructor = EntityConstructor,
    SystemConstructor = SystemConstructor,
    WorldConstructor = WorldConstructor,
}

function core:init()
    local items

    items = Utilities.getAllFileItem("source/ecs/component")
    for i,item in pairs(items) do
        if item.type == "lua_file" then
            self:importComponentConstructor(item.path2)
        end
    end

    items = Utilities.getAllFileItem("source/ecs/entity")
    for i,item in pairs(items) do
        
        if item.type == "lua_file" then
            self:importEntityConstructor(item.path2)
        end
    end

    items = Utilities.getAllFileItem("source/ecs/system")
    for i,item in pairs(items) do
        
        if item.type == "lua_file" then
            self:importSystemConstructor(item.path2)
        end
    end

    return self
end

--[[
    arg各类型时的解释方式 
    1.string 表示通过已定义的实体构造器进行构造
    2.table 表示通过自定义的组件组合进行构造
        //结构
        table { 
            ["组件名称"] = {构造参数},
            ["组件名称"] = {构造参数},
            ["组件名称"] = {构造参数},
            ...
        }
--]]
function core:createEntity(arg,...)
    local entity
    if type(arg) == "string" then
        local constructor = self:getEntityConstructor(arg)
        entity = constructor.make(...)
    else
        entity = {}
        for component_name,constructor_args in pairs(arg) do
            local component_constructor = self:getComponentConstructor(component_name)
            if component_constructor then
                component_constructor.make(entity)
            end
        end
    end
    return entity
end

function core:createSystem(name,...)
    local constructor = self:getSystemConstructor(name)
    if not constructor then return end
    local system = tiny.processingSystem(constructor.make(...))
    system.filter = system.filter or function(s,e) return false end
    return system
end

function core:importComponentConstructor(path)
    local constructor = require(path)
    self.component_constructors[constructor.name] = constructor;
end

function core:importEntityConstructor(path)
    local constructor = require(path)
    self.entity_constructors[constructor.name] = constructor;
end

function core:importSystemConstructor(path)
    local constructor = require(path)
    self.system_constructors[constructor.name] = constructor;
end

function core:getComponentConstructor(name)
    return self.component_constructors[name]
end

function core:getEntityConstructor(name)
    return self.entity_constructors[name]
end

function core:getSystemConstructor(name)
    return self.system_constructors[name]
end

function core:loadWorld(path,...)
    local world_constructor = require(path)
    local world_struct = world_constructor.make(...)
    world_struct._world_name = world_constructor.name 
    return world_struct
end

function core:addWorld(worldStruct_or_path)
    local world_struct = worldStruct_or_path
    if type(world_struct) == "string" then
        world_struct = self:loadWorld(world_struct)
    end
    local tiny_world = tiny.world()
    tiny_world._init_systems = {}
    if world_struct.systems then
        for i,system in ipairs(world_struct.systems) do
            tiny_world:addSystem(system);
            if system.system_type == "init" then
                table.insert(tiny_world._init_systems,system)
            end
        end
    end
    if world_struct.entities then
        for i,entity in ipairs(world_struct.entities) do
            tiny_world:addEntity(entity);
        end
    end
    tiny_world._enterUpdate__ = world_struct.enterUpdate
    tiny_world._exitUpdate__ = world_struct.exitUpdate
    self.worlds[world_struct._world_name] = tiny_world
    return tiny_world
end

function core:makeWorldToLove(world)
    for i,callback_name in ipairs(self.callback_list) do
        local filter_fn = function(w,s)
            return s[callback_name] ~= nil
        end
        if callback_name == "update" then
            love["update"] = function(...)
                world:update(filter_fn,"process",...)
            end
        else
            love[callback_name] = function(...)
                world:update(filter_fn,callback_name,...)
            end
        end
    end
end

function core:switchWorld(name_or_world)
    local world = name_or_world
    if type(world) == "string" then
        world = self.worlds[name_or_world]
    end
    if not world then return false end
    if self.world then
        self.world:_exitUpdate__()
    end
    self.world = world;
    world:_enterUpdate__()

    for i,init_system in ipairs(world._init_systems) do
        for i,entity in ipairs(world.entitiesToChange) do
            if not init_system.filter(init_system,entity) then
                init_system:init(entity)
            end
        end
    end
    world._init_systems = {}

    self:makeWorldToLove(world);
    return true
end

function core:getWorld(name)
    if name == nil then
        return self.world
    end
    return self.worlds[name]
end

function core:addModule(name,module_or_path)
    local module = module_or_path
    if type(module) == "string" then
        module = require(module_or_path)
    end
    self.modules[name] = module
end

function core:getModule(name)
    return self.modules[name]
end

function core:hasModule(name)
    return self.modules[name] ~= nil
end

return core:init()