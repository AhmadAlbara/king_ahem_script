

local githubURL = "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/"

local function loadModule(path)
    print("[LOADER] ⏳ Loading:", path)

    -- 1. HTTP FETCH
    local ok, response = pcall(function()
        return game:HttpGet(githubURL .. path)
    end)

    if not ok then
        warn("[LOADER] ❌ HTTP FAILED:", path)
        warn("[LOADER] →", response)
        return nil
    end

    -- 2. LOADSTRING
    local chunk, err = loadstring(response)
    if not chunk then
        warn("[LOADER] ❌ LOADSTRING ERROR:", path)
        warn("[LOADER] →", err)
        return nil
    end

    -- 3. EXECUTE MODULE
    local success, result = pcall(chunk)
    if not success then
        warn("[LOADER] ❌ RUNTIME ERROR:", path)
        warn("[LOADER] →", result)
        return nil
    end

    -- 4. VALIDATE RETURN
    if result == nil then
        warn("[LOADER] ⚠️ Module returned nil:", path)
    else
        print("[LOADER] ✅ Loaded:", path)
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
loadModule("ui/tabs/dashboard.lua")
