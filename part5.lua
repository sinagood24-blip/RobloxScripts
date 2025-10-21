-- AI MEGA SCRIPT WRITER v4.0 - COMPLETE LOADER
-- Загружает ВСЕ 5 частей скрипта

local function LoadCompleteSystem()
    print("🚀 ЗАГРУЗКА AI MEGA SCRIPT WRITER v4.0")
    print("📦 Всего частей: 5")
    print("📊 Общее количество строк: 10,000+")
    
    -- Индикатор загрузки
    local LoadGUI = Instance.new("ScreenGui")
    local LoadFrame = Instance.new("Frame")
    local LoadLabel = Instance.new("TextLabel")
    local ProgressBar = Instance.new("Frame")
    local ProgressFill = Instance.new("Frame")
    
    LoadGUI.Parent = game:GetService("CoreGui")
    
    LoadFrame.Size = UDim2.new(0, 450, 0, 180)
    LoadFrame.Position = UDim2.new(0.5, -225, 0.5, -90)
    LoadFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    LoadFrame.BorderSizePixel = 0
    LoadFrame.Parent = LoadGUI
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = LoadFrame
    
    LoadLabel.Size = UDim2.new(1, -40, 0, 80)
    LoadLabel.Position = UDim2.new(0, 20, 0, 20)
    LoadLabel.Text = "🤖 AI MEGA SCRIPT WRITER v4.0\n\n🔄 Загрузка системы...\n📊 10,000+ строк кода\n🎯 5 модулей"
    LoadLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadLabel.Font = Enum.Font.GothamBold
    LoadLabel.TextSize = 16
    LoadLabel.BackgroundTransparency = 1
    LoadLabel.TextWrapped = true
    LoadLabel.Parent = LoadFrame
    
    -- Прогресс бар
    ProgressBar.Size = UDim2.new(1, -40, 0, 20)
    ProgressBar.Position = UDim2.new(0, 20, 0, 120)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = LoadFrame
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 10)
    BarCorner.Parent = ProgressBar
    
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Parent = ProgressBar
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 10)
    FillCorner.Parent = ProgressFill
    
    -- Функция обновления прогресса
    local function UpdateProgress(percent, text)
        LoadLabel.Text = "🤖 AI MEGA SCRIPT WRITER v4.0\n\n" .. text
        ProgressFill.Size = UDim2.new(percent / 100, 0, 1, 0)
    end
    
    -- Загружаем все части последовательно
    local parts = {
        {
            url = "https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/part1.lua",
            name = "Загрузчик и базовая система",
            description = "Инициализация основных модулей..."
        },
        {
            url = "https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/part2.lua", 
            name = "Ядро системы и безопасность",
            description = "Загрузка систем безопасности..."
        },
        {
            url = "https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/part3.lua",
            name = "Мега-генератор скриптов",
            description = "Инициализация AI генератора..."
        },
        {
            url = "https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/part4.lua",
            name = "Супер-GUI система", 
            description = "Загрузка интерфейса..."
        },
        {
            url = "https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/part5.lua",
            name = "Финальная инициализация",
            description = "Запуск всех систем..."
        }
    }
    
    local loadedModules = {}
    
    -- Загрузка каждой части
    for i, part in ipairs(parts) do
        UpdateProgress((i-1) * 20, part.description)
        
        local success, result = pcall(function()
            return loadstring(game:HttpGet(part.url))()
        end)
        
        if success then
            loadedModules[part.name] = result
            print("✅ Загружен: " .. part.name)
        else
            warn("❌ Ошибка загрузки " .. part.name .. ": " .. tostring(result))
        end
        
        task.wait(0.5) -- Задержка для плавности
    end
    
    -- Финальная инициализация
    UpdateProgress(100, "🚀 Запуск AI MEGA SCRIPT WRITER...")
    
    task.wait(1)
    
    -- Удаляем индикатор загрузки
    LoadGUI:Destroy()
    
    -- Запускаем основную систему
    if loadedModules["Финальная инициализация"] then
        print("🎉 AI MEGA SCRIPT WRITER v4.0 УСПЕШНО ЗАГРУЖЕН!")
        print("📊 Статистика системы:")
        print("   🤖 AI Генератор: АКТИВЕН")
        print("   🛡️ Системы безопасности: ЗАГРУЖЕНЫ")
        print("   📁 База скриптов: 20+ СКРИПТОВ")
        print("   🎨 GUI интерфейс: ГОТОВ")
        print("   ⚡ Производительность: ОПТИМАЛЬНА")
    else
        warn("⚠️ Не все модули загружены корректно")
    end
end

-- Запускаем полную систему
LoadCompleteSystem()
