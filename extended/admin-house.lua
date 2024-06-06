local initDebounce = false
_G.F3X__init_func = function()
   if initDebounce then return end
   initDebounce = true
   game.Players:Chat('/e :f3x')
   game:GetService('Players').LocalPlayer.Backpack:WaitForChild('Folder', 1)
   initDebounce = false
end

local F3X = loadstring(game:HttpGet("https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/main.lua",true))()

function F3X:LoadBuild(buildName: string): {Instance}
   local result = game:GetService('ReplicatedStorage').Network.BuildSaving:InvokeServer({'LOAD', buildName})
   assert(result, 'Build not found.')
   return result.Objects
end

function F3X:SetLockMode(mode: number): nil
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", mode})
end

function F3X:SetLockModeToEveryone(): nil
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 0})
end

function F3X:SetLockModeToFriends(): nil
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 1})
end

function F3X:SetLockModeToCustom(): nil
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 2})
end

function F3X:SetLockModeToOnlyMe(): nil
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"CHANGELOCKMODE", 3})
end

function F3X:GetWhitelistedPlayers(): {[string]: number}
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"GETWHITELIST"})
end

function F3X:AddToWhitelist(userId: number)
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"ADDWHITELIST", userId})
end

function F3X:RemoveFromWhitelist(userId: number)
   return game:GetService('ReplicatedStorage').Network.BuildLocking:InvokeServer({"REMOVEWHITELIST", userId})
end

return F3X