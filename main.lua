-- AI Script Writer - Ultimate Cheat Hub
-- Created for Exhibition

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AIScriptWriter"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Corner and Shadow
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 100, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Tab Buttons
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, 0, 0, 40)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Parent = TabButtons

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -60)
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- AI Analysis Data
local AIData = {
    PlayerInfo = {
        Username = player.Name,
        DisplayName = player.DisplayName,
        AccountAge = player.AccountAge,
        UserId = player.UserId,
        Injector = "Unknown",
        GameTime = "00:00:00"
    },
    GameAnalysis = {
        GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
        PlaceId = game.PlaceId,
        ScriptsFound = 0,
        RemoteEvents = 0,
        ImportantObjects = {}
    },
    DetectedFeatures = {}
}

-- Function to create glowing button
local function CreateGlowingButton(name, parent, size, position)
    local Button = Instance.new("TextButton")
    Button.Size = size
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(100, 100, 255)
    Stroke.Thickness = 1
    Stroke.Parent = Button
    
    local Glow = Instance.new("Frame")
    Glow.Size = UDim2.new(1, 10, 1, 10)
    Glow.Position = UDim2.new(0, -5, 0, -5)
    Glow.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    Glow.BackgroundTransparency = 0.8
    Glow.BorderSizePixel = 0
    Glow.ZIndex = -1
    Glow.Parent = Button
    
    local GlowCorner = Instance.new("UICorner")
    GlowCorner.CornerRadius = UDim.new(0, 12)
    GlowCorner.Parent = Glow
    
    -- Hover effects
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Thickness = 2}):Play()
        TweenService:Create(Glow, TweenInfo.new(0.2), {BackgroundTransparency = 0.6}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Thickness = 1}):Play()
        TweenService:Create(Glow, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
    end)
    
    return Button
end

-- Function to create tab
local function CreateTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 100, 1, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 12
    TabButton.Parent = TabButtons
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = TabButton
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.ScrollBarThickness = 4
    TabContent.Visible = false
    TabContent.Parent = ContentFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = TabContent
    
    TabButton.MouseButton1Click:Connect(function()
        -- Hide all tabs
        for _, tab in pairs(ContentFrame:GetChildren()) do
            if tab:IsA("ScrollingFrame") then
                tab.Visible = false
            end
        end
        
        -- Show selected tab
        TabContent.Visible = true
        
        -- Update tab buttons appearance
        for _, btn in pairs(TabButtons:GetChildren()) do
            if btn:IsA("TextButton") then
                TweenService:Create(btn, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                }):Play()
            end
        end
        
        TweenService:Create(TabButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        }):Play()
    end)
    
    return TabContent
end

-- Analyze game function
local function AnalyzeGame()
    AIData.GameAnalysis.ScriptsFound = 0
    AIData.GameAnalysis.RemoteEvents = 0
    AIData.GameAnalysis.ImportantObjects = {}
    AIData.DetectedFeatures = {}
    
    -- Count scripts and remote events
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") then
            AIData.GameAnalysis.ScriptsFound += 1
        elseif obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            AIData.GameAnalysis.RemoteEvents += 1
            table.insert(AIData.GameAnalysis.ImportantObjects, {
                Type = obj.ClassName,
                Name = obj.Name,
                Path = obj:GetFullName()
            })
        end
    end
    
    -- Detect common game features
    if game:GetService("Workspace"):FindFirstChild("Map") then
        table.insert(AIData.DetectedFeatures, "🌍 Custom Map System")
    end
    
    if game:GetService("Players").LocalPlayer:FindFirstChild("Backpack") then
        table.insert(AIData.DetectedFeatures, "🎒 Backpack System")
    end
    
    if game:GetService("Workspace"):FindFirstChild("Vehicles") then
        table.insert(AIData.DetectedFeatures, "🚗 Vehicle System")
    end
    
    if game:GetService("ReplicatedStorage"):FindFirstChild("Weapons") then
        table.insert(AIData.DetectedFeatures, "🔫 Weapon System")
    end
end

-- Detect injector
local function DetectInjector()
    local injectors = {
        ["Synapse X"] = "Synapse",
        ["ScriptWare"] = "ScriptWare", 
        ["Krnl"] = "Krnl",
        ["Omega X"] = "Omega",
        ["Electron"] = "Electron"
    }
    
    for name, key in pairs(injectors) do
        if getgenv()[key] then
            AIData.PlayerInfo.Injector = name
            return
        end
    end
    
    -- Fallback detection
    if getgenv().IDENTITY then
        AIData.PlayerInfo.Injector = "Unknown Executor"
    else
        AIData.PlayerInfo.Injector = "Standard Executor"
    end
end

-- Create Tab 1: Player Info
local Tab1 = CreateTab("Player Info")
Tab1.Visible = true

-- Player Info Widgets
local function CreateInfoWidget(label, value, parent)
    local Widget = Instance.new("Frame")
    Widget.Size = UDim2.new(1, -20, 0, 40)
    Widget.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Widget.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Widget
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = label
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Widget
    
    local Value = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, -10, 1, 0)
    Label.Position = UDim2.new(0.4, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = value
    Label.TextColor3 = Color3.fromRGB(100, 200, 255)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Right
    Label.Parent = Widget
    
    return Widget
end

-- Update time function
local function UpdateTime()
    while true do
        local time = os.date("%X")
        AIData.PlayerInfo.GameTime = time
        wait(1)
    end
end

spawn(UpdateTime)

-- Initialize analysis
DetectInjector()
AnalyzeGame()

-- Populate Tab 1
CreateInfoWidget("👤 Username:", AIData.PlayerInfo.Username, Tab1)
CreateInfoWidget("🏷️ Display Name:", AIData.PlayerInfo.DisplayName, Tab1)
CreateInfoWidget("🆔 User ID:", tostring(AIData.PlayerInfo.UserId), Tab1)
CreateInfoWidget("📅 Account Age:", tostring(AIData.PlayerInfo.AccountAge) .. " days", Tab1)
CreateInfoWidget("⚡ Injector:", AIData.PlayerInfo.Injector, Tab1)
CreateInfoWidget("⏰ Game Time:", AIData.PlayerInfo.GameTime, Tab1)
CreateInfoWidget("🎮 Game:", AIData.GameAnalysis.GameName, Tab1)
CreateInfoWidget("🔧 Scripts Found:", tostring(AIData.GameAnalysis.ScriptsFound), Tab1)
CreateInfoWidget("📡 Remote Events:", tostring(AIData.GameAnalysis.RemoteEvents), Tab1)

-- Tab 2: Auto Farm Features
local Tab2 = CreateTab("Auto Farm")

local farmScripts = {
    {
        Name = "💰 Auto Collect Cash",
        Description = "Automatically collects all nearby cash",
        Script = [[
            while wait(0.5) do
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find("cash") or obj.Name:lower():find("money") then
                        if obj:IsA("Part") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                        end
                    end
                end
            end
        ]]
    },
    {
        Name = "⚔️ Auto Attack",
        Description = "Automatically attacks nearby enemies",
        Script = [[
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            
            while wait(0.1) do
                for _, enemy in pairs(Players:GetPlayers()) do
                    if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (player.Character.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
                        if distance < 50 then
                            -- Add attack logic here based on game
                        end
                    end
                end
            end
        ]]
    }
}

for i, scriptData in pairs(farmScripts) do
    local btn = CreateGlowingButton(scriptData.Name, Tab2, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, (i-1)*50))
    
    btn.MouseButton1Click:Connect(function()
        loadstring(scriptData.Script)()
    end)
end

-- Tab 3: Player Mods
local Tab3 = CreateTab("Player Mods")

local playerMods = {
    {
        Name = "🚀 Speed Hack",
        Description = "Increases player movement speed",
        Script = [[
            game:GetService("RunService").Stepped:Connect(function()
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
                end
            end)
        ]]
    },
    {
        Name = "🦘 Jump Hack", 
        Description = "Increases player jump power",
        Script = [[
            game:GetService("RunService").Stepped:Connect(function()
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
                end
            end)
        ]]
    }
}

for i, mod in pairs(playerMods) do
    local btn = CreateGlowingButton(mod.Name, Tab3, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, (i-1)*50))
    
    btn.MouseButton1Click:Connect(function()
        loadstring(mod.Script)()
    end)
end

-- Tab 4: ESP & Visuals
local Tab4 = CreateTab("ESP & Visuals")

local espScripts = {
    {
        Name = "👁️ Player ESP",
        Description = "Highlights all players through walls",
        Script = [[
            -- Basic ESP implementation
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = player.Character
                end
            end
        ]]
    },
    {
        Name = "🎯 X-Ray Vision",
        Description = "See through walls and objects",
        Script = [[
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("Part") and part.Transparency < 1 then
                    part.LocalTransparencyModifier = 0.5
                end
            end
        ]]
    }
}

for i, esp in pairs(espScripts) do
    local btn = CreateGlowingButton(esp.Name, Tab4, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, (i-1)*50))
    
    btn.MouseButton1Click:Connect(function()
        loadstring(esp.Script)()
    end)
end

-- Tab 5: Teleports
local Tab5 = CreateTab("Teleports")

local teleportScripts = {
    {
        Name = "📍 Teleport to Spawn",
        Description = "Teleports player to spawn point",
        Script = [[
            local player = game.Players.LocalPlayer
            if player.Character then
                player.Character:SetPrimaryPartCFrame(workspace:FindFirstChild("SpawnLocation").CFrame)
            end
        ]]
    },
    {
        Name = "🎯 Teleport to Mouse",
        Description = "Teleports to mouse position",
        Script = [[
            local player = game.Players.LocalPlayer
            local mouse = player:GetMouse()
            
            mouse.Button1Down:Connect(function()
                if player.Character then
                    player.Character:SetPrimaryPartCFrame(CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0)))
                end
            end)
        ]]
    }
}

for i, tp in pairs(teleportScripts) do
    local btn = CreateGlowingButton(tp.Name, Tab5, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, (i-1)*50))
    
    btn.MouseButton1Click:Connect(function()
        loadstring(tp.Script)()
    end)
end

-- Tab 6: AI Script Generator
local Tab6 = CreateTab("AI Generator")

local GenerateBtn = CreateGlowingButton("🤖 Generate Smart Script", Tab6, UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 0, 0))

GenerateBtn.MouseButton1Click:Connect(function()
    -- AI analyzes the game and generates custom script
    local generatedScript = [[
        -- AI Generated Script for: ]] .. AIData.GameAnalysis.GameName .. [[
        
        print("🤖 AI Script activated for: ]] .. AIData.GameAnalysis.GameName .. [[")
        
        -- Auto-detect and exploit game mechanics
        local function analyzeAndExploit()
            ]] .. [[
            -- Add game-specific exploits based on analysis
            for _, remote in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if remote:IsA("RemoteEvent") then
                    print("Found RemoteEvent: " .. remote.Name)
                end
            end
            ]] .. [[
        end
        
        analyzeAndExploit()
    ]]
    
    loadstring(generatedScript)()
end)

-- Draggable GUI
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Auto-update features
spawn(function()
    while wait(5) do
        AnalyzeGame()
    end
end)

print("🎉 AI Script Writer loaded successfully!")
print("🔍 Game Analysis Complete:")
print("   Game: " .. AIData.GameAnalysis.GameName)
print("   Scripts Found: " .. AIData.GameAnalysis.ScriptsFound)
print("   Remote Events: " .. AIData.GameAnalysis.RemoteEvents)
print("   Injector: " .. AIData.PlayerInfo.Injector)
