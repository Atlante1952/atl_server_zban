function atl_server_zban.store_ban_info(player_name, ban_info)
    atl_server_zban.mod_storage:set_string(player_name, minetest.serialize(ban_info))
end

function atl_server_zban.clear_ban_info(player_name)
    atl_server_zban.mod_storage:set_string(player_name, "")
end

function atl_server_zban.get_ban_info(player_name)
    local ban_data = atl_server_zban.mod_storage:get_string(player_name)
    if ban_data == "" then
        return nil
    end
    return minetest.deserialize(ban_data)
end
