local Physics = require("scripts/util/PhysicsUtil")
local Vector2 = require("scripts/util/Vector2")
-- entityType enum
local EntityType = require("scripts/entity/EnumEntityType")
local LivingEntity = require("scripts/entity/LivingEntity")
local Monster = require("scripts/entity/Monster")
local Player = LivingEntity:new()

local image = love.graphics.newImage("assets/textures/entities/player.png")

Player:setInheritance({"PlayerEntity", "LivingEntity"})

Player.score = 0
Player.location = Vector2.new(100, 10)
Player.facing = 3
Player.size = 32

function Player:update(dt)
	

	if Physics.getDistance(love.mouse.getX(), love.mouse.getY(), self.location.x, self.location.y) >= 20 then

		if love.keyboard.isDown("w") then
			self.velocity = self.velocity + self.walkspeed + dt
		end

		if love.keyboard.isDown("s") then
			self.velocity = self.velocity - self.walkspeed + dt
		end
	end

	
	for i = 1, #map.entities do
		if map.entities[i]:instanceOf("MonsterEntity") then
			local en = map.entities[i]

			local playerRect = {x=self.location.x-self.size/2-1, y=self.location.y-self.size/2-1, width=self.size+1, height=self.size+1}
			local otherEntityRect = {x=en.location.x-en.size/2-1, y=en.location.y-en.size/2-1, width=en.size+1, height=en.size+1}
				
			local kek = Physics.isColliding(otherEntityRect, playerRect)
			if kek then
				if kek == "r" then
					en.location.x = self.location.x+self.size/2+en.size/2
				end

				if kek == "l" then
					en.location.x = self.location.x-self.size/2-en.size/2
				end

				if kek == "t" then
					en.location.y = self.location.y-self.size/2-en.size/2
				end

				if kek == "b" then
					en.location.y = self.location.y+self.size/2+en.size/2
				end

				en.velocity = -en.velocity
			end
		end
	end

	self.facing = math.atan2(love.mouse.getY() - self.location.y, love.mouse.getX() - self.location.x)
	

	self:walking(dt)	
	self:mapCollision()
end

function Player:draw()
	love.graphics.setColor(255, 0, 0, 128)
	love.graphics.rectangle("fill", self.location.x-self.size/2, self.location.y-self.size/2, self.size, self.size)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(image, self.location.x, self.location.y, self.facing, 1, 1, image:getWidth()/2, image:getHeight()/2)

end

return Player