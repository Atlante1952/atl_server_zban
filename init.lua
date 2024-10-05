atl_server_zban = {
    mod_storage = minetest.get_mod_storage(),
    modpath = minetest.get_modpath("atl_server_zban"),
}

function atl_server_zban.load_file(path)
    local success, err = pcall(dofile, path)
    if not success then
        minetest.log("error", string.format("-!- Failed to load file: %s - Error: %s", path, err))
    else
        minetest.log("action", string.format("-!- Successfully loaded file: %s", path))
    end
end

function atl_server_zban.init()
    if atl_server_zban.modpath then
        local files_to_load = {
            "script/storage.lua",
            "script/event.lua",
            "script/command.lua",
            "script/util.lua",
            "script/formspec.lua",
            "script/api.lua",
        }
        for _, file in ipairs(files_to_load) do
            atl_server_zban.load_file(atl_server_zban.modpath .. "/" .. file)
        end
    else
        minetest.log("error", "-!- atl_server_zban.modpath is not set or invalid.")
    end
end

