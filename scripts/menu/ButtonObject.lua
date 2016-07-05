----------------------------------------------
-- Button object for Mr Shotgun menu system --
----------------------------------------------

local BaseEntity = require("scripts/entity/BaseEntity")

local ButtonObject = BaseEntity:new()

ButtonObject:addInheritance("ButtonObject")

ButtonObject.text = "Button"
ButtonObject.tooltip = nil
ButtonObject.width = 128
ButtonObject.height = 32
ButtonObject.clicked = false
ButtonObject.mouseOver = false

function ButtonObject:clicked(mouseButton) -- note: 1 = left, 2 = right

end

function ButtonObject:draw()

end