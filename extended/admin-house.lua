_G.F3X__init_func = function()
   if _G.F3X__init_debounce then return end
   _G.F3X__init_debounce = true
   game.Players:Chat('/e :f3x')
   game:GetService('Players').LocalPlayer.Backpack:WaitForChild('Folder', 1)
   _G.F3X__init_debounce = false
end

local F3X = loadstring(game:HttpGet("https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/main.lua", true))()

--- Gets the list of builds.
-- @return table List of build names
function F3X:GetBuilds()
   local tbl = game:GetService('ReplicatedStorage').Network.BuildSaving:InvokeServer({'GET'})
   local builds = {}
   for k, _ in pairs(tbl) do
      table.insert(builds, k)
   end
   return builds
end

--- Checks if a build exists.
-- @param buildName string Name of the build
-- @return boolean True if the build exists, false otherwise
function F3X:HasBuild(buildName)
   return game:GetService('ReplicatedStorage').Network.BuildSaving:InvokeServer({'GET'})[buildName] ~= nil
end

--- Loads a build.
-- @param buildName string Name of the build
-- @return table List of instances in the build
function F3X:LoadBuild(buildName)
   local result = game:GetService('ReplicatedStorage').Network.BuildSaving:InvokeServer({'LOAD', buildName})
   assert(result, 'Build not found.')
   return result.Objects
end

--- Sets the lock mode.
-- @param mode number Lock mode
function F3X:SetLockMode(mode)
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", mode})
end

--- Sets the lock mode to everyone.
function F3X:SetLockModeToEveryone()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 0})
end

--- Sets the lock mode to friends.
function F3X:SetLockModeToFriends()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 1})
end

--- Sets the lock mode to custom.
function F3X:SetLockModeToCustom()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 2})
end

--- Sets the lock mode to only me.
function F3X:SetLockModeToOnlyMe()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 3})
end

--- Gets the list of whitelisted players.
-- @return table List of whitelisted players
function F3X:GetWhitelistedPlayers()
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"GETWHITELIST"})
end

--- Adds a player to the whitelist.
-- @param userId number User ID of the player
function F3X:AddToWhitelist(userId)
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"ADDWHITELIST", userId})
end

--- Removes a player from the whitelist.
-- @param userId number User ID of the player
function F3X:RemoveFromWhitelist(userId)
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"REMOVEWHITELIST", userId})
end

return F3X