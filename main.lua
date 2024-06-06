--!strict
local F3X = {}
F3X.__index = F3X

local plr = game:GetService("Players").LocalPlayer

local errors: {[string]: string} = {
    endpointNotFound = "Cannot find F3X endpoint.",
    notIntialized = "Not Initialized",
}

local initFunc = _G.F3X__init_func or function()
    game.Players:Chat(':f3x')
end

function F3X.new(init: () -> ())
    if type(init) == "function" then
        init = initFunc
    end

    local self
    self = setmetatable({
        _reinit = function()
            init()
            local Folder = plr.Backpack:WaitForChild('Folder', 1)
            local SyncAPI = Folder and Folder:WaitForChild('SyncAPI', 1)
            local ServerEndpoint: RemoteEvent = SyncAPI and SyncAPI:WaitForChild('ServerEndpoint', 1)
            assert(ServerEndpoint, errors.endpointNotFound)
            self._endpoint = ServerEndpoint
        end,
        _endpoint = nil,
    })
    self._reinit()

    return self
end

function F3X:RecolorHandle(NewColor: BrickColor): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("RecolorHandle", NewColor)
end

function F3X:CloneParts(Items: table, Parent: Instance): table
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Clone", Items, Parent)
end

function F3X:Clone(Item: Instance, Parent: Instance?): Instance
    return self:CloneParts({Item}, Parent or Item.Parent)[1]
end

function F3X:CreatePart(PartType: 'Normal' | 'Truss' | 'Wedge' | 'Corner' | 'Cylinder' | 'Ball' | 'Seat' | 'Vehicle Seat' | 'Spawn', Position: CFrame, Parent: Instance): BasePart
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreatePart", PartType, Position, Parent)
end

function F3X:CreateGroup(Type: 'Model' | 'Folder', Parent: Instance, Items: {Instance}): Model | Folder
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateGroup", Parent, Items)
end

function F3X:Ungroup(Groups: {Instance}): {Instance}
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Ungroup", Groups)
end

function F3X:SetParent(Items: {Instance}, Parent: Instance): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetParent", Items, Parent)
end

function F3X:SetNames(Items: {Instance}, Name: string): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetName", Items, Name)
end

function F3X:SetName(Item: Instance, Name: string): nil
    return self:SetNames({Item}, Name)
end

function F3X:RemoveParts(Objects: {Instance}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Remove", Objects)
end

function F3X:Remove(Object: Instance): nil
    return self:RemoveParts({Object})
end

function F3X:UndoRemovedParts(Objects: {Instance}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("UndoRemove", Objects)
end

function F3X:UndoRemove(Object: Instance): nil
    return self:UndoRemovedParts({Object})
end

function F3X:MoveParts(Changes: {{Part: BasePart, CFrame: CFrame}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncMove", Changes)
end

function F3X:Move(Part: BasePart, CFrame: CFrame): nil
    return self:MoveParts({{["Part"] = Part, ["CFrame"] = CFrame}})
end

function F3X:MoveTo(Part: BasePart, Position: Vector3): nil
    assert(Part:IsA('BasePart'), 'Part is not a BasePart')
    local rot = Part.Rotation
    local cf = CFrame.new(Position) * CFrame.Angles(rot.X, rot.Y, rot.Z)
    return self:MoveParts({{["Part"] = Part, ["CFrame"] = cf}})
end

function F3X:ResizeParts(Changes: {{Part: BasePart, CFrame: CFrame, Size: Vector3}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncResize", Changes)
end

function F3X:Resize(Part: BasePart, Size: Vector3, cf: CFrame?): nil
    return self:ResizeParts({{["Part"] = Part, ["CFrame"] = cf or Part.CFrame, ["Size"] = Size}})
end

function F3X:RotateParts(Changes: {{Part: BasePart, CFrame: CFrame}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncRotate", Changes)
end

function F3X:Rotate(Part: BasePart, CFrame: CFrame): nil
    return self:RotateParts({{["Part"] = Part, ["CFrame"] = CFrame}})
end

function F3X:SetColors(Changes: {{Part: BasePart, Color: Color3}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncColor", Changes)
end

function F3X:SetColor(Part: BasePart, Color: Color3): nil
    return self:SetColors({{["Part"] = Part, ["Color"] = Color}})
end

function F3X:SetPartsSurfaces(Changes: {{Part: BasePart, Surfaces: {["Top" | "Front" | "Bottom" | "Right" | "Left" | "Back"]: Enum.SurfaceType}}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncSurface", Changes)
end

function F3X:SetSurfaces(Part: BasePart, Surfaces: {["Top" | "Front" | "Bottom" | "Right" | "Left" | "Back"]: Enum.SurfaceType}): nil
    return self:SetSurfaces({{["Part"] = Part, ["Surfaces"] = Surfaces}})
end

function F3X:SetSurface(Part: BasePart, Face: "Top" | "Front" | "Bottom" | "Right" | "Left" | "Back", SurfaceType: Enum.SurfaceType): nil
    return self:SetSurfaces({{["Part"] = Part, ["Surfaces"] = {[Face] = SurfaceType}}})
end

function F3X:CreateLights(Changes: {{Part: Instance, LightType: "SpotLight" | "PointLight" | "SurfaceLight"}}): {SpotLight | PointLight | SurfaceLight}
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateLights", Changes)
end

function F3X:CreateLight(Part: Instance, LightType: "SpotLight" | "PointLight" | "SurfaceLight"): SpotLight | PointLight | SurfaceLight
    return self:CreateLights({{["Part"] = Part, ["LightType"] = LightType}})[1]
end

function F3X:SetLights(Changes: {{Part: Instance, LightType: "SpotLight" | "PointLight" | "SurfaceLight", Range: number?, Brightness: number?, Color: Color3?, Shadows: boolean?, Face: Enum.NormalId?, Angle: number? }}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateLights", Changes)
end

function F3X:CreateDecorations(Changes: {{Part: Instance, DecorationType: "Smoke" | "Fire" | "Sparkles"}}): {Smoke | Fire | Sparkles}
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateDecorations", Changes)
end


function F3X:SetDecorations(Changes: {{Part: Instance, DecorationType: "Smoke" | "Fire" | "Sparkles", Color: Color3?, Opacity: number?, RiseVelocity: number?, Size: number?, Heat: number?, SecondaryColor: Color3?, SparkleColor: Color3? }}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncDecorate", Changes)
end

function F3X:CreateMeshes(Changes: {{Part: Instance}}): {SpecialMesh}
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateMeshes", Changes)
end

function F3X:SetMeshes(Changes: {{Part: Instance, VertexColor: Vector3?, MeshType: Enum.MeshType?, Scale: Vector3?, Offset: Vector3?, MeshId: string?, TextureId: string?}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncMesh", Changes)
end

function F3X:CreateTextures(Changes: {{Part: Instance, Face: Enum.NormalId, TextureType: "Texture" | "Decal"}}): {Texture | Decal}
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateTextures", Changes)
end

function F3X:SetTextures(Changes: {{Part: Instance, Face: Enum.NormalId, TextureType: "Texture" | "Decal", Texture: string?, Transparency: number?, StudsPerTileU: number?, StudsPerTileV: number?}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncTexture", Changes)
end

function F3X:SetAnchors(Changes: {{Part: BasePart, Anchored: boolean}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncAnchor", Changes)
end

function F3X:Anchor(Part: BasePart): nil
    return self:SetAnchorParts({["Part"] = Part, ["Anchored"] = true})
end

function F3X:Unanchor(Part: BasePart): nil
    return self:SetAnchorParts({["Part"] = Part, ["Anchored"] = false})
end

function F3X:SetCollision(Changes: {{Part: Instance, CanCollide: boolean}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncCollision", Changes)
end

function F3X:SetMaterial(Changes: {{Part: Instance, Material: Enum.Material?, Transparency: number?, Reflectance: number?}}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SyncCollision", Changes)
end

function F3X:CreateWelds(Parts: {BasePart}, TargetPart: BasePart): {Weld}
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("CreateWelds", Parts, TargetPart)
end

function F3X:RemoveWelds(Welds: {Weld}): number
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("RemoveWelds", Welds)
end

function F3X:UndoRemovedWelds(Welds: {Weld}): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("UndoRemovedWelds", Welds)
end

function F3X:Export(Parts: {BasePart}): string | nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("Export", Parts)
end

function F3X:IsHttpServiceEnabled(): boolean
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("IsHttpServiceEnabled")
end

function F3X:ExtractMeshFromAsset(AssetId: number): any
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("ExtractMeshFromAsset", AssetId)
end

function F3X:ExtractImageFromDecal(DecalAssetId: number): string
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("ExtractImageFromDecal", DecalAssetId)
end

function F3X:SetMouseLockEnabled(Enabled: boolean): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetMouseLockEnabled", Enabled)
end

function F3X:SetLocked(Items: table, Locked: table | boolean): nil
    assert(self._reinit, errors.notIntialized)
    if self._endpoint.Parent == nil then self._reinit() end
    return self._endpoint:InvokeServer("SetLocked", Items, Locked)
end

return F3X