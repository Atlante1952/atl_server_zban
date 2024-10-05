
function atl_server_zban.ban_player(player_name, duration, reason)
    local ban_info = {
        banned = true,
        unban_time = duration and (os.time() + duration * 60) or nil,
        reason = reason or "No reason provided"
    }
    atl_server_zban.store_ban_info(player_name, ban_info)
end

function atl_server_zban.is_player_banned(player_name)
    local ban_info = atl_server_zban.get_ban_info(player_name)
    if not ban_info then
        return false, nil
    end
    if atl_server_zban.is_ban_expired(ban_info) then
        atl_server_zban.unban_player(player_name)
        return false, nil
    end
    return ban_info.banned, ban_info
end

function atl_server_zban.get_ban_message(ban_info)
    local message = "You are banned from this server. Reason: " .. ban_info.reason
    if ban_info.unban_time then
        local remaining_time = ban_info.unban_time - os.time()
        local minutes = math.floor(remaining_time / 60)
        local seconds = remaining_time % 60
        message = message .. string.format(". You will be unbanned in %d minutes and %d seconds.", minutes, seconds)
    else
        message = message .. ". This ban is permanent."
    end
    return message
end

function atl_server_zban.execute_ban(playername, duration, reason)
    atl_server_zban.ban_player(playername, duration, reason)
    local player = minetest.get_player_by_name(playername)
    if player then
        minetest.kick_player(playername, "You have been banned: " .. (reason or "No reason provided"))
    end
end

atl_server_zban.init()