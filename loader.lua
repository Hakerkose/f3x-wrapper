if _G.F3X_wrapper_module then
    return _G.F3X_wrapper_module
end

local moduleUrl = "https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/main.lua"

if game.PlaceId == 333164326 then
    moduleUrl = "https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/extended/admin-house.lua"
end

_G.F3X_wrapper_module = loadstring(game:HttpGet(moduleUrl, true))()

return _G.F3X_wrapper_module