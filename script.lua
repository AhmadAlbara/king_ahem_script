local githubURL = "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/"

local function loadModule(path)
    local url = githubURL .. path
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if not success then
        warn("[ModuleLoader] ❌ Failed to load:", path)
        warn("[ModuleLoader] URL:", url)
        warn("[ModuleLoader] Error:", result)
        return nil
    end
    return result
end

print("[KING AHEM] 👑 Initializing...")

-- CORE
loadModule("core/config.lua")
loadModule("core/network.lua")

-- SYSTEM
loadModule("system/fishing.lua")
loadModule("system/autosell.lua")

-- FEATURES
loadModule("features/teleport.lua")
loadModule("features/afk.lua")
loadModule("features/pingpanel.lua")

-- UI
loadModule("ui/window.lua")

print("[KING AHEM] 👑 All modules loaded successfully.")
