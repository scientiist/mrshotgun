--------------------------------------------------------------
-- Game Menu System - handles splash screens, options, etc. --
--------------------------------------------------------------

-- holder table
local BaseEntity = require("scripts/entity/BaseEntity")
local MenuSystem = BaseEntity:new()

MenuSystem:setInheritance({"MenuSystem"})

-- imports
local MenuObject = require("scripts/menu/MenuObject")
local ButtonObject = require("scripts/menu/ButtonObject")

-- fonts
MenuSystem.fonts = {
	zombifiedHeader = love.graphics.newFont("assets/fonts/zombified.ttf", 80),
	button = love.graphics.newFont("assets/fonts/pixel.ttf", 35),
	text = love.graphics.newFont("assets/fonts/pixel.ttf", 24),
}

-- local function to set the menu via string
local function setMenu(menu)
	MenuSystem.current = MenuSystem.menus[menu]
end

-- list of all menus within game
MenuSystem.menus = {
	-- options menu
	options = MenuObject:new({
		objects = {
			ButtonObject:new({clicked = function() end, text = "Debug Info: ", y = 256+64}),
			ButtonObject:new({clicked = function() setMenu("main") end, text = "Back to Main", y = 384}),
		},
		-- function render is how the screen will display
		draw = function()
			love.graphics.setColor(255,255,255)
			love.graphics.setFont(MenuSystem.fonts.zombifiedHeader)
			love.graphics.printf("Options", 0, 32, love.graphics.getWidth(), "center")
		end,
	}),
	-- main menu
	main = MenuObject:new({
		objects = {
			ButtonObject:new({clicked = function() startGame() end, text = "Play", y = 256}),
			ButtonObject:new({clicked = function() startEditor() end, text = "Map Editor", y = 256+64}),
			ButtonObject:new({clicked = function() setMenu("options") end, text= "Options", y = 384}),
			ButtonObject:new({clicked = function() os.exit() end,text = "Quit Game", y = 384+64}),
		},

		draw = function()
			love.graphics.setColor(255,255,255)
			love.graphics.setFont(MenuSystem.fonts.zombifiedHeader)
			love.graphics.printf("Mr Shotgun", 0, 32, love.graphics.getWidth(), "center")

			love.graphics.setFont(MenuSystem.fonts.text)
			love.graphics.printf("Copyright 2016 Joshua O'Leary  ", 0, love.graphics.getHeight()-20, love.graphics.getWidth(), "right")
		end,
	}),

}
-- set the current menu to main
setMenu("main")

-- update the menu system
function MenuSystem.update(dt)

	-- loop through all objects in the menu
	-- and update them
	MenuSystem.current:update()
end

-- render the menu system
function MenuSystem.draw()
	love.graphics.setColor(30, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

	if MenuSystem.current.draw then
		MenuSystem.current:draw()
	end

end

function MenuSystem:drawScaledGraphics()
	love.graphics.setFont(MenuSystem.fonts.button)
	for i = 1, #MenuSystem.current.objects do
		MenuSystem.current.objects[i]:draw()
	end
end

-- return the menu system thingy
return MenuSystem