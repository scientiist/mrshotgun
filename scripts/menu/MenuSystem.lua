local MenuSystem = {}

-- fonts
MenuSystem.fonts = {
	zombifiedHeader = love.graphics.newFont("assets/fonts/zombified.ttf", 80),
	button = love.graphics.newFont("assets/fonts/pixel.ttf", 35),
}
local MenuObject = require("scripts/menu/MenuObject")
local ButtonObject = require("scripts/menu/ButtonObject")


-----------------
-- List of all menus within game
MenuSystem.menus = {
	main = {
		objects = {
			ButtonObject:new({text = "Play", y = 256}),
			ButtonObject:new({text = "Map Editor", y = 256+64}),
			ButtonObject:new({text = "Options", y = 384}),
			ButtonObject:new({text = "Quit Game", y = 384+64}),
		},

		render = function()
			love.graphics.setColor(255,255,255)
			love.graphics.setFont(MenuSystem.fonts.zombifiedHeader)
			love.graphics.printf("Mr Shotgun", 0, 32, love.graphics.getWidth(), "center")
		end,
	},

}

local menus = MenuSystem.menus

MenuSystem.current = MenuSystem.menus.main

function MenuSystem.update(dt)
	--MenuSystem.current:update(dt)
end

function MenuSystem.draw()
	love.graphics.setColor(30, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

	if MenuSystem.current.render then
		MenuSystem.current:render()
	end

	
end

function MenuSystem:drawScaledGraphics()
	love.graphics.setFont(MenuSystem.fonts.button)
	for i = 1, #MenuSystem.current.objects do
		MenuSystem.current.objects[i]:draw()
	end
end



return MenuSystem