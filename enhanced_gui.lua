-- Полностью автономный Fallback GUI
local AdvancedGUI = {}

function AdvancedGUI:CreateFallbackInterface()
    print("🛠️ CREATING AUTONOMOUS FALLBACK INTERFACE...")
    
    -- Проверяем доступность CoreGui
    local success, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    
    if not success then
        warn("❌ CoreGui not available")
        return nil
    end
    
    -- Создаем основной GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AIScriptWriterFallback"
    ScreenGui.Parent = coreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 600, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(80, 120, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 60)
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🤖 AI MEGA SCRIPT WRITER v5.0"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(1, -100, 0, 20)
    SubTitle.Position = UDim2.new(0, 20, 0, 35)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "Autonomous Fallback Interface"
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 255)
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextSize = 12
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = Header
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 15)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.Parent = Header
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton
    
    -- Tab Buttons
    local TabButtons = Instance.new("Frame")
    TabButtons.Size = UDim2.new(1, -40, 0, 40)
    TabButtons.Position = UDim2.new(0, 20, 0, 70)
    TabButtons.BackgroundTransparency = 1
    TabButtons.Parent = MainFrame
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 10)
    TabListLayout.Parent = TabButtons
    
    -- Content Area
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -40, 1, -130)
    ContentFrame.Position = UDim2.new(0, 20, 0, 120)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ClipsDescendants = true
    ContentFrame.Parent = MainFrame
    
    -- Tab Management
    local Tabs = {}
    local CurrentTab = nil
    
    -- Function to create tab
    local function CreateTab(name, icon)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 120, 1, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        TabButton.Text = icon .. " " .. name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 255)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 12
        TabButton.Parent = TabButtons
        
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
        ContentLayout.Padding = UDim.new(0, 10)
        ContentLayout.Parent = TabContent
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingTop = UDim.new(0, 10)
        ContentPadding.PaddingLeft = UDim.new(0, 10)
        ContentPadding.PaddingRight = UDim.new(0, 10)
        ContentPadding.Parent = TabContent
        
        TabButton.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, tabData in pairs(Tabs) do
                tabData.Content.Visible = false
                tabData.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            end
            
            -- Show selected tab
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(60, 80, 255)
            
            CurrentTab = name
            -- Update canvas size with delay to ensure proper calculation
            wait(0.1)
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end)
        
        Tabs[name] = {
            Button = TabButton,
            Content = TabContent,
            Name = name
        }
        
        return TabContent
    end
    
    -- Function to create button
    local function CreateButton(text, parent, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, -20, 0, 45)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.GothamBold
        Button.TextSize = 14
        Button.Parent = parent
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = Button
        
        local ButtonStroke = Instance.new("UIStroke")
        ButtonStroke.Color = Color3.fromRGB(80, 120, 255)
        ButtonStroke.Thickness = 1.5
        ButtonStroke.Parent = Button
        
        -- Hover effects
        Button.MouseEnter:Connect(function()
            Button.BackgroundColor3 = Color3.fromRGB(60, 80, 255)
        end)
        
        Button.MouseLeave:Connect(function()
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        end)
        
        if callback then
            Button.MouseButton1Click:Connect(callback)
        end
        
        return Button
    end
    
    -- Function to create label
    local function CreateLabel(text, parent)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -20, 0, 30)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = parent
        return Label
    end
    
    -- Function to create section
    local function CreateSection(title, parent)
        local Section = Instance.new("Frame")
        Section.Size = UDim2.new(1, -20, 0, 30)
        Section.BackgroundTransparency = 1
        Section.Parent = parent
        
        local SectionLabel = Instance.new("TextLabel")
        SectionLabel.Size = UDim2.new(1, 0, 1, 0)
        SectionLabel.BackgroundTransparency = 1
        SectionLabel.Text = "─── " .. title .. " ───"
        SectionLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
        SectionLabel.Font = Enum.Font.GothamBold
        SectionLabel.TextSize = 12
        SectionLabel.Parent = Section
        
        return Section
    end
    
    -- Dashboard Tab
    local DashboardTab = CreateTab("Dashboard", "📊")
    
    CreateSection("System Status", DashboardTab)
    
    -- Basic game detection
    local gameName = "Unknown Game"
    local success, currentGame = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    if success then
        gameName = currentGame
    else
        gameName = "Game ID: " .. tostring(game.PlaceId)
    end
    
    CreateLabel("🎮 Game: " .. gameName, DashboardTab)
    CreateLabel("🛡️ Security: Autonomous Mode", DashboardTab)
    CreateLabel("🎯 Status: Fallback Interface Active", DashboardTab)
    CreateLabel("📊 Features: Full GUI System", DashboardTab)
    
    CreateSection("Quick Actions", DashboardTab)
    
    CreateButton("🚀 Test Basic Script", DashboardTab, function()
        print("✅ Testing basic script execution...")
        -- Simple test script
        local testScript = [[
            print("🤖 AI Script Writer Test Script Loaded!")
            game:GetService("Players").LocalPlayer:SetAttribute("AITest", true)
        ]]
        
        local success, err = pcall(function()
            loadstring(testScript)()
        end)
        
        if success then
            print("✅ Test script executed successfully!")
        else
            warn("❌ Test script failed: " .. tostring(err))
        end
    end)
    
    CreateButton("📁 Create Script Folder", DashboardTab, function()
        if writefile then
            local success, err = pcall(function()
                writefile("AIScriptWriter/README.txt", "AI Script Writer Generated Files\nCreated: " .. os.date())
            end)
            if success then
                print("✅ Script folder created!")
            else
                warn("❌ Folder creation failed: " .. tostring(err))
            end
        else
            print("⚠️ writefile function not available")
        end
    end)
    
    CreateButton("🔄 Refresh Interface", DashboardTab, function()
        ScreenGui:Destroy()
        AdvancedGUI:CreateFallbackInterface()
    end)
    
    -- Script Generator Tab
    local GeneratorTab = CreateTab("Generator", "🤖")
    
    CreateSection("Script Templates", GeneratorTab)
    
    local scriptTemplates = {
        {"Aimbot", "Target aiming system"},
        {"ESP", "Player visibility"},
        {"Speed", "Movement enhancement"},
        {"Fly", "Flying capability"},
        {"Noclip", "Wall passing"},
        {"Autofarm", "Auto collection"}
    }
    
    for _, template in pairs(scriptTemplates) do
        CreateButton(template[1], GeneratorTab, function()
            print("🎯 Selected: " .. template[1])
            AdvancedGUI:ShowScriptPreview(template[1], template[2])
        end)
    end
    
    CreateSection("Quick Generation", GeneratorTab)
    
    CreateButton("⚡ Generate All Scripts", GeneratorTab, function()
        print("🚀 Generating all script templates...")
        for _, template in pairs(scriptTemplates) do
            AdvancedGUI:GenerateAndSaveScript(template[1])
        end
    end)
    
    -- Tools Tab
    local ToolsTab = CreateTab("Tools", "🛠️")
    
    CreateSection("Utility Tools", ToolsTab)
    
    CreateButton("🎯 Player ESP", ToolsTab, function()
        AdvancedGUI:CreatePlayerESP()
    end)
    
    CreateButton("⚡ Speed Hack", ToolsTab, function()
        AdvancedGUI:CreateSpeedHack()
    end)
    
    CreateButton("🕶️ NoClip", ToolsTab, function()
        AdvancedGUI:CreateNoClip()
    end)
    
    CreateButton("🚀 Fly Hack", ToolsTab, function()
        AdvancedGUI:CreateFlyHack()
    end)
    
    CreateButton("🔍 Anti-AFK", ToolsTab, function()
        AdvancedGUI:CreateAntiAFK()
    end)
    
    -- Settings Tab
    local SettingsTab = CreateTab("Settings", "⚙️")
    
    CreateSection("Interface Settings", SettingsTab)
    
    CreateLabel("Theme: Dark Blue", SettingsTab)
    CreateLabel("Transparency: 5%", SettingsTab)
    CreateLabel("Animation: Basic", SettingsTab)
    
    CreateSection("System Information", SettingsTab)
    
    CreateLabel("🤖 AI Script Writer v5.0", SettingsTab)
    CreateLabel("🔄 Autonomous Fallback Mode", SettingsTab)
    CreateLabel("📊 No External Dependencies", SettingsTab)
    CreateLabel("🎯 Full GUI Functionality", SettingsTab)
    
    CreateSection("Actions", SettingsTab)
    
    CreateButton("🔄 Restart Interface", SettingsTab, function()
        ScreenGui:Destroy()
        wait(0.5)
        AdvancedGUI:CreateFallbackInterface()
    end)
    
    CreateButton("🗑️ Clean Up", SettingsTab, function()
        ScreenGui:Destroy()
        print("✅ Interface cleaned up!")
    end)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        print("✅ Interface closed!")
    end)
    
    -- Draggable window
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    Header.InputBegan:Connect(function(input)
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
    
    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    local userInputService = game:GetService("UserInputService")
    if userInputService then
        userInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    
    -- Activate first tab
    if Tabs["Dashboard"] then
        Tabs["Dashboard"].Button.MouseButton1Click()
    end
    
    print("✅ Autonomous Fallback Interface Created Successfully!")
    return ScreenGui
end

-- Script generation functions
function AdvancedGUI:GenerateAndSaveScript(scriptType)
    if not writefile then
        print("⚠️ writefile function not available")
        return
    end
    
    local scripts = {
        Aimbot = [[
            -- Simple Aimbot Script
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Mouse = LocalPlayer:GetMouse()
            
            print("🎯 Aimbot loaded! Right-click to target nearest player.")
            
            Mouse.Button2Down:Connect(function()
                local closestPlayer = nil
                local closestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                        local distance = (player.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
                
                if closestPlayer then
                    LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(
                        LocalPlayer.Character.PrimaryPart.Position,
                        closestPlayer.Character.Head.Position
                    ))
                    print("🎯 Targeted: " .. closestPlayer.Name)
                end
            end)
        ]],
        
        ESP = [[
            -- Simple ESP Script
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            print("👁️ ESP loaded! Player boxes visible.")
            
            function createESP(player)
                if player ~= LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = player.Character
                    
                    player.CharacterAdded:Connect(function(character)
                        wait(1)
                        local newHighlight = Instance.new("Highlight")
                        newHighlight.FillColor = Color3.fromRGB(255, 0, 0)
                        newHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        newHighlight.Parent = character
                    end)
                end
            end
            
            for _, player in pairs(Players:GetPlayers()) do
                createESP(player)
            end
            
            Players.PlayerAdded:Connect(createESP)
        ]],
        
        Speed = [[
            -- Speed Hack Script
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            print("⚡ Speed hack loaded! Press Z to toggle.")
            
            local speedEnabled = false
            local originalWalkSpeed = 16
            
            if LocalPlayer.Character then
                originalWalkSpeed = LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed
            end
            
            local function toggleSpeed()
                speedEnabled = not speedEnabled
                if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        if speedEnabled then
                            humanoid.WalkSpeed = 50
                            print("⚡ Speed hack: ON")
                        else
                            humanoid.WalkSpeed = originalWalkSpeed
                            print("⚡ Speed hack: OFF")
                        end
                    end
                end
            end
            
            game:GetService("UserInputService").InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.Z then
                    toggleSpeed()
                end
            end)
        ]]
    }
    
    local scriptContent = scripts[scriptType] or "-- Script template not found"
    local fileName = scriptType .. ".lua"
    
    local success, err = pcall(function()
        writefile("AIScriptWriter/" .. fileName, scriptContent)
    end)
    
    if success then
        print("✅ Saved: " .. fileName)
    else
        warn("❌ Save failed: " .. tostring(err))
    end
end

function AdvancedGUI:ShowScriptPreview(scriptName, description)
    local coreGui = game:GetService("CoreGui")
    
    local PreviewGUI = Instance.new("ScreenGui")
    PreviewGUI.Name = "ScriptPreview"
    PreviewGUI.Parent = coreGui
    
    local PreviewFrame = Instance.new("Frame")
    PreviewFrame.Size = UDim2.new(0, 400, 0, 300)
    PreviewFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    PreviewFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    PreviewFrame.BorderSizePixel = 0
    PreviewFrame.Parent = PreviewGUI
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = PreviewFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Title.Text = "Script: " .. scriptName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = PreviewFrame
    
    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -40, 0, 60)
    Description.Position = UDim2.new(0, 20, 0, 60)
    Description.BackgroundTransparency = 1
    Description.Text = description
    Description.TextColor3 = Color3.fromRGB(200, 200, 255)
    Description.Font = Enum.Font.Gotham
    Description.TextSize = 12
    Description.TextWrapped = true
    Description.Parent = PreviewFrame
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 100, 0, 40)
    CloseButton.Position = UDim2.new(0.5, -50, 1, -60)
    CloseButton.BackgroundColor3 = Color3.fromRGB(60, 80, 255)
    CloseButton.Text = "Close"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 14
    CloseButton.Parent = PreviewFrame
    
    local GenerateButton = Instance.new("TextButton")
    GenerateButton.Size = UDim2.new(0, 100, 0, 40)
    GenerateButton.Position = UDim2.new(0.5, -50, 1, -110)
    GenerateButton.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
    GenerateButton.Text = "Generate"
    GenerateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GenerateButton.Font = Enum.Font.GothamBold
    GenerateButton.TextSize = 14
    GenerateButton.Parent = PreviewFrame
    
    CloseButton.MouseButton1Click:Connect(function()
        PreviewGUI:Destroy()
    end)
    
    GenerateButton.MouseButton1Click:Connect(function()
        self:GenerateAndSaveScript(scriptName)
        PreviewGUI:Destroy()
    end)
    
    print("📋 Showing preview for: " .. scriptName)
end

-- Tool functions
function AdvancedGUI:CreatePlayerESP()
    print("👁️ Creating Player ESP...")
    loadstring([[
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        function createESP(player)
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = player.Character
                
                player.CharacterAdded:Connect(function(character)
                    wait(1)
                    local newHighlight = Instance.new("Highlight")
                    newHighlight.FillColor = Color3.fromRGB(255, 0, 0)
                    newHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    newHighlight.Parent = character
                end)
            end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            createESP(player)
        end
        
        Players.PlayerAdded:Connect(createESP)
        print("✅ Player ESP activated!")
    ]])()
end

function AdvancedGUI:CreateSpeedHack()
    print("⚡ Creating Speed Hack...")
    loadstring([[
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        local speedEnabled = false
        local originalWalkSpeed = 16
        
        if LocalPlayer.Character then
            originalWalkSpeed = LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed
        end
        
        local function toggleSpeed()
            speedEnabled = not speedEnabled
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    if speedEnabled then
                        humanoid.WalkSpeed = 50
                        print("⚡ Speed hack: ON")
                    else
                        humanoid.WalkSpeed = originalWalkSpeed
                        print("⚡ Speed hack: OFF")
                    end
                end
            end
        end
        
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Z then
                toggleSpeed()
            end
        end)
        
        print("✅ Speed Hack activated! Press Z to toggle.")
    ]])()
end

function AdvancedGUI:CreateNoClip()
    print("🕶️ Creating NoClip...")
    loadstring([[
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        local noclip = false
        local connection
        
        local function toggleNoclip()
            noclip = not noclip
            if noclip then
                print("🕶️ NoClip: ON")
                connection = game:GetService("RunService").Stepped:Connect(function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            else
                print("🕶️ NoClip: OFF")
                if connection then
                    connection:Disconnect()
                end
            end
        end
        
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.X then
                toggleNoclip()
            end
        end)
        
        print("✅ NoClip activated! Press X to toggle.")
    ]])()
end

function AdvancedGUI:CreateFlyHack()
    print("🚀 Creating Fly Hack...")
    loadstring([[
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        local flyEnabled = false
        local bodyVelocity
        
        local function toggleFly()
            flyEnabled = not flyEnabled
            
            if flyEnabled then
                print("🚀 Fly Hack: ON")
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
                
                if LocalPlayer.Character then
                    bodyVelocity.Parent = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                end
                
                game:GetService("UserInputService").InputBegan:Connect(function(input)
                    if flyEnabled and LocalPlayer.Character then
                        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root and bodyVelocity then
                            if input.KeyCode == Enum.KeyCode.Space then
                                bodyVelocity.Velocity = Vector3.new(0, 50, 0)
                            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                                bodyVelocity.Velocity = Vector3.new(0, -50, 0)
                            end
                        end
                    end
                end)
                
                game:GetService("UserInputService").InputEnded:Connect(function(input)
                    if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then
                        if bodyVelocity then
                            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                        end
                    end
                end)
            else
                print("🚀 Fly Hack: OFF")
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
            end
        end
        
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.C then
                toggleFly()
            end
        end)
        
        print("✅ Fly Hack activated! Press C to toggle, Space to go up, Shift to go down.")
    ]])()
end

function AdvancedGUI:CreateAntiAFK()
    print("🔍 Creating Anti-AFK...")
    loadstring([[
        local VirtualUser = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            print("🔄 Anti-AFK: Prevented AFK")
        end)
        print("✅ Anti-AFK activated!")
    ]])()
end

-- Initialize the interface
return AdvancedGUI
