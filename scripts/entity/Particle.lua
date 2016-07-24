---------------------------------------------------------
--

local BaseEntity = require("scripts/entity/BaseEntity")
local Utils = require("scripts/util/Utils")
local Particle = BaseEntity:new()

Particle:setInheritance({"LivingEntity", "Particle"})

Particle.health = 0.1
Particle.color = {255,255,255}
Particle.type = "spark"
Particle.location = {x = 0, y = 0}
Particle.facing = 0

function Particle:remove()
	table.remove(map.entities, Utils.indexOf(map.entities, self))
	collectgarbage()
end

function Particle:update(dt)
	self.health = self.health - dt

	if self.health < 0 then
		self:remove()
	end

	if self.type == "spark" then
		self.location.x = self.location.x + ((math.cos(self.facing) * (10) * dt))+ math.random(-1, 1)
		self.location.y = self.location.y + ((math.sin(self.facing) * (10) * dt))+ math.random(-1, 1)

		--self.location.y = self.location.y 
		--self.location.x = self.location.x + math.random(-1, 1)
	end

end

function Particle:draw()

	-- draw the spark particle
	if self.type == "spark" then
		love.graphics.setColor(255,200,0)
		love.graphics.circle("fill", self.location.x - cameraX, self.location.y - cameraY, 2, 4)
	end

	-- draw the bloodsplat particle
	if self.type == "bloodsplat" then
		love.graphics.setColor(200,10,0, 128)
		love.graphics.circle("fill", self.location.x - cameraX, self.location.y - cameraY, 5, 10)
	end
end

return Particle