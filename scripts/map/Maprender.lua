local Tile = require("scripts/util/Tile")

local Maprender = {}

Maprender.tiles = {
	Tile.newTile("Grass", "grass.png"),
	Tile.newTile("WallUp", "wall_up.png"),
	Tile.newTile("WallSide", "wall_side.png"),
}


function Maprender:draw()
	for y = 1, #map.tiles do
		for x = 1, #map.tiles[y] do
			local tile = map.tiles[y][x]
			for i = 1, #Maprender.tiles do
				if Maprender.tiles[i].name == tile then

					local image = Maprender.tiles[i].image
					
					love.graphics.draw(image, x*32-cameraX, y*32-cameraY, 0, 2, 2)
				end
			end
		end
	end
end

return Maprender