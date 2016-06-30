local Physics = require("scripts/util/PhysicsUtil")
-- entityType enum
local EntityType = require("scripts/entity/EnumEntityType")
local LivingEntity = require("scripts/entity/LivingEntity")
local Monster = require("scripts/entity/Monster")
local Player = LivingEntity:new()

local image = love.graphics.newImage("assets/textures/playerBody.png")

Player:addInheritance("PlayerEntity")

Player.score = 0
Player.location = {x = 50, y = 200, facing = 3}
Player.size = 16
Player.clickDeb = true

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function Player:update(dt)
	if love.mouse.isDown(1) and clickDeb == true then
		

		local kek = Monster:new()

		kek.location = {x = self.location.x, y = self.location.y}
		kek.destination = {x = love.mouse.getX(), y= love.mouse.getY()}

		table.insert(entities, kek)
		clickDeb = false
	else
		clickDeb = true
	end

	if Physics.getDistance(love.mouse.getX(), love.mouse.getY(), self.location.x, self.location.y) >= 20 then

		if love.keyboard.isDown("w") then
			self.velocity = self.velocity + self.walkspeed + dt
		end

		if love.keyboard.isDown("s") then
			self.velocity = self.velocity - self.walkspeed + dt
		end
	end

	


	self.location.facing = math.atan2(love.mouse.getY() - self.location.y, love.mouse.getX() - self.location.x)
	

	self:walking(dt)	
	self:mapCollision()
end

function Player:draw()
	love.graphics.setColor(255, 0, 0, 128)
	love.graphics.rectangle("fill", self.location.x-self.size, self.location.y-self.size, self.size*2, self.size*2)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(image, self.location.x, self.location.y, self.location.facing, 1, 1, image:getWidth()/2, image:getHeight()/2)

end

return Player