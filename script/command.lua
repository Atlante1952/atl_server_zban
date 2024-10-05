minetest.register_chatcommand("atban_acc", {
    params = "<playername> [duration in minutes] [reason]",
    description = "Ban a player account with optional duration (in minutes) and reason",
    privs = {ban = true},
    func = function(name, param)
        local playername, duration, reason = param:match("(%S+)%s*(%d*)%s*(.*)")
        if not playername then
            return false, "Please provide a player name."
        end

        local ban_duration = tonumber(duration)
        reason = reason ~= "" and reason or nil

        atl_server_zban.execute_ban(playername, ban_duration, reason)

        local message = ban_duration and (playername .. " has been banned for " .. ban_duration .. " minutes. Reason: " .. (reason or "No reason provided")) or (playername .. " has been permanently banned. Reason: " .. (reason or "No reason provided"))
        return true, message
    end,
})

minetest.register_chatcommand("atunban", {
    params = "<playername>",
    description = "Unban a player account",
    privs = {ban = true},
    func = function(name, param)
        local playername = param:match("(%S+)")
        if not playername then
            return false, "Please provide a player name."
        end

        atl_server_zban.execute_unban(playername)

        return true, playername .. " has been unbanned."
    end,
})