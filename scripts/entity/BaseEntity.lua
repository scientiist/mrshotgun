-------------------------------------------
-- The main inheritance for all entities --
-------------------------------------------

local obj = {}

function obj:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- Create the basic table
local BaseEntity = obj:new()

	-- allows for stuff
BaseEntity._inheritance = {"BaseEntity"}
	-- simple location
BaseEntity.location = {x = 0, y = 0,}

-- create a new OOP Entity


-- Adds entityType to the Entity's inheritance list
function BaseEntity:addInheritance(entityType)
	table.insert(self._inheritance, entityType)
end

-- check if entityType is in Entity's inheritance list
function BaseEntity:instanceOf(entityType)
	for index, value in ipairs (self._inheritance) do
        if value == entityType then
            return true
        end
    end

    return false
end

function BaseEntity:update(dt)

end

-- return the thingy
return BaseEntity