--
-- Embedded lights for all default stone block types
--
		
local block_lights = {
	{"stone_block", "Stone Block"},
	{"desert_stone_block", "Desert Stone Block"},
	{"sandstone_block", "Sandstone Block"},
	{"silver_sandstone_block", "Silver Sandstone Block"},
	{"desert_sandstone_block", "Desert Sandstone Block"},
	{"obsidian_block", "Obsidian Block"},
}

for _,b in ipairs(block_lights) do

	minetest.register_node("morelights_extras:" .. b[1], {
		description = b[2] .. " Light",
		tiles = {"default_" .. b[1] .. ".png^morelights_extras_blocklight.png"},
		paramtype = "light",
		light_source = 12,
		groups = {cracky = 2, oddly_breakable_by_hand = 3},
		sounds = default.node_sound_glass_defaults()
	})
	
	minetest.register_craft({
		output = "morelights_extras:" .. b[1],
		recipe = {
			{"", morelights.glass, ""},
			{"", "morelights:bulb", ""},
			{"", "default:" .. b[1], ""}
		}
	})

end

--
-- Embedded lights for some grass types
--

local grass_lights = {
	{"dirt_with_grass", "Grass", {"default_grass.png", "default_grass_side.png"}, "default:grass_1"},
	{"dirt_with_dry_grass", "Dry Grass", {"default_dry_grass.png", "default_dry_grass_side.png"}, "default:dry_grass_1"}
}

if minetest.get_modpath("ethereal") then
	table.insert(grass_lights, 
		{"grove_dirt", "Grove", {"ethereal_grass_grove_top.png", "ethereal_grass_grove_side.png"}, "ethereal:fern"})
	table.insert(grass_lights, 
		{"gray_dirt", "Gray", {"ethereal_grass_gray_top.png", "ethereal_grass_gray_side.png"}, "ethereal:snowygrass"})
end

for _,b in ipairs(grass_lights) do

	minetest.register_node("morelights_extras:" .. b[1], {
		description = b[2] .. " Light",
		tiles = {b[3][1] .. "^morelights_extras_blocklight.png",
		"default_dirt.png", "default_dirt.png^" .. b[3][2]},
		paramtype = "light",
		light_source = 12,
		groups = {cracky = 2, oddly_breakable_by_hand = 3},
		sounds = default.node_sound_glass_defaults()
	})

	minetest.register_craft({
		output = "morelights_extras:" .. b[1],
		recipe = {
			{"", morelights.glass, ""},
			{"", "morelights:bulb", ""},
			{b[4], "default:dirt", ""}
		}
	})

end

--
-- Standalone objects
--

minetest.register_node("morelights_extras:f_block", {
  description = "Futuristic Light Block",
  tiles = {"morelights_extras_f_block.png"},
  paramtype = "light",
  light_source = LIGHT_MAX,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("morelights_extras:stairlight", {
  description = "Stair Light (place on stairs)",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-1/4, -13/16, -1/16, 1/4, -11/16, 0}
  },
  selection_box = {
    type = "fixed",
    fixed = {-1/4, -13/16, -1/16, 1/4, -11/16, 0}
  },
  walkable = false,
  tiles = {"morelights_metal_dark.png"},
  overlay_tiles = {"", "morelights_extras_stairlight.png",
    "", "", "morelights_extras_stairlight.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 10,
  groups = {cracky = 2, oddly_breakable_by_hand = 3, attached_node = 1},
  node_placement_prediction = "",
  sounds = default.node_sound_glass_defaults(),

  on_place = function(itemstack, placer, pointed_thing)
    local node = minetest.get_node(vector.subtract(pointed_thing.above,
      {x=0, y=1, z=0}))

    if node and (node.name:match("^stairs:stair") or node.name:match("^moreblocks:stair_"))
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end

    return itemstack
  end,

  on_rotate = function(pos, node, user, mode, new_param2)
    return false
  end,
})

--
-- Craft recipes
--

minetest.register_craft({
  output = "morelights_extras:f_block",
  recipe = {
    {"default:mese_crystal_fragment", "default:steel_ingot", "default:mese_crystal_fragment"},
    {morelights.glass, "morelights:bulb", morelights.glass},
    {"default:mese_crystal_fragment", "default:steel_ingot", "default:mese_crystal_fragment"}
  }
})

minetest.register_craft({
  output = "morelights_extras:stairlight",
  recipe = {
    {"default:steel_ingot", "morelights:bulb", "default:steel_ingot"}
  }
})
