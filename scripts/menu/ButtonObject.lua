----------------------------------------------
-- Button object for Mr Shotgun menu system --
----------------------------------------------

-- requirements
local BaseEntity = require("scripts/entity/BaseEntity")
local PhysicsUtil = require("scripts/util/PhysicsUtil")

-- create new object
local ButtonObject = BaseEntity:new()

-- add it's own variables
ButtonObject:setInheritance({"ButtonObject"})

ButtonObject.x = love.graphics.getWidth()/2 -- location
ButtonObject.y = 256
ButtonObject.text = "Button" -- text
ButtonObject.tooltip = nil -- tooltip text
ButtonObject.width = 192
ButtonObject.height = 48
ButtonObject.clickedDeb = false -- if it's clicked
ButtonObject.mouseOver = false -- if the mouse is over it

-- update the button object
function ButtonObject:update(dt)
	if PhysicsUtil.checkAABB(mouseX, mouseY, 1, 1, self.x, self.y, self.width, self.height) == true then
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

function ButtonObject:clicked() -- note: 1 = left, 2 = right
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