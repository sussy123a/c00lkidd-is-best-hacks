local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TPS = game:GetService("TeleportService")
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()

-- GUI SETUP
local gui = Instance.new("ScreenGui")
gui.Parent = LP:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 450)
frame.Position = UDim2.new(0, 20, 0.5, -225)
frame.AnchorPoint = Vector2.new(0, 0.5)
frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
frame.Parent = gui

-- TITLE BAR
local title = Instance.new("TextLabel")
title.Text = "c00lgui v3 by 3d3x3d3x"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.TextColor3 = Color3.new(1, 0.3, 0.3)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

-- Add text outline
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.new(1, 1, 1)
titleStroke.Thickness = 2
titleStroke.Parent = title

-- DRAGGING SYSTEM
local dragging, dragInput, dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- STYLISH ELEMENTS
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.new(1, 0, 0)
uiStroke.Thickness = 2
uiStroke.Parent = frame

local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    btn.TextColor3 = Color3.new(1, 0.4, 0.4)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = frame
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.new(1, 0, 0)
    btnStroke.Thickness = 1
    btnStroke.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- FLY SYSTEM
local flying = false
createButton("🚀 Toggle Flight", 40, function()
    flying = not flying
    local humanoid = LP.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = flying
        spawn(function()
            while flying and wait() do
                humanoid.RootPart.Velocity = Vector3.new()
                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    humanoid.RootPart.CFrame *= CFrame.new(0,0,-2)
                end
                if UIS:IsKeyDown(Enum.KeyCode.S) then
                    humanoid.RootPart.CFrame *= CFrame.new(0,0,2)
                end
            end
        end)
    end
end)

-- TELEPORT GUN
createButton("🔫 Teleport Gun", 85, function()
    Mouse.Button1Down:Connect(function()
        if Mouse.Target then
            LP.Character:MoveTo(Mouse.Hit.Position + Vector3.new(0,5,0))
        end
    end)
end)

-- NO CLIP
createButton("👻 Toggle Noclip", 130, function()
    LP.Character.Humanoid:ChangeState(11)
end)

-- SPEED HACK
createButton("⚡ Speed Hack (100)", 175, function()
    LP.Character.Humanoid.WalkSpeed = 100
end)

-- PLAYER TELEPORT SPAM
createButton("🌀 Teleport Spam", 220, function()
    spawn(function()
        while wait(0.5) do
            for _,p in pairs(Players:GetPlayers()) do
                if p ~= LP then
                    p.Character:MoveTo(LP.Character.HumanoidRootPart.Position)
                end
            end
        end
    end)
end)

-- DECAL SPAMMER
createButton("🌌 c00lkidd Decal Spam", 265, function()
    spawn(function()
        local decalId = "rbxassetid://157772998" -- Replace with actual ID
        while wait(0.1) do
            for _,part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    local newDecal = Instance.new("Decal")
                    newDecal.Texture = decalId
                    newDecal.Color3 = Color3.new(1, 0, 0)
                    newDecal.Parent = part
                end
            end
        end
    end)
end)

-- MESSAGE INFECTION
createButton("💀 Infect Chat", 310, function()
    spawn(function()
        while wait(1) do
            for _,p in pairs(Players:GetPlayers()) do
                local msg = Instance.new("Message")
                msg.Text = "c00lkidd IS BACK! 👑"
                msg.FontSize = Enum.FontSize.Size48
                msg.TextColor3 = Color3.new(1, 0, 0)
                msg.Parent = p.PlayerGui
                delay(3, function() msg:Destroy() end)
            end
        end
    end)
end)

-- COORDINATE TELEPORT
local coordInput = Instance.new("TextBox")
coordInput.PlaceholderText = "Enter X,Y,Z"
coordInput.Size = UDim2.new(0.9, 0, 0, 30)
coordInput.Position = UDim2.new(0.05, 0, 0, 355)
coordInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
coordInput.TextColor3 = Color3.new(1, 0.5, 0.5)
coordInput.Font = Enum.Font.Gotham
coordInput.Parent = frame

createButton("📍 Teleport to Coords", 395, function()
    local coords = {}
    for num in string.gmatch(coordInput.Text, "[^,]+") do
        table.insert(coords, tonumber(num))
    end
    if #coords == 3 then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(coords[1], coords[2], coords[3])
    end
end)

-- RESET BUTTON
createButton("🔄 Reset Game", 440, function()
    TPS:Teleport(game.PlaceId)
end)
