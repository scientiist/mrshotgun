local Tile = require("scripts/util/Tile")
local Physics = require("scripts/util/PhysicsUtil")

local Maprender = {}
local image = love.graphics.newImage("assets/textures/tiles/water.png")
Maprender.tiles = {
	Tile.newTile("Grass", "grass.png"),
	Tile.newTile("Floor", "floor.png"),
	Tile.newTile("WallUp", "wall_up.png"),
	Tile.newTile("WallSide", "wall_side.png"),
	Tile.newTile("WallCornerTL", "wall_corner_topleft.png"),
	Tile.newTile("WallCornerBL", "wall_corner_bottomleft.png"),
	Tile.newTile("WallCornerTR", "wall_corner_topright.png"),
	Tile.newTile("WallCornerBR", "wall_corner_bottomright.png"),
}

Maprender.collidables = {
	"WallUp",
	"WallSide",
	"WallCornerTL",
	"WallCornerBL",
	"WallCornerTR",
	"WallCornerBR",
}



function Maprender:draw()
	love.graphics.setColor(255,255,255)

	for y = 1, 16 do
		for x = 1, 16 do
			love.graphics.draw(image, x*128-192+flux-cameraX*0.1, y*128-192-cameraY*0.1)
		end
	end

	for y = 1, #map.tiles do
		for x = 1, #map.tiles[y] do
			local tile = map.tiles[y][x]
			if tile ~= "" then
				for i = 1, #Maprender.tiles do
					if Maprender.tiles[i].name == tile then
						if Physics.checkAABB(cameraX, cameraY, love.graphics.getWidth(), love.graphics.getWidth(), x*32, y*32, 32, 32) then
							local image = Maprender.tiles[i].image
						
							love.graphics.draw(image, x*32-cameraX, y*32-cameraY)
						end
					end
				end
			end
		end
	end

	if runMode == "Editor" then
		-- render image of placing
		love.graphics.setColor(255,255,255,100)

		local lmouseX = math.floor((mouseX+cameraX)/32)
		local lmouseY = math.floor((mouseY+cameraY)/32)

		for i = 1, #Maprender.tiles do
			if Maprender.tiles[i].name == editor.selectedBlock then
				local image = Maprender.tiles[i].image
				love.graphics.draw(image, (lmouseX/scaleX)*32-cameraX, (lmouseY/scaleY)*32-cameraY)
			end
		end
	end
end

return Maprender