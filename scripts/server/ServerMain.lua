------------------------------------
-- Server-side code of Mr Shotgun --
------------------------------------

local socket = require("socket")

local serverSettings = {
	multiplayer = false,
	port = 1234,
}

local udp = socket.udp()

udp.setsockname('*', serverSettings.port)

local connectedPlayers = {}

local running = true

function updateServer(dt)
	data, msg_or_ip, port_or_nil = udp:recievefrom()

	if data then
		plr, cmd, params = data:match()
	end
end