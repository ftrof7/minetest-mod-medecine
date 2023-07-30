local S = minetest.get_translator("medecine")

minetest.register_craftitem("medecine:bag", {
    description = S("Medecine bag"),
    inventory_image = "medecine_bag.png",
    on_use = function(itemstack, player)
        local inv = player:get_inventory()
        if minetest.settings:get_bool("enable_damage") then
            if player:get_hp() < player:get_properties().hp_max then
                player:set_hp(player:get_hp() + 10)
                inv:remove_item("main", "medecine:bag")
            else
                local name = player:get_player_name()
                minetest.chat_send_player(name, S("-!- You have full healts and cannot use medecine."))
            end
        end
    end
})

minetest.register_craftitem("medecine:syringe_empty", {
    description = S("Syringe empty"),
    inventory_image = "medecine_syringe_empty.png",
    on_use = function(itemstack, player)
        local inv = player:get_inventory()
        if minetest.settings:get_bool("enable_damage") then
            if player:get_hp() > 2 then
                player:set_hp(player:get_hp() - 2)
                inv:remove_item("main", "medecine:syringe_empty")
                inv:add_item("main", "medecine:syringe_blood")
            end
        end
    end
})

minetest.register_craftitem("medecine:syringe_blood", {
    description = S("Syringe with blood"),
    inventory_image = "medecine_syringe_blood.png"
})

minetest.register_craftitem("medecine:syringe_full", {
    description = S("Syringe full"),
    inventory_image = "medecine_syringe_full.png",
    on_use = function(itemstack, player)
        local inv = player:get_inventory()
        if minetest.settings:get_bool("enable_damage") then
            if player:get_hp() < player:get_properties().hp_max then
                player:set_hp(player:get_hp() + 5)
                inv:remove_item("main", "medecine:syringe_full")
                inv:add_item("main", "medecine:syringe_empty")
            else
                local name = player:get_player_name()
                minetest.chat_send_player(name, S("-!- You have full healts and cannot use medecine."))
            end
        end
    end
})


minetest.register_craft({
	output = "medecine:syringe_empty",
	recipe = {
		{"vessels:glass_bottle"},
        {"vessels:glass_fragments"},
	}
})

minetest.register_craft({
	output = "medecine:syringe_full",
	recipe = {
		{"medecine:syringe_empty", "dye:green"},
        {"default:sapling", ""},
	}
})

minetest.register_craft({
	output = "medecine:bag",
	recipe = {
		{"wool:dark_green", "medecine:syringe_blood"},
        {"wool:dark_green", "default:grass_1"},
	}
})


