-- Fallback интерфейс (полная версия)
function AdvancedGUI:CreateFallbackInterface(aiEngine, securitySystem)
    print("🛠️ USING FALLBACK INTERFACE...")
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AIScriptWriterFallback"
    ScreenGui.Parent = game:GetService("CoreGui")
    
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
    SubTitle.Text = "Fallback Interface - Full Functional"
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
                game:GetService("TweenService"):Create(tabData.Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 60)
                }):Play()
            end
            
            -- Show selected tab
            TabContent.Visible = true
            game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 80, 255)
            }):Play()
            
            CurrentTab = name
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
            game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 80, 255)
            }):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            }):Play()
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
    
    -- Game Analysis
    local gameAnalysis = aiEngine:AnalyzeGameAndGenerate()
    
    CreateLabel("🎮 Game: " .. gameAnalysis.Game, DashboardTab)
    CreateLabel("🛡️ Security: " .. gameAnalysis.SecurityLevel, DashboardTab)
    CreateLabel("🎯 Pattern: " .. gameAnalysis.DetectedPattern, DashboardTab)
    CreateLabel("📊 Scripts: " .. #gameAnalysis.RecommendedScripts .. " recommended", DashboardTab)
    
    CreateSection("Quick Actions", DashboardTab)
    
    CreateButton("🚀 Apply Security Bypass", DashboardTab, function()
        securitySystem:ApplyFullProtection()
        print("✅ Security bypass applied!")
    end)
    
    CreateButton("🤖 Generate AI Script Pack", DashboardTab, function()
        local package = aiEngine:GenerateGamePackage(gameAnalysis.Game)
        if package then
            print("✅ Generated " .. #package.Scripts .. " scripts for " .. package.Game)
            for _, script in pairs(package.Scripts) do
                if writefile then
                    writefile("AIScriptWriter/" .. script.Name .. ".lua", script.Content)
                end
            end
        end
    end)
    
    CreateButton("🔄 Refresh Analysis", DashboardTab, function()
        gameAnalysis = aiEngine:AnalyzeGameAndGenerate()
        print("✅ Analysis refreshed!")
    end)
    
    -- AI Generator Tab
    local GeneratorTab = CreateTab("AI Generator", "🤖")
    
    CreateSection("Script Selection", GeneratorTab)
    
    local scriptTypes = {"Aimbot", "ESP", "SpeedHack", "FlyHack", "NoClip", "AutoFarm"}
    local selectedScript = "Aimbot"
    
    for _, scriptType in pairs(scriptTypes) do
        CreateButton(scriptType, GeneratorTab, function()
            selectedScript = scriptType
            print("✅ Selected: " .. scriptType)
        end)
    end
    
    CreateSection("Generation Settings", GeneratorTab)
    
    local speedValue = 50
    local smoothValue = 0.1
    local safetyToggle = true
    
    CreateLabel("Speed: " .. speedValue, GeneratorTab)
    CreateLabel("Smoothness: " .. smoothValue, GeneratorTab)
    CreateLabel("Safety: " .. tostring(safetyToggle), GeneratorTab)
    
    CreateSection("Script Generation", GeneratorTab)
    
    CreateButton("🎯 Generate AI Script", GeneratorTab, function()
        local script = aiEngine:GenerateScript(selectedScript, {
            Speed = speedValue,
            Smoothness = smoothValue,
            Safety = safetyToggle
        })
        
        if script then
            self:ShowFallbackScriptPreview(script)
        end
    end)
    
    CreateButton("⚡ Generate & Execute", GeneratorTab, function()
        local script = aiEngine:GenerateScript(selectedScript, {
            Speed = speedValue,
            Smoothness = smoothValue
        })
        
        if script then
            loadstring(script.Content)()
            print("✅ Executed: " .. script.Name)
        end
    end)
    
    CreateButton("💾 Generate & Save", GeneratorTab, function()
        local script = aiEngine:GenerateScript(selectedScript, {
            Speed = speedValue,
            Smoothness = smoothValue
        })
        
        if script and writefile then
            writefile("AIScriptWriter/" .. script.Name .. ".lua", script.Content)
            print("✅ Saved: " .. script.Name .. ".lua")
        end
    end)
    
    -- Script Hub Tab
    local HubTab = CreateTab("Script Hub", "📁")
    
    CreateSection("Popular Scripts", HubTab)
    
    local popularScripts = {
        {"Aimbot", "InfiniteYield Style Aimbot"},
        {"ESP", "Player ESP with Boxes"},
        {"SpeedHack", "Speed Hack with Toggle"},
        {"FlyHack", "Advanced Flying System"},
        {"NoClip", "Walk through walls"},
        {"AutoFarm", "Auto collect resources"}
    }
    
    for _, scriptData in pairs(popularScripts) do
        CreateButton(scriptData[1], HubTab, function()
            local script = aiEngine:GenerateScript(scriptData[1], {})
            if script then
                loadstring(script.Content)()
                print("✅ Loaded: " .. scriptData[2])
            end
        end)
    end
    
    -- Security Tab
    local SecurityTab = CreateTab("Security", "🛡️")
    
    CreateSection("Security Analysis", SecurityTab)
    
    local detectedSystems = securitySystem.AntiCheatDetector:DetectSystems()
    local securityLevel = securitySystem.AntiCheatDetector:GetSecurityLevel(detectedSystems)
    
    for _, system in pairs(detectedSystems) do
        CreateLabel("🔍 " .. system, SecurityTab)
    end
    
    CreateLabel("🛡️ Security Level: " .. securityLevel, SecurityTab)
    
    CreateSection("Bypass Methods", SecurityTab)
    
    local bypassMethods = {
        {"Memory Protection", "MemoryProtection"},
        {"Function Hooking", "HookProtection"},
        {"Anti-Detection", "AntiDetection"},
        {"Remote Spoofing", "RemoteSpoofing"}
    }
    
    for _, bypassData in pairs(bypassMethods) do
        CreateButton(bypassData[1], SecurityTab, function()
            local bypassCode = securitySystem.BypassMethods[bypassData[2]]
            if bypassCode then
                loadstring(bypassCode)()
                print("✅ Applied: " .. bypassData[1])
            end
        end)
    end
    
    CreateButton("🛡️ Apply All Bypasses", SecurityTab, function()
        securitySystem:ApplyFullProtection()
        print("✅ All security systems activated!")
    end)
    
    -- Settings Tab
    local SettingsTab = CreateTab("Settings", "⚙️")
    
    CreateSection("UI Settings", SettingsTab)
    
    CreateLabel("Always On Top: Enabled", SettingsTab)
    CreateLabel("Show Notifications: Enabled", SettingsTab)
    
    CreateSection("Script Settings", SettingsTab)
    
    CreateLabel("Auto-Save Scripts: Enabled", SettingsTab)
    CreateLabel("Auto-Execute: Disabled", SettingsTab)
    
    CreateSection("Information", SettingsTab)
    
    CreateLabel("🤖 AI MEGA SCRIPT WRITER v5.0", SettingsTab)
    CreateLabel("📊 15,000+ Lines of Code", SettingsTab)
    CreateLabel("🎯 Advanced AI Systems", SettingsTab)
    CreateLabel("🛡️ Real Security Bypasses", SettingsTab)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        wait(0.3)
        ScreenGui:Destroy()
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
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Activate first tab
    if Tabs["Dashboard"] then
        Tabs["Dashboard"].Button.MouseButton1Click()
    end
    
    return ScreenGui
end

-- Fallback script preview
function AdvancedGUI:ShowFallbackScriptPreview(script)
    local PreviewGUI = Instance.new("ScreenGui")
    PreviewGUI.Name = "ScriptPreview"
    PreviewGUI.Parent = game:GetService("CoreGui")
    
    local PreviewFrame = Instance.new("Frame")
    PreviewFrame.Size = UDim2.new(0, 500, 0, 400)
    PreviewFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    PreviewFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    PreviewFrame.BackgroundTransparency = 0.05
    PreviewFrame.BorderSizePixel = 0
    PreviewFrame.Parent = PreviewGUI
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = PreviewFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(80, 120, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = PreviewFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Header.BorderSizePixel = 0
    Header.Parent = PreviewFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Script Preview - " .. script.Name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 10)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.Parent = Header
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton
    
    -- Content
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, -40, 1, -100)
    ContentFrame.Position = UDim2.new(0, 20, 0, 60)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 6
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 120, 255)
    ContentFrame.Parent = PreviewFrame
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 10)
    ContentLayout.Parent = ContentFrame
    
    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.PaddingTop = UDim.new(0, 10)
    ContentPadding.PaddingLeft = UDim.new(0, 10)
    ContentPadding.PaddingRight = UDim.new(0, 10)
    ContentPadding.Parent = ContentFrame
    
    -- Script info
    local function CreateLabel(text, parent)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -20, 0, 25)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = parent
        return Label
    end
    
    CreateLabel("Name: " .. script.Name, ContentFrame)
    CreateLabel("Category: " .. script.Category, ContentFrame)
    CreateLabel("Risk: " .. script.Risk, ContentFrame)
    
    -- Script content (truncated)
    local previewText = string.sub(script.Content, 1, 1000)
    if #script.Content > 1000 then
        previewText = previewText .. "\n\n... [content truncated] ..."
    end
    
    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Size = UDim2.new(1, -20, 0, 200)
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.Text = previewText
    ContentLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    ContentLabel.Font = Enum.Font.Gotham
    ContentLabel.TextSize = 11
    ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
    ContentLabel.TextWrapped = true
    ContentLabel.Parent = ContentFrame
    
    -- Buttons
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, -40, 0, 50)
    ButtonFrame.Position = UDim2.new(0, 20, 1, -60)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = PreviewFrame
    
    local ButtonList = Instance.new("UIListLayout")
    ButtonList.FillDirection = Enum.FillDirection.Horizontal
    ButtonList.Padding = UDim.new(0, 10)
    ButtonList.Parent = ButtonFrame
    
    local function CreateActionButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0.3, 0, 1, 0)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.GothamBold
        Button.TextSize = 12
        Button.Parent = ButtonFrame
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(callback)
        
        return Button
    end
    
    CreateActionButton("▶️ Execute", function()
        loadstring(script.Content)()
        PreviewGUI:Destroy()
        print("✅ Executed: " .. script.Name)
    end)
    
    CreateActionButton("💾 Save", function()
        if writefile then
            writefile("AIScriptWriter/" .. script.Name .. ".lua", script.Content)
            PreviewGUI:Destroy()
            print("✅ Saved: " .. script.Name .. ".lua")
        end
    end)
    
    CreateActionButton("📋 Copy", function()
        if setclipboard then
            setclipboard(script.Content)
            print("✅ Copied to clipboard!")
        end
    end)
    
    -- Close functionality
    CloseButton.MouseButton1Click:Connect(function()
        PreviewGUI:Destroy()
    end)
    
    -- Update canvas size
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
end

return AdvancedGUI
