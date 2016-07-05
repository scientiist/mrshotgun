---------------------------------------------------
-- Vector2 thingy, represents 2d points in space --
---------------------------------------------------

local Vector2 = {x=0, y=0}

function Vector2.new(x, y)
	return {x=x, y=y}
end

return Vector2