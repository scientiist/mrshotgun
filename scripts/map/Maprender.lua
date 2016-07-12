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
					
					love.graphics.draw(image, x*32-cameraX, y*32-cameraY)
				end
			end
		end
	end


	-- render image of placing
	love.graphics.setColor(255,255,255,100)
	for i = 1, #Maprender.tiles do
		if Maprender.tiles[i].name == editor.selectedBlock then
			local image = Maprender.tiles[i].image
			love.graphics.draw(image, mouseX*32-cameraX, mouseY*32, 0, image:getWidth()/(image:getWidth()*2), image:getHeight()/(image:getHeight()*2))
		end
	end
end

return Maprender