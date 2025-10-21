-- AI Script Writer - Ultimate Cheat Hub v2.1
-- Fixed Generation Error

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Safe GUI creation
local function CreateSafeGUI()
    local success, result = pcall(function()
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "AIScriptWriter_" .. HttpService:GenerateGUID(false)
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.Parent = CoreGui
        return ScreenGui
    end)
    
    if success then
        return result
    else
        warn("Failed to create GUI: " .. tostring(result))
        return nil
    end
end

-- Main GUI
local ScreenGui = CreateSafeGUI()
if not ScreenGui then
    error("❌ Critical: Cannot create GUI")
    return
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 500)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Corner and Shadow
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 120, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🤖 AI Script Writer v2.1"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- Tab Buttons
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, -20, 0, 35)
TabButtons.Position = UDim2.new(0, 10, 0, 45)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = TabButtons

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -90)
ContentFrame.Position = UDim2.new(0, 10, 0, 85)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- AI Analysis Data
local AIData = {
    PlayerInfo = {
        Username = player.Name,
        DisplayName = player.DisplayName,
        AccountAge = player.AccountAge,
        UserId = player.UserId,
        Injector = "Unknown",
        GameTime = "00:00:00",
        FPS = 0
    },
    GameAnalysis = {
        GameName = "Analyzing...",
        PlaceId = game.PlaceId,
        ScriptsFound = 0,
        RemoteEvents = 0,
        ImportantObjects = {},
        SecurityLevel = "Unknown"
    },
    DetectedFeatures = {},
    ScriptLibrary = {}
}

-- Function to create glowing button with enhanced effects
local function CreateGlowingButton(name, parent, size, position)
    local Button = Instance.new("TextButton")
    Button.Size = size
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.AutoButtonColor = false
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(80, 120, 255)
    Stroke.Thickness = 1.5
    Stroke.Parent = Button
    
    local Glow = Instance.new("Frame")
    Glow.Size = UDim2.new(1, 12, 1, 12)
    Glow.Position = UDim2.new(0, -6, 0, -6)
    Glow.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
    Glow.BackgroundTransparency = 0.9
    Glow.BorderSizePixel = 0
    Glow.ZIndex = -1
    Glow.Parent = Button
    
    local GlowCorner = Instance.new("UICorner")
    GlowCorner.CornerRadius = UDim.new(0, 14)
    GlowCorner.Parent = Glow
    
    -- Pulse animation
    local pulseConnection
    local function startPulse()
        if pulseConnection then pulseConnection:Disconnect() end
        
        pulseConnection = RunService.Heartbeat:Connect(function()
            local time = tick()
            local pulse = math.sin(time * 5) * 0.1 + 0.9
            Glow.BackgroundTransparency = 0.7 + (pulse * 0.2)
        end)
    end
    
    -- Hover effects
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.3), {Thickness = 2.5}):Play()
        TweenService:Create(Glow, TweenInfo.new(0.3), {BackgroundTransparency = 0.7}):Play()
        startPulse()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 45)}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.3), {Thickness = 1.5}):Play()
        TweenService:Create(Glow, TweenInfo.new(0.3), {BackgroundTransparency = 0.9}):Play()
        if pulseConnection then
            pulseConnection:Disconnect()
        end
    end)
    
    Button.MouseButton1Down:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 80, 255)}):Play()
    end)
    
    Button.MouseButton1Up:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
    end)
    
    return Button
end

-- Function to create info widget
local function CreateInfoWidget(label, value, icon, parent)
    local Widget = Instance.new("Frame")
    Widget.Size = UDim2.new(1, -20, 0, 35)
    Widget.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Widget.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Widget
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(60, 60, 80)
    UIStroke.Thickness = 1
    UIStroke.Parent = Widget
    
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(0, 30, 1, 0)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = icon or "📄"
    IconLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.TextSize = 14
    IconLabel.Parent = Widget
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, -35, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = label
    Label.TextColor3 = Color3.fromRGB(200, 200, 220)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Widget
    
    local Value = Instance.new("TextLabel")
    Value.Size = UDim2.new(0.6, -10, 1, 0)
    Value.Position = UDim2.new(0.4, 10, 0, 0)
    Value.BackgroundTransparency = 1
    Value.Text = value
    Value.TextColor3 = Color3.fromRGB(100, 200, 255)
    Value.Font = Enum.Font.GothamBold
    Value.TextSize = 12
    Value.TextXAlignment = Enum.TextXAlignment.Right
    Value.Parent = Widget
    
    return Widget
end

-- Function to create tab
local tabs = {}
local function CreateTab(tabName, icon)
    local TabButton = CreateGlowingButton(icon .. " " .. tabName, TabButtons, UDim2.new(0, 120, 1, 0), UDim2.new(0, 0, 0, 0))
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.ScrollBarThickness = 6
    TabContent.ScrollBarImageColor3 = Color3.fromRGB(80, 120, 255)
    TabContent.Visible = false
    TabContent.Parent = ContentFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = TabContent
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 5)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    UIPadding.Parent = TabContent
    
    TabButton.MouseButton1Click:Connect(function()
        -- Hide all tabs
        for _, tabData in pairs(tabs) do
            tabData.Content.Visible = false
            TweenService:Create(tabData.Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            }):Play()
        end
        
        -- Show selected tab
        TabContent.Visible = true
        TweenService:Create(TabButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 70, 255)
        }):Play()
        
        -- Auto-adjust canvas size
        TabContent.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    end)
    
    tabs[tabName] = {Button = TabButton, Content = TabContent}
    return TabContent
end

-- Function to save script to file
local function SaveScriptToFile(scriptName, scriptContent)
    local success, result = pcall(function()
        -- Try to save to executor's workspace
        if writefile then
            -- Create directory if needed
            pcall(function()
                makefolder("AIScriptWriter")
            end)
            
            local fileName = "AIScriptWriter/" .. scriptName .. ".lua"
            writefile(fileName, scriptContent)
            return "✅ Saved to: " .. fileName
        else
            return "❌ File system not available"
        end
    end)
    
    if success then
        return result
    else
        return "❌ Save failed: " .. tostring(result)
    end
end

-- Enhanced game analysis
local function AnalyzeGame()
    AIData.GameAnalysis.ScriptsFound = 0
    AIData.GameAnalysis.RemoteEvents = 0
    AIData.GameAnalysis.ImportantObjects = {}
    AIData.DetectedFeatures = {}
    
    -- Get game name safely
    pcall(function()
        AIData.GameAnalysis.GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    
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
    
    -- Detect game features
    local features = {
        {Check = function() return workspace:FindFirstChild("Map") end, Name = "🌍 Custom Map System"},
        {Check = function() return game:GetService("Players").LocalPlayer:FindFirstChild("Backpack") end, Name = "🎒 Backpack System"},
        {Check = function() return workspace:FindFirstChild("Vehicles") end, Name = "🚗 Vehicle System"},
        {Check = function() return game:GetService("ReplicatedStorage"):FindFirstChild("Weapons") end, Name = "🔫 Weapon System"},
        {Check = function() return workspace:FindFirstChild("Terrain") end, Name = "🏔️ Terrain System"},
        {Check = function() return game:GetService("Lighting"):FindFirstChild("Sky") end, Name = "🌅 Sky System"}
    }
    
    for _, feature in pairs(features) do
        if pcall(feature.Check) and feature.Check() then
            table.insert(AIData.DetectedFeatures, feature.Name)
        end
    end
    
    -- Security analysis
    local securityChecks = 0
    if #AIData.GameAnalysis.ImportantObjects > 10 then securityChecks = securityChecks + 1 end
    if AIData.GameAnalysis.ScriptsFound > 50 then securityChecks = securityChecks + 1 end
    
    if securityChecks >= 2 then
        AIData.GameAnalysis.SecurityLevel = "🔒 High"
    elseif securityChecks >= 1 then
        AIData.GameAnalysis.SecurityLevel = "🟡 Medium"
    else
        AIData.GameAnalysis.SecurityLevel = "🟢 Low"
    end
end

-- Detect injector
local function DetectInjector()
    local injectors = {
        ["Synapse X"] = function() return syn and true end,
        ["ScriptWare"] = function() return secure_load and true end,
        ["Krnl"] = function() return Krnl and true end,
        ["Omega X"] = function() return Omega and true end,
        ["Electron"] = function() return getexecutorname and true end
    }
    
    for name, check in pairs(injectors) do
        if pcall(check) and check() then
            AIData.PlayerInfo.Injector = name
            return
        end
    end
    
    -- Fallback detection
    if getgenv then
        AIData.PlayerInfo.Injector = "Standard Executor"
    else
        AIData.PlayerInfo.Injector = "Unknown Environment"
    end
end

-- FPS counter
local function StartFPSCounter()
    local frames = 0
    local lastTime = tick()
    
    RunService.Heartbeat:Connect(function()
        frames = frames + 1
        local currentTime = tick()
        
        if currentTime - lastTime >= 1 then
            AIData.PlayerInfo.FPS = math.floor(frames / (currentTime - lastTime))
            frames = 0
            lastTime = currentTime
        end
    end)
end

-- Initialize systems
DetectInjector()
AnalyzeGame()
StartFPSCounter()

-- Create tabs
local Tab1 = CreateTab("Player Info", "👤")
local Tab2 = CreateTab("Auto Farm", "🤖")
local Tab3 = CreateTab("Player Mods", "⚡")
local Tab4 = CreateTab("ESP & Visuals", "👁️")
local Tab5 = CreateTab("Teleports", "📍")
local Tab6 = CreateTab("AI Generator", "🧠")
local Tab7 = CreateTab("Script Manager", "💾")

-- Populate Tab 1: Player Info
CreateInfoWidget("Username", AIData.PlayerInfo.Username, "👤", Tab1)
CreateInfoWidget("Display Name", AIData.PlayerInfo.DisplayName, "🏷️", Tab1)
CreateInfoWidget("User ID", tostring(AIData.PlayerInfo.UserId), "🆔", Tab1)
CreateInfoWidget("Account Age", tostring(AIData.PlayerInfo.AccountAge) .. " days", "📅", Tab1)
CreateInfoWidget("Injector", AIData.PlayerInfo.Injector, "⚡", Tab1)
CreateInfoWidget("FPS", tostring(AIData.PlayerInfo.FPS), "🎮", Tab1)
CreateInfoWidget("Game Time", AIData.PlayerInfo.GameTime, "⏰", Tab1)
CreateInfoWidget("Game Name", AIData.GameAnalysis.GameName, "🎯", Tab1)
CreateInfoWidget("Place ID", tostring(AIData.GameAnalysis.PlaceId), "🌐", Tab1)
CreateInfoWidget("Scripts Found", tostring(AIData.GameAnalysis.ScriptsFound), "📜", Tab1)
CreateInfoWidget("Remote Events", tostring(AIData.GameAnalysis.RemoteEvents), "📡", Tab1)
CreateInfoWidget("Security Level", AIData.GameAnalysis.SecurityLevel, "🛡️", Tab1)

-- Enhanced scripts with save functionality
local scriptsDatabase = {
    AutoFarm = {
        {
            Name = "💰 Auto Collect Cash",
            Description = "Automatically collects all nearby cash and items",
            Script = [[
                -- Auto Collect System
                local Players = game:GetService("Players")
                local player = Players.LocalPlayer
                
                while wait(0.3) do
                    pcall(function()
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("Part") and (obj.Name:lower():find("cash") or obj.Name:lower():find("money") or obj.Name:lower():find("coin")) then
                                firetouchinterest(player.Character.HumanoidRootPart, obj, 0)
                                firetouchinterest(player.Character.HumanoidRootPart, obj, 1)
                            end
                        end
                    end)
                end
            ]],
            Category = "AutoFarm"
        },
        {
            Name = "🌾 Auto Farm Resources",
            Description = "Automatically farms resources and items",
            Script = [[
                -- Auto Farm Resources
                local player = game.Players.LocalPlayer
                
                while wait(1) do
                    pcall(function()
                        -- Look for resource objects
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("Part") and (obj.Name:lower():find("ore") or obj.Name:lower():find("resource") or obj.Name:lower():find("tree")) then
                                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                    player.Character.HumanoidRootPart.CFrame = obj.CFrame
                                    wait(0.5)
                                end
                            end
                        end
                    end)
                end
            ]],
            Category = "AutoFarm"
        }
    },
    PlayerMods = {
        {
            Name = "🚀 Speed Hack",
            Description = "Increases player movement speed (WalkSpeed 50)",
            Script = [[
                game:GetService("RunService").Stepped:Connect(function()
                    pcall(function()
                        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.WalkSpeed = 50
                        end
                    end)
                end)
                print("Speed hack activated! WalkSpeed: 50")
            ]],
            Category = "PlayerMods"
        },
        {
            Name = "🦘 Jump Hack",
            Description = "Increases player jump power (JumpPower 100)",
            Script = [[
                game:GetService("RunService").Stepped:Connect(function()
                    pcall(function()
                        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.JumpPower = 100
                        end
                    end)
                end)
                print("Jump hack activated! JumpPower: 100")
            ]],
            Category = "PlayerMods"
        }
    },
    ESP = {
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
            ]],
            Category = "ESP"
        }
    }
}

-- Function to create script button with save option
local function CreateScriptButton(scriptData, parent, index)
    local Button = CreateGlowingButton(scriptData.Name, parent, UDim2.new(1, -10, 0, 45), UDim2.new(0, 5, 0, (index-1)*55))
    
    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -20, 0, 20)
    Description.Position = UDim2.new(0, 10, 0, 25)
    Description.BackgroundTransparency = 1
    Description.Text = scriptData.Description
    Description.TextColor3 = Color3.fromRGB(180, 180, 200)
    Description.Font = Enum.Font.Gotham
    Description.TextSize = 10
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            loadstring(scriptData.Script)()
        end)
        
        if success then
            print("✅ Script executed: " .. scriptData.Name)
        else
            warn("❌ Script error: " .. err)
        end
    end)
    
    -- Right click to save
    Button.MouseButton2Click:Connect(function()
        local saveResult = SaveScriptToFile(scriptData.Name, scriptData.Script)
        print(saveResult)
    end)
    
    return Button
end

-- Populate tabs with scripts
for category, scripts in pairs(scriptsDatabase) do
    local targetTab
    
    if category == "AutoFarm" then
        targetTab = Tab2
    elseif category == "PlayerMods" then
        targetTab = Tab3
    elseif category == "ESP" then
        targetTab = Tab4
    else
        targetTab = Tab2
    end
    
    for i, scriptData in pairs(scripts) do
        CreateScriptButton(scriptData, targetTab, i)
    end
end

-- FIXED AI Generator Function
local function GenerateAIScript()
    local gameName = AIData.GameAnalysis.GameName or "Unknown Game"
    local securityLevel = AIData.GameAnalysis.SecurityLevel or "Unknown"
    local remoteCount = AIData.GameAnalysis.RemoteEvents or 0
    
    local generatedScript = [[
-- 🤖 AI Generated Script for: ]] .. gameName .. [[
-- Generated by AI Script Writer v2.1
-- Security Level: ]] .. securityLevel .. [[
-- Remote Events Found: ]] .. tostring(remoteCount) .. [[
-- Generated on: ]] .. os.date("%Y-%m-%d %X") .. [[

print("🚀 AI Script activated for: ]] .. gameName .. [[")
print("🛡️ Detected Security: ]] .. securityLevel .. [[")
print("📡 Remote Events Found: ]] .. tostring(remoteCount) .. [[")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local function SafeExecute()
    -- Enhanced player stats
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 32
            humanoid.JumpPower = 55
            print("✅ Player stats enhanced")
        end
    end
    
    -- Auto collect system
    spawn(function()
        while wait(2) do
            pcall(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and (obj.Name:lower():find("cash") or obj.Name:lower():find("money") or obj.Name:lower():find("coin")) then
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            firetouchinterest(player.Character.HumanoidRootPart, obj, 0)
                            firetouchinterest(player.Character.HumanoidRootPart, obj, 1)
                        end
                    end
                end
            end)
        end
    end)
    
    -- Remote event analysis
    local importantRemotes = {}
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            if string.find(obj.Name:lower(), "money") or string.find(obj.Name:lower(), "cash") or string.find(obj.Name:lower(), "reward") then
                table.insert(importantRemotes, obj.Name)
                print("💰 Important Remote Found: " .. obj.Name)
            end
        end
    end
    
    print("🎯 AI Script fully loaded and running!")
end

-- Execute with error handling
local success, err = pcall(SafeExecute)
if not success then
    warn("❌ AI Script Error: " .. tostring(err))
else
    print("✅ AI Script executed successfully!")
end

return "AI Script Generation Complete"
]]

    return generatedScript
end

-- FIXED AI Generator Tab
local GenerateBtn = CreateGlowingButton("🤖 Generate Smart Script", Tab6, UDim2.new(1, -10, 0, 60), UDim2.new(0, 5, 0, 0))

GenerateBtn.MouseButton1Click:Connect(function()
    print("🧠 Starting AI Script Generation...")
    
    local success, generatedScript = pcall(GenerateAIScript)
    
    if success and generatedScript then
        -- Execute the generated script
        local execSuccess, execError = pcall(function()
            loadstring(generatedScript)()
        end)
        
        if execSuccess then
            print("✅ AI Script generated and executed successfully!")
            
            -- Save to file
            local saveResult = SaveScriptToFile("AI_Generated_Script", generatedScript)
            print(saveResult)
        else
            warn("❌ AI Script execution failed: " .. tostring(execError))
        end
    else
        warn("❌ AI Script generation failed: " .. tostring(generatedScript))
    end
end)

-- Script Manager Tab
local SaveAllBtn = CreateGlowingButton("💾 Save All Scripts to File", Tab7, UDim2.new(1, -10, 0, 50), UDim2.new(0, 5, 0, 0))

SaveAllBtn.MouseButton1Click:Connect(function()
    local allScripts = "-- AI Script Writer - All Scripts Collection\n-- Generated on: " .. os.date("%Y-%m-%d %X") .. "\n"
    allScripts = allScripts .. "-- Total Scripts: " .. tostring(#scriptsDatabase.AutoFarm + #scriptsDatabase.PlayerMods + #scriptsDatabase.ESP) .. "\n\n"
    
    for category, scripts in pairs(scriptsDatabase) do
        allScripts = allScripts .. "-- " .. category .. " Scripts (" .. #scripts .. " total) --\n\n"
        for i, scriptData in pairs(scripts) do
            allScripts = allScripts .. "-- " .. scriptData.Name .. "\n"
            allScripts = allScripts .. "-- Description: " .. scriptData.Description .. "\n"
            allScripts = allScripts .. scriptData.Script .. "\n\n"
        end
    end
    
    local result = SaveScriptToFile("All_Scripts_Collection", allScripts)
    print(result)
end)

-- Auto-refresh system
local lastUpdate = tick()
local function AutoRefresh()
    while wait(1) do
        AIData.PlayerInfo.GameTime = os.date("%X")
        
        -- Update analysis every 30 seconds
        if tick() - lastUpdate > 30 then
            AnalyzeGame()
            lastUpdate = tick()
        end
    end
end

-- Draggable GUI with bounds checking
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    local newX = startPos.X.Offset + delta.X
    local newY = startPos.Y.Offset + delta.Y
    
    -- Keep within screen bounds
    newX = math.clamp(newX, 0, workspace.CurrentCamera.ViewportSize.X - MainFrame.AbsoluteSize.X)
    newY = math.clamp(newY, 0, workspace.CurrentCamera.ViewportSize.Y - MainFrame.AbsoluteSize.Y)
    
    MainFrame.Position = UDim2.new(0, newX, 0, newY)
end

TitleBar.InputBegan:Connect(function(input)
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

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Start systems
spawn(AutoRefresh)

-- Activate first tab
if tabs["Player Info"] then
    tabs["Player Info"].Button.MouseButton1Click()
end

-- Update UI sizes
for _, tabData in pairs(tabs) do
    if tabData.Content then
        tabData.Content.CanvasSize = UDim2.new(0, 0, 0, tabData.Content.UIListLayout.AbsoluteContentSize.Y)
    end
end

print("🎉 AI Script Writer v2.1 loaded successfully!")
print("🔍 Initial Analysis Complete:")
print("   Game: " .. AIData.GameAnalysis.GameName)
print("   Security: " .. AIData.GameAnalysis.SecurityLevel)
print("   Injector: " .. AIData.PlayerInfo.Injector)

-- Count total scripts
local totalScripts = 0
for category, scripts in pairs(scriptsDatabase) do
    totalScripts = totalScripts + #scripts
end
print("   Scripts Ready: " .. tostring(totalScripts))
