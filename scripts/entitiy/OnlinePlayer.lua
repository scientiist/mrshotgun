local Player = require("scripts/entity/Player")

local OnlinePlayer = Player:new()

OnlinePlayer.username = ""
OnlinePlayer.ipAddress = ""

OnlinePlayer:addInheritance("OnlinePlayerEntity")