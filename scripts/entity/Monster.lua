local LivingEntity = require("scripts/entity/LivingEntity")

local image = love.graphics.newImage("assets/textures/entities/enemy.png")

local Monster = LivingEntity:new()

Monster:setInheritance({"MonsterEntity", "LivingEntity"})

Monster.facing = 0
Monster.destination = {x=0,y=0}
Monster.speed = 50
Monster.size = 32

function Monster:update(dt)
	self.velocity = self.velocity + self.walkspeed + dt

	self.facing = math.atan2(player.location.y - self.location.y, player.location.x - self.location.x)

	self:walking(dt)
	self:mapCollision()

	--[[for i = 1, #self._inheritance do
		print(self._inheritance[i])
	end]]

end

function Monster:draw()
	if settings.debug then
		love.graphics.setColor(255, 0, 0, 128)
		love.graphics.rectangle("fill", self.location.x-self.size/2, self.location.y-self.size/2, self.size, self.size)
	end
	love.graphics.setColor(255,255,255)
	love.graphics.draw(image, self.location.x, self.location.y, self.facing, 1, 1, image:getWidth()/2, image:getHeight()/2)
end

return Monster