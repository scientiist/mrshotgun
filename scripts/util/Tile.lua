local textureFolder = "assets/textures/tiles/"
local Tile = {}
-- return tile image
function Tile.newTile(arg_name, arg_image)
	return {name = arg_name, image = love.graphics.newImage(textureFolder..arg_image)}
end

return Tile