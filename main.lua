--- f3x-wrapper: An Unofficial F3X Sync API Wrapper
-- @module f3x-wrapper
-- @author bqmb3
-- @license MIT
-- @copyright bqmb3 2024

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
-- @tparam init function Initialization function
-- @treturn table New F3X instance
function F3X.new(init)
    init = init or initFunc
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
    }, F3X)
    self._reinit()

    return self
end

--- Recolors the handle of a part.
-- @tparam NewColor BrickColor New color for the handle
function F3X:RecolorHandle(NewColor)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("RecolorHandle", NewColor)
end

--- Clones multiple parts and sets their parent.
-- @tparam Items table Parts to clone
-- @tparam Parent Instance Parent instance
-- @treturn {Instance} Cloned parts
function F3X:CloneParts(Items, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Clone", Items, Parent)
end

--- Clones a single part and sets its parent.
-- @tparam Item Instance Part to clone
-- @tparam[opt=Item.Parent] Parent Instance Parent instance
-- @treturn Instance Cloned part
function F3X:Clone(Item, Parent)
    return self:CloneParts({Item}, Parent or Item.Parent)[1]
end

--- Creates a new part of the specified type at the given position.
-- @tparam PartType string Type of the part
-- @tparam Position CFrame Position of the part
-- @tparam Parent Instance Parent instance
-- @treturn BasePart Created part
function F3X:CreatePart(PartType, Position, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreatePart", PartType, Position, Parent)
end

--- Creates a group (Model or Folder) containing the specified items.
-- @tparam Type string Type of the group
-- @tparam Parent Instance Parent instance
-- @tparam Items table Items to group
-- @treturn Model|Folder Created group
function F3X:CreateGroup(Type, Parent, Items)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateGroup", Type, Parent, Items)
end

--- Ungroups the specified groups.
-- @tparam Groups table Groups to ungroup
-- @treturn table Ungrouped items
function F3X:Ungroup(Groups)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Ungroup", Groups)
end

--- Sets the parent of the specified items.
-- @tparam Items table Items to reparent
-- @tparam Parent Instance New parent instance
function F3X:SetParent(Items, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetParent", Items, Parent)
end

--- Sets the name of the specified items.
-- @tparam Items table Items to rename
-- @tparam Name string New name
function F3X:SetNames(Items, Name)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetName", Items, Name)
end

--- Sets the name of a single item.
-- @tparam Item Instance Item to rename
-- @tparam Name string New name
function F3X:SetName(Item, Name)
    return self:SetNames({Item}, Name)
end

--- Removes the specified parts.
-- @tparam Objects table Parts to remove
function F3X:RemoveParts(Objects)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Remove", Objects)
end

--- Removes a single part.
-- @tparam Object Instance Part to remove
function F3X:Remove(Object)
    return self:RemoveParts({Object})
end

--- Undoes the removal of the specified parts.
-- @tparam Objects table Parts to restore
function F3X:UndoRemovedParts(Objects)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("UndoRemove", Objects)
end

--- Undoes the removal of a single part.
-- @tparam Object Instance Part to restore
function F3X:UndoRemove(Object)
    return self:UndoRemovedParts({Object})
end

--- Moves the specified parts to the given CFrame.
-- @tparam Changes table Parts and their new CFrames
function F3X:MoveParts(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncMove", Changes)
end

--- Moves a single part to the given CFrame.
-- @tparam Part BasePart Part to move
-- @tparam CFrame CFrame New CFrame
function F3X:Move(Part, CFrame)
    return self:MoveParts({{["Part"] = Part, ["CFrame"] = CFrame}})
end

--- Moves a part to the specified position.
-- @tparam Part BasePart Part to move
-- @tparam Position Vector3 New position
function F3X:MoveTo(Part, Position)
    return self:MoveParts({{["Part"] = Part, ["CFrame"] = CFrame.new(Position)}})
end

--- Resizes the specified parts.
-- @tparam Changes table Parts and their new sizes and CFrames
function F3X:ResizeParts(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Resize", Changes)
end

--- Resizes a single part.
-- @tparam Part BasePart Part to resize
-- @tparam Size Vector3 New size
-- @tparam cf CFrame? Optional new CFrame
function F3X:Resize(Part, Size, cf)
    return self:ResizeParts({{["Part"] = Part, ["Size"] = Size, ["CFrame"] = cf}})
end

--- Rotates the specified parts.
-- @tparam Changes table Parts and their new CFrames
function F3X:RotateParts(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Rotate", Changes)
end

--- Rotates a single part.
-- @tparam Part BasePart Part to rotate
-- @tparam CFrame CFrame New CFrame
function F3X:Rotate(Part, CFrame)
    return self:RotateParts({{["Part"] = Part, ["CFrame"] = CFrame}})
end

--- Sets the color of the specified parts.
-- @tparam Changes table Parts and their new colors
function F3X:SetColors(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetColor", Changes)
end

--- Sets the color of a single part.
-- @tparam Part BasePart Part to color
-- @tparam Color Color3 New color
function F3X:SetColor(Part, Color)
    return self:SetColors({{["Part"] = Part, ["Color"] = Color}})
end

--- Sets the surfaces of the specified parts.
-- @tparam Changes table Parts and their new surfaces
function F3X:SetPartsSurfaces(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetSurface", Changes)
end

--- Sets the surfaces of a single part.
-- @tparam Part BasePart Part to set surfaces
-- @tparam Surfaces table New surfaces
function F3X:SetSurfaces(Part, Surfaces)
    return self:SetPartsSurfaces({{["Part"] = Part, ["Surfaces"] = Surfaces}})
end

--- Sets the surface of a single face of a part.
-- @tparam Part BasePart Part to set surface
-- @tparam Face string Face to set
-- @tparam SurfaceType Enum.SurfaceType New surface type
function F3X:SetSurface(Part, Face, SurfaceType)
    return self:SetSurfaces(Part, {[Face] = SurfaceType})
end

--- Creates lights on the specified parts.
-- @tparam Changes table Parts and their light types
-- @treturn table Created lights
function F3X:CreateLights(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateLight", Changes)
end

--- Creates a single light on a part.
-- @tparam Part Instance Part to create light on
-- @tparam LightType string Type of light
-- @treturn Instance Created light
function F3X:CreateLight(Part, LightType)
    return self:CreateLights({{["Part"] = Part, ["LightType"] = LightType}})[1]
end

--- Sets the properties of the specified lights.
-- @tparam Changes table Lights and their new properties
function F3X:SetLights(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetLight", Changes)
end

--- Creates decorations on the specified parts.
-- @tparam Changes table Parts and their decoration types
-- @treturn table Created decorations
function F3X:CreateDecorations(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateDecoration", Changes)
end

--- Sets the properties of the specified decorations.
-- @tparam Changes table Decorations and their new properties
function F3X:SetDecorations(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetDecoration", Changes)
end

--- Creates meshes on the specified parts.
-- @tparam Changes table Parts to create meshes on
-- @treturn table Created meshes
function F3X:CreateMeshes(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateMesh", Changes)
end

--- Sets the properties of the specified meshes.
-- @tparam Changes table Meshes and their new properties
function F3X:SetMeshes(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetMesh", Changes)
end

--- Creates textures on the specified parts.
-- @tparam Changes table Parts and their texture types
-- @treturn table Created textures
function F3X:CreateTextures(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateTexture", Changes)
end

--- Sets the properties of the specified textures.
-- @tparam Changes table Textures and their new properties
function F3X:SetTextures(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetTexture", Changes)
end

--- Sets the anchored state of the specified parts.
-- @tparam Changes table Parts and their anchored states
function F3X:SetAnchors(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetAnchor", Changes)
end

--- Anchors a single part.
-- @tparam Part BasePart Part to anchor
function F3X:Anchor(Part)
    return self:SetAnchors({{["Part"] = Part, ["Anchored"] = true}})
end

--- Unanchors a single part.
-- @tparam Part BasePart Part to unanchor
function F3X:Unanchor(Part)
    return self:SetAnchors({{["Part"] = Part, ["Anchored"] = false}})
end

--- Sets the collision state of the specified parts.
-- @tparam Changes table Parts and their collision states
function F3X:SetCollision(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetCollision", Changes)
end

--- Sets the material properties of the specified parts.
-- @tparam Changes table Parts and their new material properties
function F3X:SetMaterial(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetMaterial", Changes)
end

--- Creates welds between the specified parts and the target part.
-- @tparam Parts table Parts to weld
-- @tparam TargetPart BasePart Target part
-- @treturn table Created welds
function F3X:CreateWelds(Parts, TargetPart)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateWeld", Parts, TargetPart)
end

--- Removes the specified welds.
-- @tparam Welds table Welds to remove
-- @treturn number Number of removed welds
function F3X:RemoveWelds(Welds)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("RemoveWeld", Welds)
end

--- Undoes the removal of the specified welds.
-- @tparam Welds table Welds to restore
function F3X:UndoRemovedWelds(Welds)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("UndoRemoveWeld", Welds)
end

--- Exports the specified parts.
-- @tparam Parts table Parts to export
-- @treturn string|nil Exported data
function F3X:Export(Parts)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Export", Parts)
end

--- Checks if the HTTP service is enabled.
-- @treturn boolean True if enabled, false otherwise
function F3X:IsHttpServiceEnabled()
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("IsHttpServiceEnabled")
end

--- Extracts a mesh from the specified asset ID.
-- @tparam AssetId number Asset ID
-- @treturn any Extracted mesh
function F3X:ExtractMeshFromAsset(AssetId)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("ExtractMeshFromAsset", AssetId)
end

--- Extracts an image from the specified decal asset ID.
-- @tparam DecalAssetId number Decal asset ID
-- @treturn string Extracted image
function F3X:ExtractImageFromDecal(DecalAssetId)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("ExtractImageFromDecal", DecalAssetId)
end

--- Enables or disables mouse lock.
-- @tparam Enabled boolean True to enable, false to disable
function F3X:SetMouseLockEnabled(Enabled)
    assert(self._reinit, errors.notIntialized)
    if self.endpoint.Parent == nil then self._reinit() end
    return self.endpoint:InvokeServer("SetMouseLockEnabled", Enabled)
end

--- Sets the locked state of the specified items.
-- @tparam Items table Items to lock or unlock
-- @tparam Locked table|boolean Locked state
function F3X:SetLocked(Items, Locked)
    assert(self.reinit, errors.notIntialized)
    if self.endpoint.Parent == nil then self._reinit() end
    return self.endpoint:InvokeServer("SetLocked", Items, Locked)
end

return F3X