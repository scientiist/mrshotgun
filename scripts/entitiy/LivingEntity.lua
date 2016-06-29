local BaseEntity = require("scripts/entity/BaseEntity.lua")

local LivingEntity = BaseEntity:new()

LivingEntity:addInheritance("LivingEntity")

LivingEntity.location.facing = 0
LivingEntity.size = 16
LivingEntity.health = 100
LivingEntity.maxHealth = 100

function LivingEntity:update(dt)
	local entities = {}
	for i = 1, #entities do
		if entities[i]:instanceOf("LivingEntity") then

		end
	end
end

function LivingEntity:draw()

end