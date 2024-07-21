local F3X = loadstring(game:HttpGet("https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/loader.lua",true))()
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

local cf = CFrame.new(char:WaitForChild("Head").Position + Vector3.new(0, 5, 0))
local part = F3X:CreatePart('Normal', cf)

F3X:Resize(part, Vector3.new(15, 1, 2))

game:GetService("RunService").RenderStepped:Connect(function()
    cf = cf * CFrame.Angles(0, 0.5, 0)
    F3X:Rotate(part, cf)
end)