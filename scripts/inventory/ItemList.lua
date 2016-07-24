-------------------------------------
-- List of all items in Mr Shotgun --
-------------------------------------
local Item = require("scripts/inventory/Item")

-- Item types: Food, Weapons, Materials, Misc
-- Weapons = id 1-255
-- Food = id 256-511
-- Materials = id 512 - 768
-- Misc = 2048 - ?

local itemlist = {
	pistol      = Item:create("Pistol", 0x1, nil, "weapon"),
	shotgun     = Item:create("Shotgun", 0x2, nil, "weapon"),
	microSMG    = Item:create("Micro SMG", 0x3, nil, "weapon"),
	techN9ne    = Item:create("Tec 9", 0x4, nil, "weapon"),
	bigFG       = Item:create("BFG 9000", 0x5, nil, "weapon"),
	

	beer        = Item:create("Beer", 0x101, nil, "food"),
	energyPills = Item:create("Energy Pills", 0x102, nil, "food")
}