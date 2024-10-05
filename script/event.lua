minetest.register_on_prejoinplayer(function(name, ip)
    local is_banned, ban_info = atl_server_zban.is_player_banned(name)
    if is_banned then
        return atl_server_zban.get_ban_message(ban_info)
    end
end)