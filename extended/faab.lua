--- Extended version of f3x-wrapper for the game 'FAAB - Free Admin And Building Tools' by LayeredMoney
-- @module f3x-wrapper-extended-faab
-- @author bqmb3
-- @license MIT
-- @copyright bqmb3 2024
-- @see f3x-wrapper

local plr = game:GetService('Players').LocalPlayer
function getF3XbyCommand()
   game:GetService('Players'):Chat('/e ;f3x')
   return plr.Backpack:WaitForChild('[Build] Building Tool', 2)
end
_G.F3X__init_func = function()
   if _G.F3X__init_debounce then return end
   local folder
   for i = 1, math.huge do
      if i > 1 then
         warn("Failed to get F3X. Attempt #"..tostring(i))
      end
      folder = plr.Backpack:FindFirstChild('[Build] Building Tool') or getF3XbyCommand()
      if folder then break end
   end
   _G.F3X__init_debounce = false
   return folder
end

local F3X = _G.F3X_wrapper_module or loadstring(game:HttpGet("https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/main.lua", true))()

--- Loads build from code of your exported creation.
-- @tparam string code 4 letter export code
function F3X:Import(code)
    game:GetService('Players'):Chat('/e ;import '..code)
end

--- Groups F3X Selection.
function F3X:GroupSelection()
    _G.F3X__EnsureInitialized(self)
    return self._core.GroupSelection:FireServer()
end

--- Ungroups F3X Selection.
function F3X:UngroupSelection()
    _G.F3X__EnsureInitialized(self)
    return self._core.UngroupSelection:FireServer()
end

return F3X