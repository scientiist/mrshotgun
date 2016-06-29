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

function love.load()

end

function love.update(dt)
	player1:update(dt)
end

function love.draw()
	player1:draw()
end

-- I'm not afraid of dying, any time will do. I don't mind at all.
-- Why should I be afraid of dying?
-- There's no reason for it, you've gotta go some time.