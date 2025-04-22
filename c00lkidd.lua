local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TPS = game:GetService("TeleportService")
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()

-- GUI SETUP
local gui = Instance.new("ScreenGui")
gui.Name = "c00lgui_v3"
gui.Parent = LP:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 500)
frame.Position = UDim2.new(0.5, -130, 0.5, -250) -- Centered position
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
frame.Parent = gui

-- TITLE BAR
local title = Instance.new("TextLabel")
title.Text = "c00lgui v3 by 3d3x3d3x"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.TextColor3 = Color3.new(1, 0.4, 0.4)
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextStrokeTransparency = 0.5
title.Parent = frame

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

-- VISUAL STYLING
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.new(1, 0, 0)
uiStroke.Thickness = 3
uiStroke.Parent = frame

local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    btn.TextColor3 = Color3.new(1, 0.5, 0.5)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.TextStrokeTransparency = 0.7
    btn.Parent = frame
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.new(1, 0, 0)
    btnStroke.Thickness = 1.5
    btnStroke.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- FLIGHT SYSTEM
local flying = false
createButton("🚀 Toggle Flight", 45, function()
    flying = not flying
    local humanoid = LP.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = flying
        spawn(function()
            local root = humanoid.RootPart
            while flying and task.wait() do
                root.Velocity = Vector3.new()
                local moveVec = Vector3.new()
                
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec += root.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec -= root.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec += root.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec -= root.CFrame.RightVector end
                
                root.Velocity = moveVec * 100
            end
        end)
    end
end)

-- TELEPORT GUN
createButton("🔫 Teleport Gun", 95, function()
    Mouse.Button1Down:Connect(function()
        if Mouse.Target then
            LP.Character:MoveTo(Mouse.Hit.Position + Vector3.new(0, 5, 0))
        end
    end)
end)

-- NO CLIP TOGGLE
createButton("👻 Toggle Noclip", 145, function()
    local noclipActive = false
    noclipActive = not noclipActive
    LP.Character.Humanoid:ChangeState(11)
    spawn(function()
        while noclipActive do
            task.wait()
            LP.Character.Humanoid:ChangeState(11)
        end
    end)
end)

-- SPEED HACK
createButton("⚡ Speed Hack (150)", 195, function()
    LP.Character.Humanoid.WalkSpeed = 150
end)

-- PLAYER TELEPORT SPAM
createButton("🌀 Teleport Spam", 245, function()
    spawn(function()
        while task.wait(0.3) do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP then
                    p.Character:MoveTo(LP.Character.HumanoidRootPart.Position)
                end
            end
        end
    end)
end)

-- DECAL SPAMMER v2
createButton("🌌 c00lkidd Decal Spam", 295, function()
    spawn(function()
        local decalId = "rbxassetid://157772998" -- Replace with actual ID
        while task.wait(0.05) do
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    for face = 0, 5 do
                        local decal = Instance.new("Decal")
                        decal.Texture = decalId
                        decal.Color3 = Color3.new(1, 0, 0)
                        decal.Face = Enum.NormalId.FromNormalId(face)
                        decal.Parent = part
                    end
                end
            end
        end
    end)
end)

-- MESSAGE INFECTION
createButton("💀 Global Infection", 345, function()
    spawn(function()
        while task.wait(0.5) do
            for _, p in pairs(Players:GetPlayers()) do
                local msgGui = Instance.new("ScreenGui")
                local txt = Instance.new("TextLabel")
                txt.Text = "c00lkidd DOMINATES! 💀"
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.FontSize = Enum.FontSize.Size60
                txt.TextColor3 = Color3.new(1, 0, 0)
                txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                txt.TextStrokeTransparency = 0
                txt.Parent = msgGui
                msgGui.Parent = p.PlayerGui
                task.delay(5, function() msgGui:Destroy() end)
            end
        end
    end)
end)

-- COORDINATE TELEPORT
local coordInput = Instance.new("TextBox")
coordInput.PlaceholderText = "X, Y, Z"
coordInput.Size = UDim2.new(0.9, 0, 0, 35)
coordInput.Position = UDim2.new(0.05, 0, 0, 395)
coordInput.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
coordInput.TextColor3 = Color3.new(1, 0.5, 0.5)
coordInput.Font = Enum.Font.Gotham
coordInput.TextSize = 14
coordInput.Parent = frame

createButton("📍 Teleport to Coords", 445, function()
    local coords = {}
    for num in string.gmatch(coordInput.Text, "[^,]+") do
        table.insert(coords, tonumber(num:match("%d+")))
    end
    if #coords == 3 then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(coords[1], coords[2], coords[3])
    end
end)

-- RESET BUTTON
createButton("🔄 Reset Session", 495, function()
    TPS:Teleport(game.PlaceId)
end)
