local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()

local gui = Instance.new("ScreenGui")
gui.Parent = LP:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(1, -200, 0.5, -150)
frame.AnchorPoint = Vector2.new(0, 0.5)
frame.Parent = gui

local function createButton(text, yPos, callback)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Size = UDim2.new(0, 180, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.Parent = frame
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- FLY SYSTEM
local flying = false
createButton("Toggle Fly", 10, function()
	flying = not flying
	local humanoid = LP.Character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.PlatformStand = flying
		spawn(function()
			while flying and wait() do
				if UIS:IsKeyDown(Enum.KeyCode.W) then
					LP.Character.HumanoidRootPart.Velocity += Vector3.new(0,0,-50)
				end
				if UIS:IsKeyDown(Enum.KeyCode.S) then
					LP.Character.HumanoidRootPart.Velocity += Vector3.new(0,0,50)
				end
			end
		end)
	end
end)

-- TELEPORT TOOL
createButton("Teleport Gun", 50, function()
	Mouse.Button1Down:Connect(function()
		if Mouse.Target then
			LP.Character:MoveTo(Mouse.Hit.Position)
		end
	end)
end)

-- NO CLIP
createButton("Toggle Noclip", 90, function()
	LP.Character.Humanoid:ChangeState(11)
end)

-- SPEED HACK
createButton("Speed Boost", 130, function()
	LP.Character.Humanoid.WalkSpeed = 100
end)

-- TELEPORT SPAM
createButton("Teleport Spam", 170, function()
	spawn(function()
		while wait(0.5) do
			for _,p in pairs(Players:GetPlayers()) do
				p.Character:MoveTo(LP.Character.HumanoidRootPart.Position)
			end
		end
	end)
end)

-- INFECTION UPGRADE
createButton("Super Infection", 210, function()
	spawn(function()
		while wait(1) do
			for _,p in pairs(Players:GetPlayers()) do
				local msg = Instance.new("Message")
				msg.Text = "c00lkidd DOMINATES!"
				msg.Parent = p.PlayerGui
				delay(5, function() msg:Destroy() end)
			end
		end
	end)
end)

-- COORDINATE TELEPORT
local coordInput = Instance.new("TextBox")
coordInput.PlaceholderText = "X,Y,Z"
coordInput.Size = UDim2.new(0, 180, 0, 30)
coordInput.Position = UDim2.new(0, 10, 0, 250)
coordInput.Parent = frame

createButton("Teleport to Coords", 290, function()
	local coords = {}
	for num in string.gmatch(coordInput.Text, "[^,]+") do
		table.insert(coords, tonumber(num))
	end
	if #coords == 3 then
		LP.Character.HumanoidRootPart.CFrame = CFrame.new(coords[1], coords[2], coords[3])
	end
end)

-- RESET BUTTON
createButton("Reset Game", 330, function()
	game:GetService("TeleportService"):Teleport(game.PlaceId)
end)
