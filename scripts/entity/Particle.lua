local BaseEntity = require("scripts/entity/BaseEntity")

local Particle = BaseEntity:new()

Particle:setInheritance({"Particle"})

Particle.health = 1
Particle.color = {255,255,255}

function Particle:update(dt)
	self.health = self.health - dt

	if self.health < 0 then
		self:remove()
	end
end

function Particle:draw()
	love
end

return Particle