------------------------------------------------------------------------------------------
-- Top down zombie shooty game: "Mr Shotgun" by Joshua O'Leary (Juice, Csharp0, _j0shy) --
------------------------------------------------------------------------------------------

--[[
	The Mr Shotgun License

	Copyright (c) 2015 JuiceProjects

	Any person is allowed to use, modify, and redistribute this software
	free of charge, provided credit to the creator of Mr Shotgun is included.
	Persons may not charge money for this software, or substantial portions
	of this software.

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE. IN OTHER WORDS, I AM NOT LIABLE FOR JACK SHIT.

]]--


----------------------------------------------------
-- Load requirements for the game to run and such --
----------------------------------------------------

-- Utilities --
local Physics = require("scripts/util/PhysicsUtil")
local Json = require("scripts/util/Json")
local Mapload = require("scripts/map/Mapload")
local Maprender = require("scripts/map/Maprender")
-- Entities and Objects
local EntityType = require("scripts/entity/EnumEntityType")
local Player = require("scripts/entity/Player")
local Monster = require("scripts/entity/Monster")
-- Menu system
local Menu = require("scripts/menu/MenuSystem")


-- Metadata for Mr Shotgun
local meta = {
	version = "0.2.0", -- game version
}

-- perspective camera X and Y
cameraX, cameraY = 0, 0
mouseX, mouseY = 0, 0

-- Game editor information
editor = {
	selectedBlock = "Grass",
	selectedInt = 1,
	grid = false,
}

-- the runmode of the game
runMode = "Menu" -- Menu, Editor, Game

-- The actual map thingymaboop
map = {tiles={{}}}

-- Initializes the game
function startGame()
	player = Player:new()
	runMode = "Game"
	map = Mapload.readMap("MapFile")
	table.insert(map.entities, player)
end

-- Initializes the map editor
function startEditor()
	runMode = "Editor"
	map = Mapload.readMap("MapFile")
end

-- happens on game creation
function love.load()

	love.window.setMode(1024, 608, {vsync = false, fullscreen = false})
	love.window.setTitle("Mr Shotgun by Joshua O'Leary. v"..meta.version)
end

function love.wheelmoved(x, y)

	-- let's scroll the selected block
	editor.selectedInt = editor.selectedInt - y

	if editor.selectedInt > #Maprender.tiles then
		editor.selectedInt = 1
	elseif editor.selectedInt < 1 then
		editor.selectedInt = #Maprender.tiles
	end

	editor.selectedBlock = Maprender.tiles[editor.selectedInt].name
	print(selectedBlockNum)
end

function love.keypressed(key)
	-- change the window size
	if key == "1" then
		love.window.setMode(768, 456, {fullscreen = false})
	end

	if key == "2" then
		love.window.setMode(1024, 608, {fullscreen = false})
	end

	if key == "3" then
		love.window.setMode(1280, 760, {fullscreen = false})
	end

	if key == "4" then
		love.window.setMode(1536, 912, {fullscreen = false})
	end

	-- end game
	if key == "escape" then
		os.exit()
	end

	-- switch if the editor grid is shown
	if runMode == "Editor" then
		if key == "g" then
			editor.grid = not editor.grid
		end

		-- save the game
		if key == "p" then

			Mapload.writeMap("MapFile", map)
			print("File Saved!")
		end
	end
end

function love.update(dt)

	if runMode == "Menu" then
		Menu:update(dt)
	elseif runMode == "Editor" then
		if love.keyboard.isDown("w") then
			cameraY = cameraY - 5 - dt
		end

		if love.keyboard.isDown("s") then
			cameraY = cameraY + 5 + dt
		end

		if love.keyboard.isDown("a") then
			cameraX = cameraX - 5 - dt
		end

		if love.keyboard.isDown("d") then
			cameraX = cameraX + 5 + dt
		end

		if cameraX < 0 then cameraX = 0 end
		if cameraY < 0 then cameraY = 0 end

		mouseX = math.floor((love.mouse.getX()+cameraX)/32)
		mouseY = math.floor((love.mouse.getY()+cameraY)/32)

		if mouseY >= 1 and mouseX >= 1 then 
			if love.mouse.isDown(1) then
				map.tiles[mouseY][mouseX] = editor.selectedBlock
			elseif love.mouse.isDown(2) then
				map.tiles[mouseY][mouseX] = ""
			end
		end

	elseif runMode == "Game" then

		for i = 1, #map.entities do
			if map.entities[i]:instanceOf("LivingEntity") then
				map.entities[i]:update(dt)
			end

		end

		if love.mouse.isDown(1) and clickDeb == true then
			

			local kek = Monster:new()

			kek.location = {x = love.mouse.getX(), y = love.mouse.getY()}

			table.insert(map.entities, kek)
			clickDeb = false
		else
			clickDeb = true
		end
	end

	
end

function love.draw()
	if runMode == "Menu" then

		Menu:draw()
		love.graphics.push()
		love.graphics.scale(love.graphics.getWidth()/1024, love.graphics.getHeight()/608)
		Menu:drawScaledGraphics()
		love.graphics.pop()

	elseif runMode == "Editor" then
		love.graphics.push()
		love.graphics.scale(love.graphics.getWidth()/1024, love.graphics.getHeight()/608)

		love.graphics.setColor(105,186,185)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

		
		Maprender:draw()

		-- if we want to draw the grid
		if editor.grid == true then
			-- color
			love.graphics.setColor(200,200,200, 100)
			for x = 1, 256 do
				love.graphics.line(x*32-cameraX, 0-cameraY, x*32-cameraX, 256*32)
			end
			for y = 1, 256 do
				love.graphics.line(0-cameraX, y*32-cameraY, (128*32)-cameraX, y*32-cameraY)
			end
		end

		love.graphics.pop()
	elseif runMode == "Game" then

		love.graphics.push()
		love.graphics.scale(love.graphics.getWidth()/1024, love.graphics.getHeight()/608)

		love.graphics.setColor(135,206,235)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

		
		Maprender:draw()

		for i = 1, #map.entities do
			if map.entities[i]:instanceOf("LivingEntity") then
				map.entities[i]:draw()
			end
		end


		love.graphics.pop()
	end

	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(love.graphics.newFont(14))
	love.graphics.print("fps: "..love.timer.getFPS(), 10, 10)
end

-- I'm not afraid of dying, any time will do. I don't mind at all.
-- Why should I be afraid of dying?
-- There's no reason for it, you've gotta go some time.