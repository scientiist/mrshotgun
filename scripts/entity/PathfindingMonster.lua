------------------------------------------------------------------------------
-- Pathfinding enemy entity - uses A-Star pathfinding to locate it's target --
------------------------------------------------------------------------------

-- grab requirements
local LivingEntity = require("scripts/entity/LivingEntity")

local image = love.graphics.newImage("assets/textures/entities/enemy.png")


-- create new entity
local PathfindingMonster = LivingEntity:new()

-- set the entity's inheritance
PathfindingMonster:setInheritance({"Pathfinder", "MonsterEntity", "LivingEntity"})

-- custom vars
PathfindingMonster.facing = 0
PathfindingMonster.destination = {x=0,y=0}
PathfindingMonster.speed = 50
PathfindingMonster.size = 32
PathfindingMonster.pathingGrid = {}
PathfindingMonster.pathInc = 0
PathfindingMonster.target = nil

-- pathfinding function
function PathfindingMonster:pathfind(targetEntity)

	-- build grid of pathing tiles
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

	if self.health < 1 then
		self:remove()
	end

	-- we don't want to run pathfinding 
	-- add increment for pathfinding
	self.pathInc = self.pathInc + dt

	-- this statement is true once we've reached the limit
	-- the "equation" is 1/path_updates_per_second
	-- for example, 20 times a second is 0.05, and 1/60 is 0.0166666667
	if self.pathInc >= 0.05 then
		self:pathfind(self.target)
		self.pathInc = 0
	end
end

-- draw this monster
function PathfindingMonster:draw()

	-- hitbox
	if settings.debug then
		love.graphics.setColor(255, 0, 0, 128)
		love.graphics.rectangle("fill", self.location.x-self.size/2, self.location.y-self.size/2, self.size, self.size)
	end


	love.graphics.setColor(255,255,255)
	love.graphics.draw(image, self.location.x, self.location.y, self.facing, 1, 1, image:getWidth()/2, image:getHeight()/2)
end

return PathfindingMonster