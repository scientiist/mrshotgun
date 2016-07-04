local LivingEntity = require("scripts/entity/LivingEntity")

local image = love.graphics.newImage("assets/textures/enemy.png")

local Monster = LivingEntity:new()

Monster:addInheritance("MonsterEntity")


Monster.destination = {x=0,y=0}

function Monster:update(dt)
	self.velocity = self.velocity + self.walkspeed + dt

	self.location.facing = math.atan2(player.location.y - self.location.y, player.location.x - self.location.x)

	self:walking(dt)
	self:mapCollision()

end

function Monster:draw()
	love.graphics.setColor(255, 0, 0, 128)
	love.graphics.rectangle("fill", self.location.x-self.size, self.location.y-self.size, self.size*2, self.size*2)

	love.graphics.setColor(255, 255, 0)
	love.graphics.draw(image, self.location.x, self.location.y, self.location.facing, 1, 1, image:getWidth()/2, image:getHeight()/2)
end

return Monster