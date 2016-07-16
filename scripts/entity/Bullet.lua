------------------------------------------------------
-- Bullet object - Projectile that damages entities --
------------------------------------------------------

-- require physics and other stuff
local LivingEntity = require("scripts/entity/LivingEntity")
local Physics = require("scripts/util/PhysicsUtil")
local Vector2 = require("scripts/util/Vector2")

local BaseEntity = require("scripts/entity/BaseEntity")

-- make the bullet it's own thing
local Bullet = LivingEntity:new({})

Bullet:setInheritance({"LivingEntity", "BulletEntity"})


Bullet.speed = 500
Bullet.damage = 20


-- bullet hitting walls and shit
function Bullet:mapCollision()
	for ya = 1, #map.tiles do
		for xa = 1, #map.tiles[ya] do
			local kek = Physics.isColliding({x=self.location.x-self.size/2-1, y=self.location.y-self.size/2-1, width=self.size+1, height=self.size+1}, {x=xa*32, y=ya*32, width=32, height=32})
			
			-- grab the ID of the tile at this location
			-- check if it is a collidable block
			if map.tiles[ya][xa] ~= "Grass" then

				if kek then
					if kek == "r" then
						-- hit the right side
					end

					if kek == "l" then
						self.location.x = xa*32-self.size/2
					end

					if kek == "t" then
						self.location.y = ya*32-self.size/2
					end

					if kek == "b" then
						self.location.y = ya*32+32+self.size/2
					end
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

			local playerRect = {x=self.location.x-self.size/2-1, y=self.location.y-self.size/2-1, width=self.size+1, height=self.size+1}
			local otherEntityRect = {x=en.location.x-en.size/2-1, y=en.location.y-en.size/2-1, width=en.size+1, height=en.size+1}
				
			local kek = Physics.isColliding(otherEntityRect, playerRect)
			if kek then
				if kek == "r" then
					en.location.x = self.location.x+self.size/2+en.size/2
				end

				if kek == "l" then
					en.location.x = self.location.x-self.size/2-en.size/2
				end

				if kek == "t" then
					en.location.y = self.location.y-self.size/2-en.size/2
				end

				if kek == "b" then
					en.location.y = self.location.y+self.size/2+en.size/2
				end
				en:damage(20)
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
	love.graphics.rectangle("fill", self.location.x, self.location.y, 6, 6, 6, 6)
end

return Bullet