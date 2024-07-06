--- f3x-wrapper: An Unofficial F3X Sync API Wrapper
-- @module f3x-wrapper
-- @author bqmb3
-- @license MIT
-- @copyright bqmb3 2024

if _G.F3X_wrapper_module then
    warn('f3x-wrapper already loaded, using preloaded module')
    return _G.F3X_wrapper_module
end

local F3X = {}
F3X.__index = F3X

local plr = game:GetService("Players").LocalPlayer

local errors = {
    endpointNotFound = "Cannot find F3X endpoint.",
    coreNotFound = "Cannot find F3X core.",
    notIntialized = "Not Initialized",
}

--- Creates a new instance of the F3X module and initializes it.
-- @tparam function init Initialization function
-- @treturn table New F3X instance
function F3X.new(init)
    init = init or _G.F3X__init_func or function()
        game.Players:Chat(':f3x')
    end
    local self
    self = setmetatable({
        _reinit = function()
            init()
            local Folder = plr.Backpack:WaitForChild('Folder', 1) or plr.Backpack:WaitForChild('Building Tools', 1)
            local Core = Folder and Folder:WaitForChild('Core', 1)
            local SyncAPI = Folder and Folder:WaitForChild('SyncAPI', 1)
            local ServerEndpoint = SyncAPI and SyncAPI:WaitForChild('ServerEndpoint', 1)
            assert(Core, errors.coreNotFound)
            assert(ServerEndpoint, errors.endpointNotFound)
            self._core = Core
            self._endpoint = ServerEndpoint
            --self._endpoint:InvokeServer("SetParent", {Folder}, plr)
        end,
        _core = nil,
        _endpoint = nil,
    }, F3X)
    self._reinit()

    return self
end

--- Recolors the handle of a part.
-- @tparam BrickColor NewColor New color for the handle
-- @treturn nil
function F3X:RecolorHandle(NewColor)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("RecolorHandle", NewColor)
end

--- Clones multiple parts and sets their parent.
-- @tparam table Items Parts to clone
-- @tparam Instance Parent Parent instance
-- @treturn {Instance,...} Cloned parts
function F3X:CloneParts(Items, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Clone", Items, Parent)
end

--- Clones a single part and sets its parent.
-- @tparam Instance Item Part to clone
-- @tparam[opt=Item.Parent] Instance Parent Parent instance
-- @treturn Instance Cloned part
function F3X:Clone(Item, Parent)
    return self:CloneParts({Item}, Parent or Item.Parent)[1]
end

--- Creates a new part of the specified type at the given position.
-- @tparam 'Normal'|'Truss'|'Wedge'|'Corner'|'Cylinder'|'Ball'|'Seat'|'VehicleSeat'|'Spawn' PartType Type of the part
-- @tparam CFrame Position Position of the part
-- @tparam[opt=workspace] Instance Parent Parent instance
-- @treturn BasePart Created part
function F3X:CreatePart(PartType, Position, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    if PartType == 'VehicleSeat' then
        PartType = 'Vehicle Seat'
    end
    return self._endpoint:InvokeServer("CreatePart", PartType, Position, Parent or workspace)
end

--- Creates a group (Model or Folder) containing the specified items.
-- @tparam string Type Type of the group
-- @tparam Instance Parent Parent instance
-- @tparam {Instance,...} Items Items to group
-- @treturn Model|Folder Created group
function F3X:CreateGroup(Type, Parent, Items)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateGroup", Type, Parent, Items)
end

--- Ungroups the specified groups.
-- @tparam {Instance,...} Groups Groups to ungroup
-- @treturn {Instance,...} Ungrouped items
function F3X:Ungroup(Groups)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Ungroup", Groups)
end

--- Sets the parent of the specified items.
-- @tparam {Instance,...} Items Items to reparent
-- @tparam Instance Parent New parent instance
-- @treturn nil
function F3X:SetParent(Items, Parent)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetParent", Items, Parent)
end

--- Sets the name of the specified items.
-- @tparam {Instance,...} Items Items to rename
-- @tparam string Name New name
-- @treturn nil
function F3X:SetNames(Items, Name)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetName", Items, Name)
end

--- Sets the name of a single item.
-- @tparam Instance Item Item to rename
-- @tparam string Name New name
-- @treturn nil
function F3X:SetName(Item, Name)
    return self:SetNames({Item}, Name)
end

--- Removes the specified parts.
-- @tparam {Instance,...} Objects Parts to remove
-- @treturn nil
function F3X:RemoveParts(Objects)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Remove", Objects)
end

--- Removes a single part.
-- @tparam Instance Object Part to remove
-- @treturn nil
function F3X:Remove(Object)
    return self:RemoveParts({Object})
end

--- Undoes the removal of the specified parts.
-- @tparam {Instance,...} Objects Parts to restore
-- @treturn nil
function F3X:UndoRemovedParts(Objects)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("UndoRemove", Objects)
end

--- Undoes the removal of a single part.
-- @tparam Instance Object Part to restore
-- @treturn nil
function F3X:UndoRemove(Object)
    return self:UndoRemovedParts({Object})
end

--- F3X:MoveParts(), F3X:RotateParts()
-- @table PartMovement
-- @tfield Instance Part Part to move
-- @tfield CFrame CFrame New CFrame
-- @see MoveParts
-- @see RotateParts

--- Moves the specified parts to the given CFrame.
-- @tparam {PartMovement,...} Changes Parts and their new CFrames
-- @treturn nil
function F3X:MoveParts(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncMove", Changes)
end

--- Moves a single part to the given CFrame.
-- @tparam BasePart Part Part to move
-- @tparam CFrame CFrame New CFrame
-- @treturn nil
function F3X:Move(Part, CFrame)
    return self:MoveParts({{["Part"] = Part, ["CFrame"] = CFrame}})
end

--- Moves a part to the specified position.
-- @tparam BasePart Part Part to move
-- @tparam Vector3 Position New position
-- @treturn nil
function F3X:MoveTo(Part, Position)
    return self:MoveParts({{["Part"] = Part, ["CFrame"] = CFrame.new(Position)}})
end

--- F3X:ResizeParts()
-- @table PartResize
-- @tfield Instance Part Part to resize
-- @tfield CFrame CFrame New CFrame
-- @tfield Vector3 Size New Size
-- @see MoveParts

--- Resizes the specified parts.
-- @tparam {PartResize,...} Changes Parts and their new sizes and CFrames
-- @treturn nil
function F3X:ResizeParts(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Resize", Changes)
end

--- Resizes a single part.
-- @tparam BasePart Part Part to resize
-- @tparam Vector3 Size New size
-- @tparam[opt=Part.CFrame] CFrame cf new CFrame
-- @treturn nil
function F3X:Resize(Part, Size, cf)
    return self:ResizeParts({{["Part"] = Part, ["Size"] = Size, ["CFrame"] = cf or Part.CFrame}})
end

--- Rotates the specified parts.
-- @tparam {PartMovement,...} Changes Parts and their new CFrames
-- @treturn nil
function F3X:RotateParts(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Rotate", Changes)
end

--- Rotates a single part.
-- @tparam BasePart Part Part to rotate
-- @tparam CFrame CFrame New CFrame
-- @treturn nil
function F3X:Rotate(Part, CFrame)
    return self:RotateParts({{["Part"] = Part, ["CFrame"] = CFrame}})
end

--- Sets the color of the specified parts.
-- @tparam {{Part:BasePart,Color:Color3},...} Changes Parts and their new colors
-- @treturn nil
function F3X:SetColors(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetColor", Changes)
end

--- Sets the color of a single part.
-- @tparam BasePart Part Part to color
-- @tparam Color3 Color New color
-- @treturn nil
function F3X:SetColor(Part, Color)
    return self:SetColors({{["Part"] = Part, ["Color"] = Color}})
end

--- F3X:SetPartsSurfaces()
-- @table SurfaceProperties
-- @tfield Instance Part The part
-- @tfield {["Top"|"Front"|"Bottom"|"Right"|"Left"|"Back"]:Enum.SurfaceType},...} Surfaces The face and type of surface to be set.
-- @see SetPartsSurfaces

--- Sets the surfaces of the specified parts.
-- @tparam {SurfaceProperties,...} Changes Parts and their new surfaces
-- @treturn nil
function F3X:SetPartsSurfaces(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetSurface", Changes)
end

--- Sets the surfaces of a single part.
-- @tparam BasePart Part Part to set surfaces
-- @tparam {["Top"|"Front"|"Bottom"|"Right"|"Left"|"Back"]:Enum.SurfaceType} Surfaces New surfaces
-- @treturn nil
function F3X:SetSurfaces(Part, Surfaces)
    return self:SetPartsSurfaces({{["Part"] = Part, ["Surfaces"] = Surfaces}})
end

--- Sets the surface of a single face of a part.
-- @tparam BasePart Part Part to set surface
-- @tparam "Top"|"Front"|"Bottom"|"Right"|"Left"|"Back" Face Face to set
-- @tparam Enum.SurfaceType SurfaceType New surface type
-- @treturn nil
function F3X:SetSurface(Part, Face, SurfaceType)
    return self:SetSurfaces(Part, {[Face] = SurfaceType})
end

--- F3X:CreateLights()
-- @table LightCreation
-- @tfield Instance Part The part
-- @tfield "SpotLight"|"PointLight"|"SurfaceLight" LightType The type of light to be created.
-- @see CreateLights

--- Creates lights on the specified parts.
-- @tparam {LightCreation,...} Changes Parts and their light types
-- @treturn {SpotLight|PointLight|SurfaceLight,...} Created lights
function F3X:CreateLights(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateLight", Changes)
end

--- Creates a single light on a part.
-- @tparam Instance Part Part to create light on
-- @tparam "SpotLight"|"PointLight"|"SurfaceLight" LightType Type of light
-- @treturn Instance Created light
function F3X:CreateLight(Part, LightType)
    return self:CreateLights({{["Part"] = Part, ["LightType"] = LightType}})[1]
end

--- F3X:SetLights()
-- @table LightProperties
-- @tfield Instance Part The part to which the light belongs.
-- @tfield "SpotLight"|"PointLight"|"SurfaceLight" LightType The type of light to be set.
-- @tfield[opt] number Range The range of the light.
-- @tfield[opt] number Brightness The brightness of the light.
-- @tfield[opt] Color3 Color The color of the light.
-- @tfield[opt] boolean Shadows Whether the light should cast shadows.
-- @tfield[opt] Enum.NormalId Face The face of the part to which the light is applied.
-- @tfield[opt] number Angle The angle of the light.
-- @see SetLights

--- Sets the properties of the specified lights.
-- @tparam {LightProperties,...} Changes A table containing information about the lights to be set.
-- @treturn nil
function F3X:SetLights(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetLight", Changes)
end

--- F3X:CreateDecorations()
-- @table DecorationCreation
-- @tfield Instance Part The part
-- @tfield "Smoke"|"Fire"|"Sparkles" DecorationType The type of decoration to be created.
-- @see CreateDecorations

--- Creates decorations on the specified parts.
-- @tparam {DecorationCreation,...} Changes Parts and their decoration types
-- @treturn {Smoke|Fire|Sparkles,...} Created decorations
function F3X:CreateDecorations(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateDecoration", Changes)
end

--- F3X:SetDecorations()
-- @table DecorationProperties
-- @tfield Instance Part The part to which the decoration belongs.
-- @tfield "Smoke"|"Fire"|"Sparkles" DecorationType The type of decoration to be set.
-- @tfield[opt] Color3 Color The color of the decoration.
-- @tfield[opt] number Opacity The opacity of the decoration.
-- @tfield[opt] number RiseVelocity The speed of decoration particles move during their lifetime.
-- @tfield[opt] number Size The size of the decoration.
-- @tfield[opt] Color3 SecondaryColor The secondary color of the fire decoration.
-- @tfield[opt] Color3 SparkleColor The sparkle color of the decoration.
-- @see SetDecorations

--- Sets the properties of the specified decorations.
-- @tparam {DecorationProperties,...} Changes Decorations and their new properties
-- @treturn nil
function F3X:SetDecorations(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetDecoration", Changes)
end

--- (deprecated) Creates meshes on the specified parts.
-- @warning This function is deprecated. Use CreateMeshesOnParts instead.
-- @tparam {{["Part"]:BasePart},...} Objects Parts to create meshes on
-- @treturn {SpecialMesh,...} Created meshes
-- @see CreateMeshesOnParts
function F3X:CreateMeshes(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateMesh", Changes)
end

--- Creates meshes on the specified parts.
-- @tparam {BasePart,...} Objects Parts to create meshes on
-- @treturn {SpecialMesh,...} Created meshes
function F3X:CreateMeshesOnParts(Objects)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    local Changes = {}
    for _, v in ipairs(Objects) do
        table.insert(Changes, {["Part"] = v})
    end
    return self._endpoint:InvokeServer("CreateMesh", Changes)
end

--- F3X:SetMeshes()
-- @table MeshProperties
-- @tfield Instance Part The part to which the mesh belongs.
-- @tfield[opt] Vector3 VertexColor The vertex color of the mesh.
-- @tfield[opt] Enum.MeshType MeshType The mesh type of mesh.
-- @tfield[opt] Vector3 Scale The scale of the mesh.
-- @tfield[opt] Vector3 Offset The offset of the mesh.
-- @tfield[opt] string MeshId The asset ID of the mesh.
-- @tfield[opt] string TextureId The asset ID of the mesh texture.
-- @see SetMeshes

--- Sets the properties of the specified meshes.
-- @tparam {MeshProperties,...} Changes Meshes and their new properties
-- @treturn nil
function F3X:SetMeshes(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetMesh", Changes)
end

--- F3X:CreateTextures()
-- @table TextureCreation
-- @tfield Instance Part The part to which the texture belongs.
-- @tfield Enum.NormalId Face The face of the part where the texture will be applied.
-- @tfield "Texture"|"Decal" TextureType The type of the texture.
-- @see CreateTextures

--- Creates textures on the specified parts.
-- @tparam {TextureCreation,...} Changes Parts and their texture types
-- @treturn {Texture|Decal,...} Created textures
function F3X:CreateTextures(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateTexture", Changes)
end

--- F3X:SetTextures()
-- @table TextureProperties
-- @tfield Instance Part The part to which the texture belongs.
-- @tfield Enum.NormalId Face The face of the part where the texture is.
-- @tfield "Texture"|"Decal" TextureType The type of the texture.
-- @tfield[opt] string Texture The asset ID of the texture.
-- @tfield[opt] number Transparency The transparency of the texture.
-- @tfield[opt] number StudsPerTileU Horizonal size of a texture tile in studs
-- @tfield[opt] number StudsPerTileV Vertical size of a texture tile in studs
-- @see SetTextures

--- Sets the properties of the specified textures.
-- @tparam {TextureProperties,...} Changes Textures and their new properties
-- @treturn nil
function F3X:SetTextures(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetTexture", Changes)
end

--- F3X:SetAnchors()
-- @table AnchorProperties
-- @tfield Instance Part The part to anchor or unanchor.
-- @tfield boolean Anchored Whether the part is anchored.
-- @see SetAnchors

--- Sets the anchored state of the specified parts.
-- @tparam {AnchorProperties,...} Changes Parts and their anchored states
-- @treturn nil
function F3X:SetAnchors(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetAnchor", Changes)
end

--- Anchors a single part.
-- @tparam BasePart Part Part to anchor
-- @treturn nil
function F3X:Anchor(Part)
    return self:SetAnchors({{["Part"] = Part, ["Anchored"] = true}})
end

--- Unanchors a single part.
-- @tparam BasePart Part Part to unanchor
-- @treturn nil
function F3X:Unanchor(Part)
    return self:SetAnchors({{["Part"] = Part, ["Anchored"] = false}})
end

--- F3X:SetCollisions()
-- @table CollisionProperties
-- @tfield Instance Part The part
-- @tfield boolean CanCollide Whether the part can collide with other parts.
-- @see SetCollisions

--- Sets the collision state of the specified parts.
-- @tparam {CollisionProperties,...} Changes Parts and their collision states
-- @treturn nil
function F3X:SetCollisions(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetCollision", Changes)
end

--- Sets the CanCollide property of single part.
-- @tparam BasePart Part The part
-- @tparam boolean CanCollide Whether the part can collide with other parts.
-- @treturn nil
function F3X:SetCollision(Part, CanCollide)
    return self:SetCollisions({{["Part"] = Part, ["CanCollide"] = CanCollide}})
end

--- F3X:SetMaterials()
-- @table MaterialProperties
-- @tfield Instance Part The part
-- @tfield[opt] Enum.Material Material The material of the part.
-- @tfield[opt] number Transparency The transparency of the part.
-- @tfield[opt] number Reflectance The reflectance of the part.
-- @see SetMaterials

--- Sets the material properties of the specified parts.
-- @tparam {MaterialProperties,...} Changes Parts and their new material properties
-- @treturn nil
function F3X:SetMaterials(Changes)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetMaterial", Changes)
end

--- Sets the material of single part.
-- @tparam BasePart Part The part
-- @tparam Enum.Material Material The material of the part.
-- @treturn nil
function F3X:SetMaterial(Part, Material)
    return self:SetMaterials({{["Part"] = Part, ["Material"] = Material}})
end

--- Sets the transparency of single part.
-- @tparam BasePart Part The part
-- @tparam number Transparency The transparency of the part.
-- @treturn nil
function F3X:SetTransparency(Part, Transparency)
    return self:SetMaterials({{["Part"] = Part, ["Transparency"] = Transparency}})
end

--- Sets the reflectance of single part.
-- @tparam BasePart Part The part
-- @tparam number Reflectance The reflectance of the part.
-- @treturn nil
function F3X:SetReflectance(Part, Reflectance)
    return self:SetMaterials({{["Part"] = Part, ["Reflectance"] = Reflectance}})
end

--- Creates welds between the specified parts and the target part.
-- @tparam {BasePart,...} Parts Parts to weld
-- @tparam BasePart TargetPart Target part
-- @treturn {Weld,...} Created welds
function F3X:CreateWelds(Parts, TargetPart)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateWeld", Parts, TargetPart)
end

--- Removes the specified welds.
-- @tparam {Weld,...} Welds Welds to remove
-- @treturn number Number of removed welds
function F3X:RemoveWelds(Welds)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("RemoveWeld", Welds)
end

--- Undoes the removal of the specified welds.
-- @tparam {Weld,...} Welds Welds to restore
-- @treturn nil
function F3X:UndoRemovedWelds(Welds)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("UndoRemoveWeld", Welds)
end

--- Exports the specified parts.
-- @tparam {BasePart,...} Parts Parts to export
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
-- @tparam number AssetId Asset ID
-- @treturn any Extracted mesh
function F3X:ExtractMeshFromAsset(AssetId)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("ExtractMeshFromAsset", AssetId)
end

--- Extracts an image from the specified decal asset ID.
-- @tparam number DecalAssetId Decal asset ID
-- @treturn string Extracted image
function F3X:ExtractImageFromDecal(DecalAssetId)
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("ExtractImageFromDecal", DecalAssetId)
end

--- Enables or disables mouse lock.
-- @tparam boolean Enabled True to enable, false to disable
-- @treturn nil
function F3X:SetMouseLockEnabled(Enabled)
    assert(self._reinit, errors.notIntialized)
    if self.endpoint.Parent == nil then self._reinit() end
    return self.endpoint:InvokeServer("SetMouseLockEnabled", Enabled)
end

--- Sets the locked state of the specified items.
-- @tparam table Items Items to lock or unlock
-- @tparam table|boolean Locked Locked state
-- @treturn nil
function F3X:SetLocked(Items, Locked)
    assert(self.reinit, errors.notIntialized)
    if self.endpoint.Parent == nil then self._reinit() end
    return self.endpoint:InvokeServer("SetLocked", Items, Locked)
end

--- Gets the currently selected parts.
-- @treturn {Instance,...} A table containing the selected parts
function F3X:GetSelectedParts()
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return require(self._core).Selection.Parts
end

_G.F3X_wrapper_module = F3X

return F3X