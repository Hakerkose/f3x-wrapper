local F3X = loadstring(game:HttpGet("https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/loader.lua",true))()
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

local part = F3X:CreatePart('Normal', CFrame.new(char:WaitForChild("Head").Position + Vector3.new(0, 3, 0)))

function zigzag(X)
    return math.acos(math.cos(X * math.pi)) / math.pi
end

local counter = 5

game:GetService("RunService").RenderStepped:Connect(function()
    counter = counter + 0.01
    F3X:SetColor(part, Color3.fromHSV(zigzag(counter),1,1))
end)