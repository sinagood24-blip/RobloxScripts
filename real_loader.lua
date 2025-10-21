-- AI MEGA SCRIPT WRITER v5.0 - MAIN LOADER
print("🚀 Loading AI MEGA SCRIPT WRITER v5.0...")

-- Загружаем все системы
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/enhanced_core.lua"))()
local AI = loadstring(game:HttpGet("https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/enhanced_ai.lua"))()
local Security = loadstring(game:HttpGet("https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/enhanced_security.lua"))()
local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/sinagood24-blip/RobloxScripts/main/enhanced_gui.lua"))()

-- Создаем интерфейс
local mainWindow = GUI:CreateMainInterface(Core, AI, Security)

print("🎉 AI MEGA SCRIPT WRITER v5.0 LOADED SUCCESSFULLY!")
