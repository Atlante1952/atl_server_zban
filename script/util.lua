function atl_server_zban.get_player_name(player)
    return type(player) == "userdata" and player:get_player_name() or player
end

function atl_server_zban.is_ban_expired(ban_info)
    return ban_info.unban_time and os.time() >= ban_info.unban_time
end

function atl_server_zban.unban_player(player_name)
    atl_server_zban.clear_ban_info(player_name)
end
