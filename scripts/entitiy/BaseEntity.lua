-------------------------------------------
-- The main inheritance for all entities --
-------------------------------------------


local BaseEntity = {
	_inheritance = {"BaseEntity"},
	location = {x = 0, y = 0},

}

function BaseEntity:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function BaseEntity:addInheritance(entityType)
	table.insert(self._inheritance, entityType)

function BaseEntity:instanceOf(entityType)
	for index, value in ipairs (self._inheritance) do
        if value == entityType then
            return true
        end
    end

    return false
end

return BaseEntity