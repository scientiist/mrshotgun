local json = require("scripts/util/Json")

local Mapload = {}

local function genEmptyMap(xSize, ySize)
	local tiles={{}}
	for y = 1, ySize do
		tiles[y] = {}
		for x = 1, xSize do
			tiles[y][x] = "Grass"
		end
	end

	return tiles
end

function Mapload.readMap(mapFileName)
	
	local mapFile = io.open(mapFileName..".map", 'r')
	local loadMap
	local map = {entities={},tiles={},metadata={}}

	if mapFile == nil then
		map = {metadata = {name = ""}, entities = {}, tiles = genEmptyMap(128,128)}
	else
		loadMap = json.decode(mapFile:read())

		map.metadata = loadMap.metadata
		map.tiles = loadMap.tiles

		for i = 1, #loadMap.entities do
			local entity = convertSaveToEntity(loadMap.entities[i])
			print(entity)
			table.insert(map.entities, entity)
		end
		mapFile:close()
	end
	

	return map
end

function Mapload.writeMap(mapFileName, map)
	local saveMap = {}
	saveMap.metadata = map.metadata
	saveMap.tiles = map.tiles
	saveMap.entities = {}
	for i = 1, #map.entities do
		saveMap.entities[i] = map.entities[i]:returnSaveData()
	end

	local mapFile = io.open(mapFileName..".map", 'w')

	mapFile:write(json.encode(saveMap))
	mapFile:close()

	print("File saved!")
end

return Mapload