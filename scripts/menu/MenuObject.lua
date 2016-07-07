-------------------------------------
-- Menu object thingy --
------------------------
local BaseEntity = require("scripts/entity/BaseEntity")

local MenuObject = BaseEntity:new()

MenuObject:setInheritance({"MenuObject"})

function MenuObject:draw()
	love.graphics.setColor(0, 0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

return MenuObject