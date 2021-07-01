local utilities = {}

FILE_TYPE_IMAGE = 0
FILE_TYPE_AUDIO = 1
FILE_TYPE_FONT = 2
FILE_TYPE_TILESET = 3

local match_table = {
    -- lua文件
    {"([0-9a-zA-z_]+)%.lua", "lua_file",".lua"},

    -- 图像文件
    {"([0-9a-zA-z_]+)%.png", FILE_TYPE_IMAGE,".png"},
    {"([0-9a-zA-z_]+)%.jpg", FILE_TYPE_IMAGE,".jpg"},
    {"([0-9a-zA-z_]+)%.jpeg",FILE_TYPE_IMAGE,".jpeg"},

    -- 音频
    {"([0-9a-zA-z_]+)%.ogg", FILE_TYPE_AUDIO,".ogg"},
    {"([0-9a-zA-z_]+)%.mp3", FILE_TYPE_AUDIO,".mp3"},
    {"([0-9a-zA-z_]+)%.wav", FILE_TYPE_AUDIO,".wav"},

    -- 字体
    {"([0-9a-zA-z_]+)%.otf", FILE_TYPE_FONT,".otf"},
    {"([0-9a-zA-z_]+)%.ttf", FILE_TYPE_FONT,".ttf"},

    --tileset
    {"([0-9a-zA-z_]+)%.tileset", FILE_TYPE_TILESET,".tileset"},
}

function utilities.getAllFileItem(dir,tb)
    tb = tb or {}
    local fitem = love.filesystem.getDirectoryItems(dir)

    for k,name in ipairs(fitem) do
        local p = dir.."/"..name
        local type =  love.filesystem.getInfo(p).type

        for i,matstr in ipairs(match_table) do
            local mat = matstr[1]
            local t = matstr[2]
			local n = name:match(mat) 
			if n then
                table.insert(tb,{
                    name = n,
                    type = t,
                    path = dir .. "/" .. name,--带拓展名的路径
                    path2 = dir .."/" ..n,--不带拓展名的路径
                    dir = dir,
				})
				break
            end
        end

        if type == "directory" then
            utility.getAllFileItem(p,tb)
        end
	end

    return tb
end

function utilities.PPCenter(p1x,p1y,p2x,p2y)
    return math.floor((p1x + p2x) / 2),math.floor((p1y + p2y) / 2)
end

function utilities.PPRadian(p1x,p1y,p2x,p2y)
    if p1x==p2x and p1y==p2y then return 0 end 
	local r = - math.atan((p2x-p1x)/(p2y-p1y))
	if p1y-p2y<0 then r=r+math.pi end
	if r<0 then r=r+2*math.pi end
	return r
end

return utilities