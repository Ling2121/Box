# Box

​	一个ECS开发框架，基于[LOVE2D](https://love2d.org)和 [tiny-ecs](https://github.com/bakpakin/tiny-ecs.git)。封装和整合了基础功能。目的是可以方便的进行基于ECS模式的游戏开发，同时具有可拓展性以及解耦合。

​	框架基本对象概念

- *World*    游戏世界，用来管理System和Entity
- *System*    系统，用于逻辑更新
- *Entity*     实体，Component集合
- *Component*     组件，数据集合
- *Module*    模块，World之外的独立模块,可以是任意对象（相机，物理系统，UI等等外部模块）

## World

​	world存放于 "source/ecs/world" 文件夹中，要创建一个世界需要在"source/ecs/world"文件夹或者其子目录创建一个"WorldConstructor"(世界构造器),可以通过 **core.WorldConstructor(name,constructor)** 函数创建。

```lua
--TestWorld.lua
return core.WorldConstructor("TestWorld",{
    --世界所包含的系统
	systems = { 
    	core:createSystem("MoveSystem"),
        core:createSystem("LifeSystem"),
    },
    --世界所包含的实体
    entities = {
        core:createEntity("Player"),  
        core:createEntity("Cat"),
    },
    --进入更新时执行（进入世界）
    enterUpdate = function(self)end,
    --退出更新时执行
    exitUpdate = function(self)end,    
})
```



> 当前为开发阶段，功能不完全，但已经通过tiny-ecs库实现了基本的ecs功能

------



🔨内容施工中...