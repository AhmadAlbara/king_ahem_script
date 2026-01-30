-- placeholder
-- =====================================================
-- KING AHEM v1.0 - Hybrid Loader (Local/GitHub)
-- =====================================================

local isLocal = false          
local githubURL = "https://raw.githubusercontent.com/AhmadAlbara/king_ahem/main/"
local localPath = "king_ahem/" 

local function getModulePath(path)
    if isLocal then
        return localPath .. path
    else
        return githubURL .. path
    end
end

local function loadModule(path)
    local success, result
    if isLocal then
        success, result = pcall(function()
            return loadstring(readfile(getModulePath(path)))()
        end)
    else
        success, result = pcall(function()
            return loadstring(game:HttpGet(getModulePath(path)))()
        end)
    end

    if not success then
        warn("[LOADER] ❌ Failed: " .. path)
        warn("[LOADER] " .. tostring(result))
        return nil
    end

    print("[LOADER] ✅ " .. path)
    return result
end

print("[KING AHEM] 👑 Initializing...")

loadModule("core/config.lua")
loadModule("core/network.lua")
loadModule("systems/fishing.lua")

loadModule("systems/autosell.lua")
loadModule("features/teleport.lua")
loadModule("features/pingpanel.lua")
loadModule("features/afklua")
loadModule("ui/window.lua")

print("[KING AHEM] 👑 Ready! (" .. (isLocal and "LOCAL" or "GITHUB") .. " mode)")
