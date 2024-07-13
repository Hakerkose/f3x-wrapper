--- Extended version of f3x-wrapper for the game 'Admin House!' by Kaderth
-- @module f3x-wrapper-extended-admin-house
-- @author bqmb3
-- @license MIT
-- @copyright bqmb3 2024
-- @see f3x-wrapper


_G.F3X__init_func = function()
   if not _G.F3X__init_debounce then
      _G.F3X__init_debounce = true
      game.Players:Chat('/e :f3x')
   end
   local folder = game:GetService('Players').LocalPlayer.Backpack:WaitForChild('Folder')
   _G.F3X__init_debounce = false
   return folder
end

local F3X = _G.F3X_wrapper_module or loadstring(game:HttpGet("https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/main.lua", true))()

--- Gets the list of builds.
-- @treturn table List of build names
function F3X:GetBuilds()
   local tbl = game:GetService('ReplicatedStorage').Network.BuildSaving:InvokeServer({'GET'})
   local builds = {}
   for k, _ in pairs(tbl) do
      table.insert(builds, k)
   end
   return builds
end

--- Checks if a build exists.
-- @tparam string buildName Name of the build
-- @treturn boolean True if the build exists, false otherwise
function F3X:HasBuild(buildName)
   return game:GetService('ReplicatedStorage').Network.BuildSaving:InvokeServer({'GET'})[buildName] ~= nil
end

--- Loads a build.
-- @tparam string buildName Name of the build
-- @treturn table List of instances in the build
function F3X:LoadBuild(buildName)
   local result = game:GetService('ReplicatedStorage').Network.BuildSaving:InvokeServer({'LOAD', buildName})
   assert(result, 'Build not found.')
   return result.Objects
end

--- Sets the lock mode.
-- @tparam number mode Lock mode
function F3X:SetLockMode(mode)
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", mode})
end

--- Sets the lock mode to everyone.
-- @treturn nil
function F3X:SetLockModeToEveryone()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 0})
end

--- Sets the lock mode to friends.
-- @treturn nil
function F3X:SetLockModeToFriends()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 1})
end

--- Sets the lock mode to custom.
-- @treturn nil
function F3X:SetLockModeToCustom()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 2})
end

--- Sets the lock mode to only me.
-- @treturn nil
function F3X:SetLockModeToOnlyMe()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 3})
end

--- Gets the list of whitelisted players.
-- @treturn table List of whitelisted players
function F3X:GetWhitelistedPlayers()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"GETWHITELIST"})
end

--- Adds a player to the whitelist.
-- @tparam number userId User ID of the player
-- @treturn nil
function F3X:AddToWhitelist(userId)
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"ADDWHITELIST", userId})
end

--- Removes a player from the whitelist.
-- @tparam number userId User ID of the player
-- @treturn nil
function F3X:RemoveFromWhitelist(userId)
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"REMOVEWHITELIST", userId})
end

_G.F3X_wrapper_module = F3X

return F3X