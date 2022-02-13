-- not mine its from inf yield!!

local char = game.Players.LocalPlayer.Character
if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid"):ChangeState(15) end
char:ClearAllChildren()
local newChar = Instance.new("Model")
newChar.Parent = workspace
plr.Character = newChar
wait()
plr.Character = char
newChar:Destroy()
