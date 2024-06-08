--!strict
local F3X = {}
F3X.__index = F3X

local plr = game:GetService("Players").LocalPlayer

local errors = {
    endpointNotFound = "Cannot find F3X endpoint.",
    coreNotFound = "Cannot find F3X core.",
    notIntialized = "Not Initialized",
}

local initFunc = _G.F3X__init_func or function()
    game.Players:Chat(':f3x')
end

--- Creates a new instance of the F3X module and initializes it.
-- @param init function Initialization function
-- @return table New F3X instance
function F3X.new(init)
    if type(init) == "function" then
        init = initFunc
    end

    local self
    self = setmetatable({
        _reinit = function()
            init()
            local Folder = plr.Backpack:WaitForChild('Folder', 1)
            local Core = Folder and Folder:WaitForChild('Core', 1)
            local SyncAPI = Folder and Folder:WaitForChild('SyncAPI', 1)
            local ServerEndpoint = SyncAPI and SyncAPI:WaitForChild('ServerEndpoint', 1)
            assert(Core, errors.coreNotFound)
            assert(ServerEndpoint, errors.endpointNotFound)
            self._core = Core
            self._endpoint = ServerEndpoint
        end,
        _core = nil,
        _endpoint = nil,
    })
    self._reinit()

    return self
end

--- Recolors the handle of a part.
-- @param NewColor BrickColor New color for the handle
function F3X:RecolorHandle(NewColor)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("RecolorHandle", NewColor)
end

--- Clones multiple parts and sets their parent.
-- @param Items table Parts to clone
-- @param Parent Instance Parent instance
-- @return table Cloned parts
function F3X:CloneParts(Items, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Clone", Items, Parent)
end

--- Clones a single part and sets its parent.
-- @param Item Instance Part to clone
-- @param Parent Instance? Parent instance
-- @return Instance Cloned part
function F3X:Clone(Item, Parent)
    return self:CloneParts({Item}, Parent or Item.Parent)[1]
end

--- Creates a new part of the specified type at the given position.
-- @param PartType string Type of the part
-- @param Position CFrame Position of the part
-- @param Parent Instance Parent instance
-- @return BasePart Created part
function F3X:CreatePart(PartType, Position, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreatePart", PartType, Position, Parent)
end

--- Creates a group (Model or Folder) containing the specified items.
-- @param Type string Type of the group
-- @param Parent Instance Parent instance
-- @param Items table Items to group
-- @return Model|Folder Created group
function F3X:CreateGroup(Type, Parent, Items)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateGroup", Type, Parent, Items)
end

--- Ungroups the specified groups.
-- @param Groups table Groups to ungroup
-- @return table Ungrouped items
function F3X:Ungroup(Groups)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Ungroup", Groups)
end

--- Sets the parent of the specified items.
-- @param Items table Items to reparent
-- @param Parent Instance New parent instance
function F3X:SetParent(Items, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetParent", Items, Parent)
end

--- Sets the name of the specified items.
-- @param Items table Items to rename
-- @param Name string New name
function F3X:SetNames(Items, Name)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetName", Items, Name)
end

--- Sets the name of a single item.
-- @param Item Instance Item to rename
-- @param Name string New name
function F3X:SetName(Item, Name)
    return self:SetNames({Item}, Name)
end

--- Removes the specified parts.
-- @param Objects table Parts to remove
function F3X:RemoveParts(Objects)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Remove", Objects)
end

--- Removes a single part.
-- @param Object Instance Part to remove
function F3X:Remove(Object)
    return self:RemoveParts({Object})
end

--- Undoes the removal of the specified parts.
-- @param Objects table Parts to restore
function F3X:UndoRemovedParts(Objects)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("UndoRemove", Objects)
end

--- Undoes the removal of a single part.
-- @param Object Instance Part to restore
function F3X:UndoRemove(Object)
    return self:UndoRemovedParts({Object})
end

--- Moves the specified parts to the given CFrame.
-- @param Changes table Parts and their new CFrames
function F3X:MoveParts(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncMove", Changes)
end

--- Moves a single part to the given CFrame.
-- @param Part BasePart Part to move
-- @param CFrame CFrame New CFrame
function F3X:Move(Part, CFrame)
    return self:MoveParts({{["Part"] = Part, ["CFrame"] = CFrame}})
end

--- Moves a part