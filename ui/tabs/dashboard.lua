local Dashboard = {}
local Config = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/core/config.lua"))()
local Fishing = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/systems/fishing.lua"))()
local PingPanel = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/features/pingpanel.lua"))()

-- Track active blatant mode
local activeBlatantMode = nil

function Dashboard.load(Window)
    local Tab = Window:Tab({ Title = "Dashboard", Icon = "layout-dashboard" })

    Tab:Paragraph({ Title = "Dashboard", Desc = "Fast & Stable Auto Fishing with Blatant Mode" })
    Tab:Divider()

    local BETA = Tab:Section({ Title = "Blatant BETA" })
    BETA:Toggle({
        Title = "Enable Blatant BETA",
        Value = Config.Current.BlatantMode,
        Callback = function(v)
            if activeBlatantMode and activeBlatantMode ~= "BETA" then
                Fishing.stop()
            end
            if v then
                activeBlatantMode = "BETA"
                local rodInfo = Fishing.updateRodDelay()
                print("Using: " .. rodInfo.rod)
                Fishing.start(true, "BETA")
            else
                activeBlatantMode = nil
                Fishing.stop()
            end
        end
    })
    BETA:Input({
        Title = "BETA Complete Delay",
        Placeholder = "Default: 0.68",
        Value = tostring(Config.Current.FishDelay),
        Callback = function(v)
            local n = tonumber(v)
            if n then Config.set("FishDelay", n) end
        end
    })
    BETA:Input({
        Title = "BETA Catch Delay",
        Placeholder = "Default: 0.34",
        Value = tostring(Config.Current.CatchDelay),
        Callback = function(v)
            local n = tonumber(v)
            if n then Config.set("CatchDelay", n) end
        end
    })

    Tab:Divider()

    local V1 = Tab:Section({ Title = "Blatant V1" })

    V1:Toggle({
        Title = "Enable Blatant V1",
        Callback = function(v)
            if activeBlatantMode and activeBlatantMode ~= "V1" then
                Fishing.stop()
            end
            if v then
                activeBlatantMode = "V1"
                local rodInfo = Fishing.updateRodDelay()
                print("Using: " .. rodInfo.rod)
                Fishing.start(true, "V1")
            else
                activeBlatantMode = nil
                Fishing.stop()
            end
        end
    })

    V1:Input({
        Title = "V1 Complete Delay",
        Placeholder = "Default: 0.9",
        Value = tostring(Config.Current.FishDelay),
        Callback = function(v)
            local n = tonumber(v)
            if n then Config.set("FishDelay", n) end
        end
    })

    V1:Input({
        Title = "V1 Cancel Delay",
        Placeholder = "Default: 0.2",
        Value = tostring(Config.Current.CatchDelay),
        Callback = function(v)
            local n = tonumber(v)
            if n then Config.set("CatchDelay", n) end
        end
    })
    Tab:Divider()
    local V2 = Tab:Section({ Title = "Blatant V2" })
    V2:Toggle({
        Title = "Enable Blatant V2",
        Value = Config.Current.BlatantMode,
        Callback = function(v)
            if activeBlatantMode and activeBlatantMode ~= "V2" then
                Fishing.stop()
            end
            if v then
                activeBlatantMode = "V2"
                local rodInfo = Fishing.updateRodDelay()
                print("Using: " .. rodInfo.rod)
                Fishing.start(true, "V2")
            else
                activeBlatantMode = nil
                Fishing.stop()
            end
        end
    })
    V2:Input({
        Title = "V2 Complete Delay",
        Placeholder = "Default: 0.9",
        Value = tostring(Config.Current.FishDelay),
        Callback = function(v)
            local n = tonumber(v)
            if n then Config.set("FishDelay", n) end
        end
    })
    V2:Input({
        Title = "V2 Cancel Delay",
        Placeholder = "Default: 0.2",
        Value = tostring(Config.Current.CatchDelay),
        Callback = function(v)
            local n = tonumber(v)
            if n then Config.set("CatchDelay", n) end
        end
    })

    Tab:Divider()
    local V3 = Tab:Section({ Title = "Blatant V3" })
    V3:Toggle({
        Title = "Enable Blatant V3",
        Value = Config.Current.BlatantMode,
        Callback = function(v)
            if activeBlatantMode and activeBlatantMode ~= "V3" then
                Fishing.stop()
            end
            if v then
                activeBlatantMode = "V3"
                local rodInfo = Fishing.updateRodDelay()
                print("Using: " .. rodInfo.rod)
                Fishing.start(true, "V3")
            else
                activeBlatantMode = nil
                Fishing.stop()
            end
        end
    })
    V3:Input({
        Title = "V3 Complete Delay",
        Placeholder = "Default: 0.9",
        Value = tostring(Config.Current.FishDelay),
        Callback = function(v)
            local n = tonumber(v)
            if n then Config.set("FishDelay", n) end
        end
    })
    V3:Input({
        Title = "V3 Cancel Delay",
        Placeholder = "Default: 0.2",
        Value = tostring(Config.Current.CatchDelay),
        Callback = function(v)
            local n = tonumber(v)
            if n then Config.set("CatchDelay", n) end
        end
    })
    Tab:Divider()
    Tab:Toggle({
        Title = "📊 Performance HUD",
        Desc = "Show FPS, Ping, and Memory usage",
        Value = false,
        Callback = function(v)
            PingPanel.toggle(v)
        end
    })
end

return Dashboard
