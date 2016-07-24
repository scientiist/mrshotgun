

local obj = {}

function obj:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

local Item = obj:new()

Item.id = 0x0
Item.icon = nil
Item.type = "food"

function Item:create(name, id, icon, type)
	return Item:new({self.id = id, self.icon = icon, self.type = type, self.name = name})
end

return Item