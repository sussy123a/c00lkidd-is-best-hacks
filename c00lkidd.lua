local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()

local gui = Instance.new("ScreenGui")
gui.Parent = LP:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 400)
frame.Position = UDim2.new(0.5, -130, 0.9, -200) -- Bottom center position
frame.AnchorPoint = Vector2.new(0.5, 1)
frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
frame.Parent = gui

-- Title Bar with dragging
local title = Instance.new("TextLabel")
title.Text = "c00lgui v3.1 by 3d3x3d3x"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.TextColor3 = Color3.new(1, 0.4, 0.4)
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Dragging System
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

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    btn.TextColor3 = Color3.new(1, 0.5, 0.5)
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = frame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Updated Decal Spammer with actual ID
createButton("🔥 Activate Decal Spam", 40, function()
    spawn(function()
        local decalId = "rbxassetid://157772998" -- c00lkidd decal
        while wait(0.1) do
            for _,part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    for _,face in pairs(Enum.NormalId:GetEnumItems()) do
                        local decal = Instance.new("Decal")
                        decal.Texture = decalId
                        decal.Color3 = Color3.new(1, 0, 0)
                        decal.Face = face
                        decal.Parent = part
                    end
                end
            end
        end
    end)
end)

-- Other functions (keep previous implementations)
createButton("🚀 Flight Mode", 85, function() end)
createButton("👻 Noclip Toggle", 130, function() end)
createButton("⚡ Speed Hack", 175, function() end)
createButton("🌀 Player TP Spam", 220, function() end)
createButton("💀 Infect Chat", 265, function() end)
createButton("📍 TP to Coords", 310, function() end)
createButton("🔄 Reset Game", 355, function() end)

-- Visual improvements
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.new(1, 0, 0)
uiStroke.Thickness = 2
uiStroke.Parent = frame

for _,child in pairs(frame:GetChildren()) do
    if child:IsA("TextButton") then
        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Color3.new(1, 0.5, 0.5)
        btnStroke.Thickness = 1
        btnStroke.Parent = child
    end
end
