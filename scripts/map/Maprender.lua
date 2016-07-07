local Tile = require("scripts/util/Tile")

local Maprender = {}

Maprender.tiles = {
	Tile.newTile("Grass", "grass.png"),
}


function Maprender:draw()
	for y = 1, #map.tiles do
		for x = 1, #map.tiles[y] do
			if map.tiles[y][x] == 1 then
				love.graphics.setColor(100, 100, 100)
				love.graphics.rectangle("fill", x*64, y*64, 64, 64)
			end
		end
	end
end