--not mine i just had to delete the loading and the uhm.. the fake char (fake character)

local NetworkAccess = coroutine.create(function()
	settings().Physics.AllowSleep = false
	while true do
		game:GetService("RunService").RenderStepped:Wait()
		local TBL = game:GetService("Players"):GetChildren() 
		for _ = 1, #TBL do
			local Players = TBL[_]
			if Players ~= game:GetService("Players").LocalPlayer then
				sethiddenproperty(game.Players.LocalPlayer,"MaximumSimulationRadius",math.pow(math.huge,math.huge)*math.huge)
   				sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.pow(math.huge,math.huge)*math.huge)
			end
		end
		game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
		game:GetService("Players").LocalPlayer.SimulationRadius = math.huge * math.huge
	end
end)
coroutine.resume(NetworkAccess)

--workspace.Camera.CameraType = "Fixed"
game:GetService("Players").LocalPlayer["Character"].Archivable = true
local CloneChar = game:GetService("Players").LocalPlayer["Character"]:Clone()
game:GetService("Players").LocalPlayer["Character"].Humanoid.WalkSpeed = 0
game:GetService("Players").LocalPlayer["Character"].Humanoid.JumpPower = 0
game:GetService("Players").LocalPlayer["Character"].Humanoid.AutoRotate = false
game:GetService("RunService").Heartbeat:Wait()
local FalseChar = Instance.new("Model", workspace);
FalseChar.Name = ""
Instance.new("Part", FalseChar).Name = "Head"
Instance.new("Part", FalseChar).Name = "Torso"
Instance.new("Humanoid", FalseChar).Name = "Humanoid"
game:GetService("Players").LocalPlayer["Character"] = FalseChar
game:GetService("Players").LocalPlayer["Character"].Humanoid.Name = "FalseHumanoid"
local Clone = game:GetService("Players").LocalPlayer["Character"]:FindFirstChild("FalseHumanoid"):Clone()
Clone.Parent = game:GetService("Players").LocalPlayer["Character"]
Clone.Name = "Humanoid"
game:GetService("Players").LocalPlayer["Character"]:FindFirstChild("FalseHumanoid"):Destroy()
wait(5.65)
game:GetService("Players").LocalPlayer["Character"].Humanoid.Health = 0
game:GetService("Players").LocalPlayer["Character"] = workspace[game:GetService("Players").LocalPlayer.Name]
local Goal = {}
Goal.Size = 0
wait(5.65)
game:GetService("Players").LocalPlayer["Character"].Humanoid.Health = 0
local Character = game:GetService("Players").LocalPlayer["Character"]
CloneChar.Parent = workspace
CloneChar.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
wait()
CloneChar.Humanoid.BreakJointsOnDeath = false
workspace.Camera.CameraSubject = CloneChar.Humanoid
CloneChar.Name = "CloneCharacter"
CloneChar.Humanoid.DisplayDistanceType = "None"
local DeadChar = workspace[game:GetService("Players").LocalPlayer.Name]
FalseChar:Destroy()

local LVecPart = Instance.new("Part", workspace)
LVecPart.CanCollide = false
LVecPart.Transparency = 1
game:GetService("RunService").Heartbeat:Connect(function()
	local lookVec = workspace.Camera.CFrame.lookVector
	local Root = CloneChar["HumanoidRootPart"]
	LVecPart.Position = Root.Position
	LVecPart.CFrame = CFrame.new(LVecPart.Position, Vector3.new(lookVec.X * 9999, lookVec.Y, lookVec.Z * 9999))
end)

local WDown, ADown, SDown, DDown, SpaceDown = false, false, false, false, false
game:GetService("UserInputService").InputBegan:Connect(function(_, Processed)
	if Processed ~= true then
		local Key = _.KeyCode
		if Key == Enum.KeyCode.W then
			WDown = true
		end
		if Key == Enum.KeyCode.A then
			ADown = true
		end
		if Key == Enum.KeyCode.S then
			SDown = true
		end
		if Key == Enum.KeyCode.D then
			DDown = true
		end
		if Key == Enum.KeyCode.Space then
			SpaceDown = true
		end
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(_)
	local Key = _.KeyCode
	if Key == Enum.KeyCode.W then
		WDown = false
	end
	if Key == Enum.KeyCode.A then
		ADown = false
	end
	if Key == Enum.KeyCode.S then
		SDown = false
	end
	if Key == Enum.KeyCode.D then
		DDown = false
	end
	if Key == Enum.KeyCode.Space then
		SpaceDown = false
	end
end)

local function MoveClone(X, Y, Z)
	LVecPart.CFrame = LVecPart.CFrame * CFrame.new(-X, Y, -Z)
	CloneChar.Humanoid.WalkToPoint = LVecPart.Position
end

local WalkLoop = coroutine.create(function()
	while true do
		game:GetService("RunService").RenderStepped:Wait()
		if WDown then
			MoveClone(0, 0, 1e4)
		end
		if ADown then
			MoveClone(1e4, 0, 0)
		end
		if SDown then
			MoveClone(0, 0, -1e4)
		end
		if DDown then
			MoveClone(-1e4, 0, 0)
		end
		if SpaceDown then
			CloneChar["Humanoid"].Jump = true
		end
		if WDown ~= true and ADown ~= true and SDown ~= true and DDown ~= true then
			CloneChar.Humanoid.WalkToPoint = CloneChar.HumanoidRootPart.Position
		end
	end
end)
coroutine.resume(WalkLoop)

game:GetService("RunService").Stepped:Connect(function()
	for _, Parts in next, CloneChar:GetDescendants() do
		if Parts:IsA("BasePart") then
			Parts.CanCollide = false
		end
	end
	for _, Parts in next, DeadChar:GetDescendants() do
		if Parts:IsA("BasePart") then
			Parts.CanCollide = false
		end
	end
end)

local Amount = 6 --/* Riptxde's AlignForce Template
local ApplyAtCenterOfMass = true
local Char = CloneChar
local A = Instance.new("Folder", game)
A.Name = "AlignFolder"
local B = Instance.new("Part", A)
B.Name = "SPart"
for _ = 1, Amount do
	local AP = Instance.new("AlignPosition", A)
	AP.Name = "APos".._
	if ApplyAtCenterOfMass then
		AP.ApplyAtCenterOfMass = true
	end
	AP.RigidityEnabled = false
	AP.ReactionForceEnabled = false
	AP.ApplyAtCenterOfMass = true
	AP.MaxForce = 67752
	AP.MaxVelocity = math.huge / 9e110
	AP.Responsiveness = 200
	local Att0Pos = Instance.new("Attachment", B)
	AP.Attachment0 = Att0Pos
	Att0Pos.Name = "Att0Pos".._
	local Att1Pos = Instance.new("Attachment", B)
	AP.Attachment1 = Att1Pos
	Att1Pos.Name = "Att1Pos".._
	local AO = Instance.new("AlignOrientation", A)
	AO.Name = "ARot".._
	AO.RigidityEnabled = false
	AO.ReactionTorqueEnabled = true
	AO.PrimaryAxisOnly = false
	AO.MaxTorque = 67752
	AO.MaxAngularVelocity = math.huge / 9e110
	AO.Responsiveness = 200
	local Att0Rot = Instance.new("Attachment", B)
	AO.Attachment0 = Att0Rot
	Att0Rot.Name = "Att0Rot".._
	local Att1Rot = Instance.new("Attachment", B)
	AO.Attachment1 = Att1Rot
	Att1Rot.Name = "Att1Rot".._
end

B.Att1Pos1.Parent = CloneChar["Head"]
B.Att1Rot1.Parent = CloneChar["Head"]
B.Att1Pos2.Parent = CloneChar["Torso"]
B.Att1Rot2.Parent = CloneChar["Torso"]
B.Att1Pos3.Parent = CloneChar["Left Arm"]
B.Att1Rot3.Parent = CloneChar["Left Arm"]
B.Att1Pos4.Parent = CloneChar["Right Arm"]
B.Att1Rot4.Parent = CloneChar["Right Arm"]
B.Att1Pos5.Parent = CloneChar["Left Leg"]
B.Att1Rot5.Parent = CloneChar["Left Leg"]
B.Att1Pos6.Parent = CloneChar["Right Leg"]
B.Att1Rot6.Parent = CloneChar["Right Leg"]

B.Att0Pos1.Parent = DeadChar["Head"]
B.Att0Rot1.Parent = DeadChar["Head"]
B.Att0Pos2.Parent = DeadChar["Torso"]
B.Att0Rot2.Parent = DeadChar["Torso"]
B.Att0Pos3.Parent = DeadChar["Left Arm"]
B.Att0Rot3.Parent = DeadChar["Left Arm"]
B.Att0Pos4.Parent = DeadChar["Right Arm"]
B.Att0Rot4.Parent = DeadChar["Right Arm"]
B.Att0Pos5.Parent = DeadChar["Left Leg"]
B.Att0Rot5.Parent = DeadChar["Left Leg"]
B.Att0Pos6.Parent = DeadChar["Right Leg"]
B.Att0Rot6.Parent = DeadChar["Right Leg"]

if CloneChar:FindFirstChild("ForceField") then
	CloneChar.ForceField:Destroy()
end

local Num = 1
for _, Hats in next, DeadChar:GetChildren() do
	if Hats:IsA("Accessory") then
		local AP = Instance.new("AlignPosition", A)
		AP.ApplyAtCenterOfMass = true
		AP.RigidityEnabled = false
		AP.ReactionForceEnabled = false
		AP.ApplyAtCenterOfMass = true
		AP.MaxForce = 64060 * Hats.Handle.Size.X * Hats.Handle.Size.Y * Hats.Handle.Size.Z
		AP.MaxVelocity = math.huge / 9e110
		AP.Responsiveness = 200
		local Att0Pos = Instance.new("Attachment", Hats.Handle)
		AP.Attachment0 = Att0Pos
		local Att1Pos = Instance.new("Attachment", CloneChar.Humanoid:GetAccessories()[Num].Handle)
		AP.Attachment1 = Att1Pos
		local AO = Instance.new("AlignOrientation", A)
		AO.RigidityEnabled = false
		AO.ReactionTorqueEnabled = false
		AO.PrimaryAxisOnly = false
		AO.MaxTorque = 42060 * Hats.Handle.Size.X * Hats.Handle.Size.Y * Hats.Handle.Size.Z
		AO.MaxAngularVelocity = math.huge / 9e110
		AO.Responsiveness = 200
		local Att0Rot = Instance.new("Attachment", Hats.Handle)
		AO.Attachment0 = Att0Rot
		local Att1Rot = Instance.new("Attachment", CloneChar.Humanoid:GetAccessories()[Num].Handle)
		AO.Attachment1 = Att1Rot
		Num = Num + 1
	end
end

for _, Aligns in next, A:GetChildren() do
	if Aligns:IsA("AlignOrientation") or Aligns:IsA("AlignPosition") then
		Aligns.Parent = CloneChar
	end
end

game:GetService("RunService").RenderStepped:Connect(function()
	for _, BodyParts in next, CloneChar:GetDescendants() do
		if BodyParts:IsA("BasePart") or BodyParts:IsA("Part") then
			BodyParts.Transparency = 1
		end
	end
	for _, Effects in next, CloneChar:GetDescendants() do
		if Effects:IsA("ParticleEmitter") or Effects:IsA("Sparkles") or Effects:IsA("BillboardGui") or Effects:IsA("Fire") or Effects:IsA("TextLabel") then
			Effects:Destroy()
		end
	end 
	for _, Decals in next, CloneChar:GetDescendants() do
		if Decals:IsA("Decal") then
			Decals.Texture = 0
		end
	end
end)
workspace.Camera.CameraType = "Track"

local function invisCam()
	game:GetService("Players").LocalPlayer.DevCameraOcclusionMode = "Invisicam"
end
invisCam()
game:GetService("Players").LocalPlayer:GetPropertyChangedSignal("DevCameraOcclusionMode"):Connect(invisCam)

return CloneChar
