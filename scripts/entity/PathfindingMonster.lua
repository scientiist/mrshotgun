local LivingEntity = require("scripts/entity/LivingEntity")

local image = love.graphics.newImage("assets/textures/entities/enemy.png")

local PathfindingMonster = LivingEntity:new()

PathfindingMonster:setInheritance({"Pathfinder", "MonsterEntity", "LivingEntity"})

PathfindingMonster.facing = 0
PathfindingMonster.destination = {x=0,y=0}
PathfindingMonster.speed = 50
PathfindingMonster.size = 32
PathfindingMonster.pathingGrid = {}
PathfindingMonster.pathUpdate = 0

function PathfindingMonster:pathfind()
	for y = 1, #map.tiles do
		self.pathingGrid[y] = {}
		for x = 1, #map.tiles[y] do
			local tile = map.tiles[y][x]
			if tile == "Grass" then
				self.pathingGrid[y][x] = 1
			else
				self.pathingGrid[y][x] = 0
			end
		end
	end
end

function PathfindingMonster:update(dt)
	self.velocity = self.velocity + self.walkspeed + dt

	self.facing = math.atan2(player.location.y - self.location.y, player.location.x - self.location.x)

	self:walking(dt)
	self:mapCollision()

	--[[for i = 1, #self._inheritance do
		print(self._inheritance[i])
	end]]

	if self.health < 1 then
		self:remove()
	end

	self.pathUpdate = self.pathUpdate + dt

	if self.pathUpdate >= 0.2
end

function PathfindingMonster:draw()
	if settings.debug then
		love.graphics.setColor(255, 0, 0, 128)
		love.graphics.rectangle("fill", self.location.x-self.size/2, self.location.y-self.size/2, self.size, self.size)
	end
	love.graphics.setColor(255,255,255)
	love.graphics.draw(image, self.location.x, self.location.y, self.facing, 1, 1, image:getWidth()/2, image:getHeight()/2)
end

return PathfindingMonster