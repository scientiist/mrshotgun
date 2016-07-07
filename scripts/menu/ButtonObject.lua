----------------------------------------------
-- Button object for Mr Shotgun menu system --
----------------------------------------------

local BaseEntity = require("scripts/entity/BaseEntity")
local PhysicsUtil = require("scripts/util/PhysicsUtil")

local ButtonObject = BaseEntity:new()

ButtonObject:setInheritance({"MenuObject", "ButtonObject"})

ButtonObject.x = love.graphics.getWidth()/2
ButtonObject.y = 256
ButtonObject.text = "Button"
ButtonObject.tooltip = nil
ButtonObject.width = 192
ButtonObject.height = 48
ButtonObject.clickedDeb = false
ButtonObject.mouseOver = false

function ButtonObject:update(dt)
	if PhysicsUtil.checkAABB(love.mouse.getX(), love.mouse.getY(), 1, 1, self.x, self.y, self.width, self.height) == true then
		self.mouseOver = true
	else
		self.mouseOver = false
	end

	if love.mouse.isDown(1) and self.mouseOver == true then
		self.clickedDeb = true
	end

	if love.mouse.isDown(1) == false and self.clickedDeb == true then
		self.clickedDeb = false
		self:clicked(1)
	end
end


function ButtonObject:clicked(mouseButton) -- note: 1 = left, 2 = right
	print(self.text.." button was clicked!")
end

function ButtonObject:draw()
	if self.mouseOver then
		love.graphics.setColor(255,255,255)
	else
		love.graphics.setColor(0,0,0)
	end
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 2)
	love.graphics.setColor(50,50,50)
	love.graphics.rectangle("fill", self.x+5, self.y+5, self.width-10, self.height-10, 2)

	love.graphics.setColor(255, 0, 0)
	love.graphics.printf(self.text, self.x, self.y+self.height/3, self.width, "center")
end

return ButtonObject