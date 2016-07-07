---------------------------------------------------------------------
-- LivingEntity: the parent class to the most complicated entities --
---------------------------------------------------------------------

-- grab our requirements
local Physics = require("scripts/util/PhysicsUtil")


-- parent base entity
local BaseEntity = require("scripts/entity/BaseEntity")
local EntityType = require("scripts/entity/EnumEntityType")

-- create our new guy
local LivingEntity = BaseEntity:new()

-- Go ahead and make him his own thing
LivingEntity:setInheritance({"LivingEntity"})

-- everything a Living entity needs
LivingEntity.location.facing = 1 -- direction facing 
LivingEntity.size = 16 -- radius size of the entity's BoundingBox
LivingEntity.health = 100
LivingEntity.maxHealth = 100
LivingEntity.velocity = 0
LivingEntity.walkspeed = 0.4
LivingEntity.speed = 200
LivingEntity.maxVelocity = 1.0
LivingEntity.grip = 8

-- function all LivingEntities share, prevents clipping in blocks and shit
function LivingEntity:mapCollision()
	for ya = 1, #map.tiles do
		for xa = 1, #map.tiles[ya] do
			local kek = Physics.isColliding({x=self.location.x-self.size/2-1, y=self.location.y-self.size/2-1, width=self.size+1, height=self.size+1}, {x=xa*32, y=ya*32, width=32, height=32})
			
			-- grab the ID of the tile at this location
			-- check if it is a collidable block
			if map.tiles[ya][xa] == "Wall" then

				if kek then
					if kek == "r" then
						self.location.x = xa*32+32+self.size/2
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
				end
			end
		end
	end
end

--
function LivingEntity:walking(dt)
	self.location.x = self.location.x + ((math.cos(self.facing) * (self.speed * self.velocity)) * dt)
	self.location.y = self.location.y + ((math.sin(self.facing) * (self.speed * self.velocity)) * dt)

	if self.velocity > self.maxVelocity then
		self.velocity = self.maxVelocity
	elseif self.velocity < (-self.maxVelocity) then
		self.velocity = (-self.maxVelocity)
	end

	self.velocity = self.velocity * (1 - math.min(dt*self.grip, 1))

	if math.abs(self.velocity) <= 0.1 then
		self.velocity = 0
	end
end

-- function that happens every game tick
function LivingEntity:update(dt)
	
	self:mapCollision()
	self:walking()
end

-- is called every render loop
function LivingEntity:draw()

end

return LivingEntity