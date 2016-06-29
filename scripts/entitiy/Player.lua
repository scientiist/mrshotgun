
local LivingEntity = require("scripts/entity/LivingEntity")

local Player = LivingEntity:new()

Player:addInheritance("PlayerEntity")

Player.networkInfo = {}
Player.score = 0

function Player:update(dt)
	
	
end

function Player:draw()
	
end