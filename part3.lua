-- AI Script Writer - Ultimate Power v3.0
-- Part 3: Main GUI & Execution System

local CoreSystems = loadstring(game:HttpGet("https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/part1.lua"))()
local AIGenerator = loadstring(game:HttpGet("https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/part2.lua"))()

-- Main GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AIScriptWriterPro"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Container
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 800, 0, 600)
MainContainer.Position = UDim2.new(0.5, -400, 0.5, -300)
MainContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainContainer.BackgroundTransparency = 0.05
MainContainer.BorderSizePixel = 0
MainContainer.Parent = ScreenGui

-- Modern Glass Effect
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainContainer

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 120, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainContainer

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
Header.BorderSizePixel = 0
Header.Parent = MainContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🤖 AI Script Writer Pro v3.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 0, 20)
Title.Position = UDim2.new(0, 20, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "Advanced AI-Powered Script Generation"
Title.TextColor3 = Color3.fromRGB(180, 180, 255)
Title.Font = Enum.Font.Gotham
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Control Buttons
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 15)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = Header

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 15)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 180, 60)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = Header

-- Tab System
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.new(0, 10, 0, 70)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainContainer

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 8)
TabListLayout.Parent = TabContainer

-- Content Area
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -120)
ContentFrame.Position = UDim2.new(0, 10, 0, 120)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainContainer

-- Tab Management
local Tabs = {}
local CurrentTab = nil

-- Function to create modern tab
local function CreateTab(tabName, icon, contentCreator)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 140, 1, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    TabButton.Text = icon .. " " .. tabName
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 13
    TabButton.Parent = TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.ScrollBarThickness = 6
    TabContent.ScrollBarImageColor3 = Color3.fromRGB(80, 120, 255)
    TabContent.Visible = false
    TabContent.Parent = ContentFrame
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 12)
    ContentLayout.Parent = TabContent
    
    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.PaddingTop = UDim.new(0, 10)
    ContentPadding.PaddingLeft = UDim.new(0, 10)
    ContentPadding.PaddingRight = UDim.new(0, 10)
    ContentPadding.Parent = TabContent
    
    -- Create tab content
    if contentCreator then
        contentCreator(TabContent)
    end
    
    TabButton.MouseButton1Click:Connect(function()
        -- Hide all tabs
        for _, tabData in pairs(Tabs) do
            tabData.Content.Visible = false
            TweenService:Create(tabData.Button, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            }):Play()
        end
        
        -- Show selected tab
        TabContent.Visible = true
        TweenService:Create(TabButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(60, 80, 255)
        }):Play()
        
        CurrentTab = tabName
        TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
    end)
    
    Tabs[tabName] = {
        Button = TabButton,
        Content = TabContent,
        Name = tabName
    }
    
    return TabContent
end

-- Function to create modern card
local function CreateCard(title, description, parent, size, position)
    local Card = Instance.new("Frame")
    Card.Size = size or UDim2.new(1, -20, 0, 80)
    Card.Position = position or UDim2.new(0, 10, 0, 0)
    Card.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Card.Parent = parent
    
    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 12)
    CardCorner.Parent = Card
    
    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Color3.fromRGB(60, 80, 255)
    CardStroke.Thickness = 1
    CardStroke.Parent = Card
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 30)
    TitleLabel.Position = UDim2.new(0, 15, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Card
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 40)
    DescLabel.Position = UDim2.new(0, 15, 0, 40)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 12
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.TextWrapped = true
    DescLabel.Parent = Card
    
    return Card
end

-- Function to create modern button
local function CreateButton(text, parent, size, position, callback)
    local Button = Instance.new("TextButton")
    Button.Size = size or UDim2.new(1, -20, 0, 45)
    Button.Position = position or UDim2.new(0, 10, 0, 0)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.Parent = parent
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = Button
    
    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Color3.fromRGB(80, 120, 255)
    ButtonStroke.Thickness = 1.5
    ButtonStroke.Parent = Button
    
    -- Hover effects
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 80, 255)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {
            Thickness = 2.5
        }):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {
            Thickness = 1.5
        }):Play()
    end)
    
    if callback then
        Button.MouseButton1Click:Connect(callback)
    end
    
    return Button
end

-- Create Dashboard Tab
CreateTab("Dashboard", "📊", function(content)
    -- System Status Card
    local StatusCard = CreateCard("System Status", "AI Script Writer Pro v3.0 - All Systems Operational", content, UDim2.new(1, -20, 0, 100))
    
    -- Stats Grid
    local StatsGrid = Instance.new("Frame")
    StatsGrid.Size = UDim2.new(1, -20, 0, 100)
    StatsGrid.Position = UDim2.new(0, 10, 0, 120)
    StatsGrid.BackgroundTransparency = 1
    StatsGrid.Parent = content
    
    local GridLayout = Instance.new("UIGridLayout")
    GridLayout.CellSize = UDim2.new(0.5, -10, 0, 45)
    GridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
    GridLayout.Parent = StatsGrid
    
    local stats = {
        {"🛡️ Security Level", tostring(CoreSystems.GameAnalysis.DetectionLevel)},
        {"🎯 Exploitable Points", tostring(#CoreSystems.GameAnalysis.ExploitablePoints)},
        {"📡 Remote Events", tostring(#CoreSystems.GameAnalysis.RemoteEvents)},
        {"🔧 Active Bypasses", tostring(#CoreSystems.SecurityBypass.ActiveBypasses)}
    }
    
    for _, stat in pairs(stats) do
        local StatCard = Instance.new("Frame")
        StatCard.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        StatCard.Parent = StatsGrid
        
        local StatCorner = Instance.new("UICorner")
        StatCorner.CornerRadius = UDim.new(0, 8)
        StatCorner.Parent = StatCard
        
        local StatName = Instance.new("TextLabel")
        StatName.Size = UDim2.new(1, -10, 0, 20)
        StatName.Position = UDim2.new(0, 10, 0, 5)
        StatName.BackgroundTransparency = 1
        StatName.Text = stat[1]
        StatName.TextColor3 = Color3.fromRGB(180, 180, 220)
        StatName.Font = Enum.Font.Gotham
        StatName.TextSize = 11
        StatName.TextXAlignment = Enum.TextXAlignment.Left
        StatName.Parent = StatCard
        
        local StatValue = Instance.new("TextLabel")
        StatValue.Size = UDim2.new(1, -10, 0, 20)
        StatValue.Position = UDim2.new(0, 10, 0, 25)
        StatValue.BackgroundTransparency = 1
        StatValue.Text = stat[2]
        StatValue.TextColor3 = Color3.fromRGB(100, 200, 255)
        StatValue.Font = Enum.Font.GothamBold
        StatValue.TextSize = 14
        StatValue.TextXAlignment = Enum.TextXAlignment.Left
        StatValue.Parent = StatCard
    end
    
    -- Quick Actions
    CreateButton("🔄 Refresh Analysis", content, UDim2.new(1, -20, 0, 45), UDim2.new(0, 10, 0, 240), function()
        CoreSystems.DetectSecuritySystems()
        CoreSystems.AnalyzeGameStructure()
        print("✅ System analysis refreshed!")
    end)
    
    CreateButton("🚀 Generate Universal Script", content, UDim2.new(1, -20, 0, 45), UDim2.new(0, 10, 0, 300), function()
        local script = AIGenerator.GenerateScriptWithGUI("AutoFarm", {
            FARM_DELAY = 0.5,
            FARM_SPEED = 2,
            DETECTION_RANGE = 50,
            SAFETY_CHECKS = true,
            ANTI_ANTICHEAT = true
        })
        
        if script then
            loadstring(script)()
            print("✅ Universal script generated and executed!")
        end
    end)
end)

-- Create Script Generator Tab
CreateTab("AI Generator", "🤖", function(content)
    local ScriptTypeCard = CreateCard("Script Type Selection", "Choose the type of script to generate with AI", content, UDim2.new(1, -20, 0, 100))
    
    local scriptTypes = {
        {"Auto Farm", "🌾", "Automated resource collection system"},
        {"Player Hacks", "⚡", "Speed, fly, and other player modifications"}, 
        {"ESP & Visuals", "👁️", "Player and item highlighting systems"},
        {"Combat System", "🔫", "Auto-aim and combat enhancements"},
        {"Teleport System", "📍", "Advanced teleportation features"}
    }
    
    for i, scriptType in pairs(scriptTypes) do
        CreateButton(scriptType[2] .. " " .. scriptType[1], content, UDim2.new(1, -20, 0, 60), UDim2.new(0, 10, 0, 120 + (i-1)*70), function()
            local options = {
                FARM_DELAY = 0.3,
                FARM_SPEED = 3,
                BASE_SPEED = 50,
                BOOST_MULTIPLIER = 3,
                SHOW_PLAYERS = true,
                SHOW_ITEMS = true,
                MAX_DISTANCE = 200
            }
            
            local scriptCode = AIGenerator.GenerateScriptWithGUI(scriptType[1]:gsub(" ", ""), options)
            
            if scriptCode then
                -- Execute script
                local success, err = pcall(function()
                    loadstring(scriptCode)()
                end)
                
                if success then
                    print("✅ " .. scriptType[1] .. " script executed successfully!")
                    
                    -- Save to file
                    if writefile then
                        writefile("AIScriptWriter/" .. scriptType[1] .. ".lua", scriptCode)
                        print("💾 Script saved to file!")
                    end
                else
                    warn("❌ Script execution failed: " .. err)
                end
            end
        end)
    end
end)

-- Create Settings Tab
CreateTab("Settings", "⚙️", function(content)
    CreateCard("Security Settings", "Configure bypass methods and anti-detection systems", content, UDim2.new(1, -20, 0, 120))
    
    local settings = {
        {"Enable Advanced Bypass", true},
        {"Use Memory Protection", true},
        {"Anti-Detection Mode", true},
        {"Auto GUI Generation", true},
        {"Script Optimization", true}
    }
    
    for i, setting in pairs(settings) do
        local SettingFrame = Instance.new("Frame")
        SettingFrame.Size = UDim2.new(1, -20, 0, 40)
        SettingFrame.Position = UDim2.new(0, 10, 0, 140 + (i-1)*50)
        SettingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        SettingFrame.Parent = content
        
        local SettingCorner = Instance.new("UICorner")
        SettingCorner.CornerRadius = UDim.new(0, 8)
        SettingCorner.Parent = SettingFrame
        
        local SettingLabel = Instance.new("TextLabel")
        SettingLabel.Size = UDim2.new(0.7, -10, 1, 0)
        SettingLabel.Position = UDim2.new(0, 10, 0, 0)
        SettingLabel.BackgroundTransparency = 1
        SettingLabel.Text = setting[1]
        SettingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        SettingLabel.Font = Enum.Font.Gotham
        SettingLabel.TextSize = 13
        SettingLabel.TextXAlignment = Enum.TextXAlignment.Left
        SettingLabel.Parent = SettingFrame
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0.2, -10, 0, 25)
        ToggleButton.Position = UDim2.new(0.8, 0, 0.5, -12.5)
        ToggleButton.BackgroundColor3 = setting[2] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 60, 60)
        ToggleButton.Text = setting[2] and "ON" or "OFF"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleButton.Font = Enum.Font.GothamBold
        ToggleButton.TextSize = 12
        ToggleButton.Parent = SettingFrame
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 6)
        ToggleCorner.Parent = ToggleButton
        
        ToggleButton.MouseButton1Click:Connect(function()
            setting[2] = not setting[2]
            ToggleButton.BackgroundColor3 = setting[2] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 60, 60)
            ToggleButton.Text = setting[2] and "ON" or "OFF"
        end)
    end
end)

-- Control Button Functionality
CloseButton.MouseButton1Click:Connect(function()
    game:GetService("TweenService"):Create(MainContainer, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    wait(0.3)
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    if MainContainer.Size.Y.Offset == 150 then
        -- Restore
        game:GetService("TweenService"):Create(MainContainer, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 800, 0, 600),
            Position = UDim2.new(0.5, -400, 0.5, -300)
        }):Play()
    else
        -- Minimize
        game:GetService("TweenService"):Create(MainContainer, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 300, 0, 150),
            Position = UDim2.new(1, -320, 0, 20)
        }):Play()
    end
end)

-- Draggable Window
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainContainer.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Auto-activate first tab
if Tabs["Dashboard"] then
    Tabs["Dashboard"].Button.MouseButton1Click()
end

print("🎉 AI Script Writer Pro v3.0 loaded successfully!")
print("🚀 Advanced AI Generation System Ready!")
print("🛡️ Security Bypass: " .. #CoreSystems.SecurityBypass.ActiveBypasses .. " methods active")
print("🎯 Exploitable Points: " .. #CoreSystems.GameAnalysis.ExploitablePoints)
