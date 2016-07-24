------------------------------------------------------
-- Bullet object - Projectile that damages entities --
------------------------------------------------------

-- require physics and other stuff
local Physics = require("scripts/util/PhysicsUtil")
local Vector2 = require("scripts/util/Vector2")
local Maprender = require("scripts/map/Maprender")
local Utils = require("scripts/util/Utils")
local Particle = require("scripts/entity/Particle")
local LivingEntity = require("scripts/entity/LivingEntity")

math.randomseed(os.clock())
-- make the bullet it's own thing
local Bullet = LivingEntity:new({})

Bullet:setInheritance({"LivingEntity", "BulletEntity"})


Bullet.speed = 500
Bullet.damage = 2


-- bullet hitting walls and shit
function Bullet:mapCollision()
	for ya = 1, #map.tiles do
		for xa = 1, #map.tiles[ya] do
			-- grab the ID of the tile at this location
			-- check if it is a collidable block
			if Utils.tableContains(Maprender.collidables, map.tiles[ya][xa]) then

				if Physics.checkAABB(self.location.x, self.location.y, 1, 1, xa*32, ya*32, 32, 32) then
					local sendFacing = self.facing + math.random(-12, 12)
					table.insert(map.entities, Particle:new({location = self.location, facing = sendFacing}))
					self:remove()
				end
			end
		end
	end
end



-- update code
function Bullet:update(dt)
	
	for i = 1, #map.entities do
		if map.entities[i] ~= nil and map.entities[i]:instanceOf("MonsterEntity") then
			local en = map.entities[i]

			if Physics.checkAABB(self.location.x, self.location.y, 1, 1, en.location.x-en.size/2, en.location.y-en.size/2, en.size, en.size) then
				en:damage(self.damage)
				en.velocity = -en.velocity
				self:remove()
			end
		end
	end

	-- facing
	--self.facing = math.atan2(self.location.y - self.location.y, self.destination.y - self.destination.x)

	-- use simple linear speed to move a bullet
	self.location.x = self.location.x + ((math.cos(self.facing) * (self.speed)) * dt)
	self.location.y = self.location.y + ((math.sin(self.facing) * (self.speed)) * dt)
	self:mapCollision()
end

function Bullet:draw()
	love.graphics.setColor(255, 69, 0)
	love.graphics.rectangle("fill", self.location.x - cameraX, self.location.y - cameraY, 6, 6, 6, 6)
end

return Bullet