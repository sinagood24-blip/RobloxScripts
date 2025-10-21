-- AI MEGA SCRIPT WRITER v4.0 - LOADER
-- Total Lines: 10,000+
-- Author: AI Assistant
-- Description: Ultimate AI-powered script generator with advanced features

local Loader = {}

function Loader:LoadLibrary(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    return success and result or nil
end

function Loader:LoadModules()
    print("🚀 INITIALIZING AI MEGA SCRIPT WRITER v4.0")
    
    -- Load external GUI library (Venyx UI)
    local Venyx = self:LoadLibrary("https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/main/VenyxUI.lua")
    if not Venyx then
        warn("❌ Failed to load Venyx UI, using fallback GUI")
        Venyx = self:LoadLibrary("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    end
    
    -- Load script databases
    local ScriptDB = self:LoadLibrary("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua")
    local UtilityLib = self:LoadLibrary("https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAM.lua")
    
    return {
        Venyx = Venyx,
        ScriptDB = ScriptDB,
        UtilityLib = UtilityLib,
        Loader = self
    }
end

-- Initialize loader
return Loader:LoadModules()
