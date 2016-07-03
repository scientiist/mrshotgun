local LivingEntity = require("scripts/entity/LivingEntity")

local Monster = LivingEntity:new()

Monster:addInheritance("MonsterEntity")

Monster.destination = {x=0,y=0}

function Monster:update(dt)
	--self.velocity = self.velocity + self.walkspeed + dt

	self.location.facing = math.atan2(self.destination.y - self.location.y, self.destination.x - self.location.x)

	self:walking(dt)
	self:mapCollision()

end

function Monster:draw()
	love.graphics.setColor(255, 0, 0, 128)
	love.graphics.rectangle("fill", self.location.x-self.size, self.location.y-self.size, self.size*2, self.size*2)

	love.graphics.setColor(255, 255, 0)
	love.graphics.line(self.location.x, self.location.y, self.destination.x, self.destination.y)
end

return Monster