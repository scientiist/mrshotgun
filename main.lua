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

local Player = require("scripts/entity/Player")


local player1 = Player:new()

local meta = {
	version = "0.2.0",
}

map = {
	{1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0},
	{1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0},
	{1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0},
	{1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0},
	{1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0},
}

function love.load()

	love.window.setMode(1024, 608, {resizable = true, minwidth = 512, minheight = 304})
	love.window.setTitle("Mr Shotgun by Joshua O'Leary. v"..meta.version)
end

function love.update(dt)
	player1:update(dt)

	
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(love.graphics.getWidth()/1024, love.graphics.getHeight()/608)

	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

	player1:draw()


	for y = 1, #map do
		for x = 1, #map[y] do
			if map[y][x] == 1 then
				love.graphics.setColor(100, 100, 100)
				love.graphics.rectangle("fill", x*64, y*64, 64, 64)
			end
		end
	end

	love.graphics.pop()
end

-- I'm not afraid of dying, any time will do. I don't mind at all.
-- Why should I be afraid of dying?
-- There's no reason for it, you've gotta go some time.