if _G.F3X_wrapper_module then
    return _G.F3X_wrapper_module
end

local moduleUrl = "https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/main.lua"
local extended = {
    [333164326] = "https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/extended/admin-house.lua",
    [9381162676] = "https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/extended/faab.lua"
}

if extended[game.PlaceId] then
    moduleUrl = extended[game.PlaceId]
end

_G.F3X_wrapper_module = loadstring(game:HttpGet(moduleUrl, true))()

return _G.F3X_wrapper_module