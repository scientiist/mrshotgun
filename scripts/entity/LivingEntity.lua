---------------------------------------------------------------------
-- LivingEntity: the parent class to the most complicated entities --
---------------------------------------------------------------------

-- grab our requirements
-- parent base entity
local BaseEntity = require("scripts/entity/BaseEntity")

-- entityType enum
local EntityType = require("scripts/entity/EnumEntityType")

-- create our new guy
local LivingEntity = BaseEntity:new()

-- Go ahead and make him his own thing
LivingEntity:addInheritance("LivingEntity")

-- everything a Living entity needs
LivingEntity.location.facing = 0 -- direction facing 
LivingEntity.size = 16 -- radius size of the entity's BoundingBox
LivingEntity.health = 100 
LivingEntity.maxHealth = 100

-- function that happens every game tick
function LivingEntity:update(dt)
	local entities = {}
	for i = 1, #entities do
		if entities[i]:instanceOf(EntityType.LIVING_ENTITY) then
			-- run collision
		end
	end
end

-- is called every render loop
function LivingEntity:draw()

end