local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()

local gui = Instance.new("ScreenGui")
gui.Parent = LP:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 400)
frame.Position = UDim2.new(0, 10, 0.5, -200)
frame.AnchorPoint = Vector2.new(0, 0.5)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.Parent = gui

-- Custom Title Bar
local title = Instance.new("TextLabel")
title.Text = "c00lgui v3 by 3d3x3d3x"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.TextColor3 = Color3.new(1, 0, 0)
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Make GUI Draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                             startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

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
        update(input)
    end
end)

-- Stylish Elements
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.new(1, 0, 0)
uiStroke.Thickness = 2
uiStroke.Parent = frame

local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    btn.TextColor3 = Color3.new(1, 0, 0)
    btn.Font = Enum.Font.Gotham
    btn.Parent = frame
    
    local btnStroke = uiStroke:Clone()
    btnStroke.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- DECAL SPAM SYSTEM
createButton("Activate Decal Spam", 40, function()
    spawn(function()
        while wait(0.2) do
            for _,part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    local decal = Instance.new("Decal")
                    decal.Texture = "rbxassetid://157772998"
                    decal.Face = Enum.NormalId.Top
                    decal.Color3 = Color3.new(1, 0, 0)
                    decal.Parent = part
                end
            end
        end
    end)
end)

-- Existing features from previous version
createButton("Fly Hack (W/S)", 80, function() end)  -- Keep previous fly code
createButton("Teleport Gun", 120, function() end)    -- Keep previous teleport code
createButton("Noclip Toggle", 160, function() end)
createButton("Speed Hack", 200, function() end)
createButton("Player Teleport Spam", 240, function() end)
createButton("Super Infection", 280, function() end)
createButton("Reset Game", 360, function() end)

-- Coordinate input moved below
local coordInput = Instance.new("TextBox")
coordInput.PlaceholderText = "X,Y,Z"
coordInput.Size = UDim2.new(0.9, 0, 0, 30)
coordInput.Position = UDim2.new(0.05, 0, 0, 320)
coordInput.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
coordInput.TextColor3 = Color3.new(1, 0, 0)
coordInput.Parent = frame
