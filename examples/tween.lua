local F3X = loadstring(game:HttpGet("https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/loader.lua",true))()
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local head = char:WaitForChild("Head")

local tween = game:GetService("TweenService")

local starting = CFrame.new(head.Position + Vector3.new(0, 5, 0))
local ending = CFrame.new(starting - Vector3.new(0, 10, 0))

local part = F3X:CreatePart('Normal', starting)

for alpha = 0, 1, .01 do
    local tweenedAlpha = tween:GetValue(alpha, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
    coroutine.wrap(function()
        F3X:Move(part, starting:Lerp(ending, tweenedAlpha))
    end)()
    task.wait()
end