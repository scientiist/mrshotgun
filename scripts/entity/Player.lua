local Physics = require("scripts/util/PhysicsUtil")
local LivingEntity = require("scripts/entity/LivingEntity")

local Player = LivingEntity:new()

local image = love.graphics.newImage("assets/textures/playerBody.png")

Player:addInheritance("PlayerEntity")

Player.networkInfo = {}
Player.score = 0
Player.location = {x = 50, y = 200}
Player.size = 16
Player.velocity = 0
Player.walkspeed = 0.4
Player.speed = 4
Player.maxVelocity = 1.0
Player.grip = 8


function Player:update(dt)
	if love.keyboard.isDown("w") then
		self.velocity = self.velocity + self.walkspeed + dt
	end

	if love.keyboard.isDown("s") then
		self.velocity = self.velocity - self.walkspeed + dt
	end


	self.rotation = math.atan2(love.mouse.getY() - self.location.y, love.mouse.getX() - self.location.x)
	self.location.x = self.location.x + ((math.cos(self.rotation) * (self.speed * self.velocity)) + dt)
	self.location.y = self.location.y + ((math.sin(self.rotation) * (self.speed * self.velocity)) + dt)

	if self.velocity > self.maxVelocity then
		self.velocity = self.maxVelocity
	elseif self.velocity < (-self.maxVelocity) then
		self.velocity = (-self.maxVelocity)
	end

	self.velocity = self.velocity * (1 - math.min(dt*self.grip, 1))

	if math.abs(self.velocity) <= 0.1 then
		self.velocity = 0
	end

	

	for ya = 1, #map do
		for xa = 1, #map[ya] do
			local kek = Physics.isColliding({x=self.location.x-self.size-1, y=self.location.y-self.size-1, width=self.size*2+1, height=self.size*2+1}, {x=xa*64, y=ya*64, width=64, height=64})
			if map[ya][xa] == 1 then

				if kek then
					if kek == "r" then
						self.location.x = xa*64+64+self.size
					end

					if kek == "l" then
						self.location.x = xa*64-self.size
					end

					if kek == "t" then
						self.location.y = ya*64-self.size
					end

					if kek == "b" then
						self.location.y = ya*64+64+self.size
					end
				end
			end
		end
	end
end

function Player:draw()
	love.graphics.setColor(255, 0, 0, 128)
	love.graphics.rectangle("fill", self.location.x-self.size, self.location.y-self.size, self.size*2, self.size*2)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(image, self.location.x, self.location.y, self.rotation, 1, 1, image:getWidth()/2, image:getHeight()/2)

end

return Player