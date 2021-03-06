-- ores/init.lua

ores = {}

---
--- API
---

-- [local function] Register oredef
local function register_oredef(ore, def)
	local ores = def.ore

	local function register(_)
		local oredef = ores[_]
		oredef.ore = ore
		oredef.ore_type = oredef.ore_type or def.ore_type
		oredef.wherein = oredef.wherein or def.ore_wherein
		-- Register ore definition
		minetest.register_ore(oredef)
	end

	for _, i in ipairs(ores) do
		register(_)
	end
end

-- [function] Register ore
function ores.register(name, def)
	-- Check and register ore definition
	if def.ore then
		register_oredef("ores:"..name, def)
	end

	local drop = "ores:"..name
	if def.lump then
		drop = "ores:"..name.."_lump"

		if def.drop_wherein ~= false then
			drop = {
				max_items = 1,
				items = {
					{
						items = {drop, def.ore_wherein},
						rarity = 2,
					},
					{
						items = {drop},
						rarity = 1,
					},
				}
			}
		end
	end

	-- Ore node
	minetest.register_node("ores:"..name, {
		description = def.basename.." Ore",
		tiles = {"eden_stone.png^"..def.texture},
		groups = def.groups,
		drop = drop,
	})

	-- Ore Lump
	if def.lump then
		minetest.register_craftitem("ores:"..name.."_lump", {
			description = def.lump_description or def.basename.." Lump",
			inventory_image = def.lump,
		})
	end

	-- Ingot
	if def.ingot then
		minetest.register_craftitem("ores:"..name.."_ingot", {
			description = def.ingot_description or def.basename.." Ingot",
			inventory_image = def.ingot,
		})
	end
end

---
--- Registrations
---

-- [ore] Coal
ores.register("coal", {
	basename = "Coal",
	texture = "ores_coal_ore.png",
	lump = "ores_coal_lump.png",
	groups = {cracky = 3},
	ore_type = "scatter",
	ore_wherein = "eden:stone",
	ore = {
		{
			clust_scarcity = 8 * 8 * 8,
			clust_num_ores = 8,
			clust_size     = 3,
			y_min          = -31000,
			y_max          = 64,
		},
		{
			clust_scarcity = 24 * 24 * 24,
			clust_num_ores = 27,
			clust_size     = 6,
			y_min          = -31000,
			y_max          = 0,
		},
	},
})

-- [ore] Iron
ores.register("iron", {
	basename = "Iron",
	texture = "ores_iron_ore.png",
	ingot = "ores_iron_ingot.png",
	groups = {cracky = 2},
	ore_type = "scatter",
	ore_wherein = "eden:stone",
	ore = {
		{
			clust_scarcity = 7 * 7 * 7,
			clust_num_ores = 5,
			clust_size     = 3,
			y_min          = -31000,
			y_max          = 0,
		},
		{
			clust_scarcity = 24 * 24 * 24,
			clust_num_ores = 27,
			clust_size     = 6,
			y_min          = -31000,
			y_max          = -64,
		},
	},
})

-- [ore] Gold
ores.register("gold", {
	basename = "Gold",
	texture = "ores_gold_ore.png",
	ingot = "ores_gold_ingot.png",
	groups = {cracky = 2},
	ore_type = "scatter",
	ore_wherein = "eden:stone",
	ore = {
		{
			clust_scarcity = 15 * 15 * 15,
			clust_num_ores = 3,
			clust_size     = 2,
			y_min          = -255,
			y_max          = -64,
		},
		{
			clust_scarcity = 13 * 13 * 13,
			clust_num_ores = 5,
			clust_size     = 3,
			y_min          = -31000,
			y_max          = -256,
		},
	},
})

-- [ore] Diamond
ores.register("diamond", {
	basename = "Diamond",
	texture = "ores_diamond_ore.png",
	lump = "ores_diamond_lump.png",
	lump_description = "Diamond",
	groups = {cracky = 1, level = 3},
	ore_type = "scatter",
	ore_wherein = "eden:stone",
	ore = {
		{
			clust_scarcity = 17 * 17 * 17,
			clust_num_ores = 4,
			clust_size     = 3,
			y_min          = -255,
			y_max          = -128,
		},
		{
			clust_scarcity = 15 * 15 * 15,
			clust_num_ores = 4,
			clust_size     = 3,
			y_min          = -31000,
			y_max          = -256,
		},
	},
})
