local F3X = loadstring(game:HttpGet("https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/loader.lua",true))()
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local head = char:WaitForChild("Head")

local ascPos = head.Position + Vector3.new(0, 5, 5)
local descPos = head.Position + Vector3.new(0, 5, 8)
local shrinkingPart = F3X:CreatePart('Normal', CFrame.new(head.Position + Vector3.new(0, 5, 0)))
local expandingPart = F3X:CreatePart('Normal', CFrame.new(head.Position + Vector3.new(0, 7, 0)))
local ascendingPart = F3X:CreatePart('Normal', CFrame.new(ascPos))
local descendingPart = F3X:CreatePart('Normal', CFrame.new(descPos))

F3X:SetColors({
    {["Part"] = shrinkingPart, ["Color"] = Color3.new(1, 0, 0)},
    {["Part"] = expandingPart, ["Color"] = Color3.new(0, 0, 1)},
    {["Part"] = ascendingPart, ["Color"] = Color3.new(1, 1, 0)},
    {["Part"] = descendingPart, ["Color"] = Color3.new(0, 1, 1)}
})

F3X:SetNames({shrinkingPart, expandingPart, ascendingPart, descendingPart}, {'Shrink', 'Expand', 'Ascend', 'Descend'})

for i = 1, 100 do
    coroutine.wrap(function()
        -- You can also move parts using F3X:ResizeParts().
        F3X:ResizeParts({
            -- Changing size without changing CFrame
            {["Part"] = shrinkingPart, ["Size"] = Vector3.new(4, 1 - i/100, 2), ["CFrame"] = shrinkingPart.CFrame},
            {["Part"] = expandingPart, ["Size"] = Vector3.new(4, i/100, 2), ["CFrame"] = shrinkingPart.CFrame},

            -- Changing CFrame without changing size
            {["Part"] = ascendingPart, ["Size"] = ascendingPart.Size, ["CFrame"] = CFrame.new(ascPos + Vector3.new(0, i/10, 0))},
            {["Part"] = descendingPart, ["Size"] = descendingPart.Size, ["CFrame"] = CFrame.new(ascPos - Vector3.new(0, i/10, 0))}
        })
    end)()
    task.wait()
end