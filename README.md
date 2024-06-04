# f3x-wrapper

> [!NOTE]  
> [bqmb3](https://github.com/bqmb3) and `f3x-wrapper` is **NOT** affiliated with [F3X](https://github.com/F3XTeam) in any way.

## Description

`f3x-wrapper` is a Lua module designed to interface with the F3X building tools in Roblox. It provides a set of functions to manipulate parts, groups, lights, decorations, meshes, textures, and more within the game environment.

## Functions

### Initialization

- **`F3X.new(init: () -> ())`**
  - Creates a new instance of the F3X module and initializes it.

### Part Manipulation

- **`F3X:RecolorHandle(NewColor: BrickColor): nil`**
  - Recolors the handle of a part.

- **`F3X:CloneParts(Items: table, Parent: Instance): table`**
  - Clones multiple parts and sets their parent.

- **`F3X:Clone(Item: Instance, Parent: Instance?): Instance`**
  - Clones a single part and sets its parent.

- **`F3X:CreatePart(PartType: string, Position: CFrame, Parent: Instance): BasePart`**
  - Creates a new part of the specified type at the given position.

- **`F3X:CreateGroup(Type: string, Parent: Instance, Items: {Instance}): Model | Folder`**
  - Creates a group (Model or Folder) containing the specified items.

- **`F3X:Ungroup(Groups: {Instance}): {Instance}`**
  - Ungroups the specified groups.

- **`F3X:SetParent(Items: {Instance}, Parent: Instance): nil`**
  - Sets the parent of the specified items.

- **`F3X:SetNames(Items: {Instance}, Name: string): nil`**
  - Sets the name of the specified items.

- **`F3X:SetName(Item: Instance, Name: string): nil`**
  - Sets the name of a single item.

- **`F3X:RemoveParts(Objects: {Instance}): nil`**
  - Removes the specified parts.

- **`F3X:Remove(Object: Instance): nil`**
  - Removes a single part.

- **`F3X:UndoRemovedParts(Objects: {Instance}): nil`**
  - Undoes the removal of the specified parts.

- **`F3X:UndoRemove(Object: Instance): nil`**
  - Undoes the removal of a single part.

- **`F3X:MoveParts(Changes: {{Part: BasePart, CFrame: CFrame}}): nil`**
  - Moves the specified parts to the given CFrame.

- **`F3X:Move(Part: BasePart, CFrame: CFrame): nil`**
  - Moves a single part to the given CFrame.

- **`F3X:MoveTo(Part: BasePart, Position: Vector3): nil`**
  - Moves a part to the specified position.

- **`F3X:ResizeParts(Changes: {{Part: BasePart, CFrame: CFrame, Size: Vector3}}): nil`**
  - Resizes the specified parts.

- **`F3X:Resize(Part: BasePart, Size: Vector3, cf: CFrame?): nil`**
  - Resizes a single part.

- **`F3X:RotateParts(Changes: {{Part: BasePart, CFrame: CFrame}}): nil`**
  - Rotates the specified parts.

- **`F3X:Rotate(Part: BasePart, CFrame: CFrame): nil`**
  - Rotates a single part.

- **`F3X:SetColors(Changes: {{Part: BasePart, Color: Color3}}): nil`**
  - Sets the color of the specified parts.

- **`F3X:SetColor(Part: BasePart, Color: Color3): nil`**
  - Sets the color of a single part.

- **`F3X:SetPartsSurfaces(Changes: {{Part: BasePart, Surfaces: {["Top" | "Front" | "Bottom" | "Right" | "Left" | "Back"]: Enum.SurfaceType}}}): nil`**
  - Sets the surfaces of the specified parts.

- **`F3X:SetSurfaces(Part: BasePart, Surfaces: {["Top" | "Front" | "Bottom" | "Right" | "Left" | "Back"]: Enum.SurfaceType}): nil`**
  - Sets the surfaces of a single part.

- **`F3X:SetSurface(Part: BasePart, Face: "Top" | "Front" | "Bottom" | "Right" | "Left" | "Back", SurfaceType: Enum.SurfaceType): nil`**
  - Sets the surface of a single face of a part.

### Light Manipulation

- **`F3X:CreateLights(Changes: {{Part: Instance, LightType: "SpotLight" | "PointLight" | "SurfaceLight"}}): {SpotLight | PointLight | SurfaceLight}`**
  - Creates lights on the specified parts.

- **`F3X:CreateLight(Part: Instance, LightType: "SpotLight" | "PointLight" | "SurfaceLight"): SpotLight | PointLight | SurfaceLight`**
  - Creates a single light on a part.

- **`F3X:SetLights(Changes: {{Part: Instance, LightType: "SpotLight" | "PointLight" | "SurfaceLight", Range: number?, Brightness: number?, Color: Color3?, Shadows: boolean?, Face: Enum.NormalId?, Angle: number? }}): nil`**
  - Sets the properties of the specified lights.

### Decoration Manipulation

- **`F3X:CreateDecorations(Changes: {{Part: Instance, DecorationType: "Smoke" | "Fire" | "Sparkles"}}): {Smoke | Fire | Sparkles}`**
  - Creates decorations on the specified parts.

- **`F3X:SetDecorations(Changes: {{Part: Instance, DecorationType: "Smoke" | "Fire" | "Sparkles", Color: Color3?, Opacity: number?, RiseVelocity: number?, Size: number?, Heat: number?, SecondaryColor: Color3?, SparkleColor: Color3? }}): nil`**
  - Sets the properties of the specified decorations.

### Mesh Manipulation

- **`F3X:CreateMeshes(Changes: {{Part: Instance}}): {SpecialMesh}`**
  - Creates meshes on the specified parts.

- **`F3X:SetMeshes(Changes: {{Part: Instance, VertexColor: Vector3?, MeshType: Enum.MeshType?, Scale: Vector3?, Offset: Vector3?, MeshId: string?, TextureId: string?}}): nil`
  - Sets the properties of the specified meshes.

### Texture Manipulation

- **`F3X:CreateTextures(Changes: {{Part: Instance, Face: Enum.NormalId, TextureType: "Texture" | "Decal"}}): {Texture | Decal}`**
  - Creates textures on the specified parts.

- **`F3X:SetTextures(Changes: {{Part: Instance, Face: Enum.NormalId, TextureType: "Texture" | "Decal", Texture: string?, Transparency: number?, StudsPerTileU: number?, StudsPerTileV: number?}}): nil`**
  - Sets the properties of the specified textures.

### Anchor and Collision

- **`F3X:SetAnchors(Changes: {{Part: BasePart, Anchored: boolean}}): nil`**
  - Sets the anchored state of the specified parts.

- **`F3X:Anchor(Part: BasePart): nil`**
  - Anchors a single part.

- **`F3X:Unanchor(Part: BasePart): nil`**
  - Unanchors a single part.

- **`F3X:SetCollision(Changes: {{Part: Instance, CanCollide: boolean}}): nil`**
  - Sets the collision state of the specified parts.

### Material and Welds

- **`F3X:SetMaterial(Changes: {{Part: Instance, Material: Enum.Material?, Transparency: number?, Reflectance: number?}}): nil`**
  - Sets the material properties of the specified parts.

- **`F3X:CreateWelds(Parts: {BasePart}, TargetPart: BasePart): {Weld}`**
  - Creates welds between the specified parts and the target part.

- **`F3X:RemoveWelds(Welds: {Weld}): number`**
  - Removes the specified welds.

- **`F3X:UndoRemovedWelds(Welds: {Weld}): nil`**
  - Undoes the removal of the specified welds.

### Export and HTTP Service

- **`F3X:Export(Parts: {BasePart}): string | nil`**
  - Exports the specified parts.

- **`F3X:IsHttpServiceEnabled(): boolean`**
  - Checks if the HTTP service is enabled.

### Asset Extraction

- **`F3X:ExtractMeshFromAsset(AssetId: number): any`**
  - Extracts a mesh from the specified asset ID.

- **`F3X:ExtractImageFromDecal(DecalAssetId: number): string`**
  - Extracts an image from the specified decal asset ID.

### Miscellaneous

- **`F3X:SetMouseLockEnabled(Enabled: boolean): nil`**
  - Enables or disables mouse lock.

- **`F3X:SetLocked(Items: table, Locked: table | boolean): nil`**
  - Sets the locked state of the specified items.

## Usage

To use the `f3x-wrapper` module, require it in your script and create an instance of the F3X class:
```lua
local F3X = require(path.to.f3x-wrapper)
local f3x = F3X.new()
-- Example usage
f3x:CreatePart("Normal", CFrame.new(0, 0, 0), workspace)
```