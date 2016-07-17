local Utils = {}

function Utils.indexOf( t, object )
    if "table" == type( t ) then
        for i = 1, #t do
            if object == t[i] then
                return i
            end
        end
        return -1
    else
        error("table.indexOf expects table for first argument, " .. type(t) .. " given")
    end
end

function Utils.tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

return Utils