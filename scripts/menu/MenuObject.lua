-------------------------------------
-- Menu object thingy --
------------------------
local BaseEntity = require("scripts/entity/BaseEntity")
local ButtonObject = require("scripts/menu/ButtonObject")

local MenuObject = BaseEntity:new()

MenuObject:setInheritance({"MenuObject"})

MenuObject.objects = {
	ButtonObject:new({clicked = function() print("Clicked") end, text = "Button", y = 384}),
}



function MenuObject:update(dt)
	for i = 1, #self.objects do
		self.objects[i]:update(dt)
	end
end

return MenuObject