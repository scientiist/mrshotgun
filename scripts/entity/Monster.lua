local LivingEntity = require("scripts/entity/LivingEntity")

local image = love.graphics.newImage("assets/textures/entities/enemy.png")

local Monster = LivingEntity:new()

Monster:setInheritance({"MonsterEntity", "LivingEntity"})

Monster.facing = 0
Monster.destination = {x=0,y=0}
Monster.speed = 100
Monster.size = 32
Monster.walkspeed = 0.1

function Monster:update(dt)
	self.velocity = self.velocity + self.walkspeed + dt

	self.facing = math.atan2(player.location.y - self.location.y, player.location.x - self.location.x)

	self:walking(dt)
	self:mapCollision()

	if self.health < 1 then
		self:remove()
	end
end

function Monster:draw()
	if settings.debug then
		love.graphics.setColor(255, 0, 0, 128)
		love.graphics.rectangle("fill", self.location.x-self.size/2 - cameraX, self.location.y-self.size/2 - cameraY, self.size, self.size)
	end
	love.graphics.setColor(255,255,255)
	love.graphics.draw(image, self.location.x - cameraX, self.location.y - cameraY, self.facing, 1, 1, image:getWidth()/2, image:getHeight()/2)

	-- draw healthbar

	-- draw red
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.location.x - 20 - cameraX, self.location.y - 30 - cameraY, 40, 10)

	-- draw green
	love.graphics.setColor(0, 255, 0)
	--love.graphics.set
end

return Monster