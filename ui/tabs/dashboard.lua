local Dashboard = {}
local Config = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/core/config.lua"))()
local Fishing = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/systems/fishing.lua"))()
local PingPanel = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/features/pingpanel.lua"))()

local activeBlatantMode = nil
local UIElements = {}

function Dashboard.load(Window)
    local Tab = Window:Tab({ Title = "Dashboard", Icon = "layout-dashboard" })

    Tab:Paragraph({ Title = "Dashboard", Desc = "Fast & Stable Auto Fishing with Blatant Mode" })
    Tab:Divider()

    -- ============================================
    -- BLATANT BETA SECTION
    -- ============================================
    local BETA = Tab:Section({ Title = "Blatant BETA" })


    BETA:Toggle({
        Title = "Enable Blatant BETA",
        Value = false,
        Callback = function(v)
            -- Stop other modes
            if activeBlatantMode and activeBlatantMode ~= "BETA" then
                Fishing.stop()
            end

            if v then
                activeBlatantMode = "BETA"
                Fishing.start(true, "BETA")
                local rod, delay, bypass = Fishing.getRodInfo()

                print("✅ BETA Mode Started | Rod: " .. rod)
            else
                activeBlatantMode = nil
                Fishing.stop()

                print("❌ BETA Mode Stopped")
            end
        end
    })

    BETA:Input({
        Title = "BETA Complete Delay",
        Placeholder = "Default: 0.68",
        Value = tostring(Config.Current.FishDelay or 0.68),
        Callback = function(v)
            local n = tonumber(v)
            if n then
                Config.set("FishDelay", n)
                print("✅ FishDelay set to: " .. n)
            else
                print("❌ Invalid number")
            end
        end
    })

    BETA:Input({
        Title = "BETA Catch Delay",
        Placeholder = "Default: 0.34",
        Value = tostring(Config.Current.CatchDelay or 0.34),
        Callback = function(v)
            local n = tonumber(v)
            if n then
                Config.set("CatchDelay", n)
                print("✅ CatchDelay set to: " .. n)
            else
                print("❌ Invalid number")
            end
        end
    })

    Tab:Divider()

    -- ============================================
    -- BLATANT V1 SECTION
    -- ============================================
    local V1 = Tab:Section({ Title = "Blatant V1" })



    V1:Toggle({
        Title = "Enable Blatant V1",
        Value = false,
        Callback = function(v)
            if activeBlatantMode and activeBlatantMode ~= "V1" then
                Fishing.stop()
            end

            if v then
                activeBlatantMode = "V1"
                Fishing.start(true, "V1")
                local rod, delay, bypass = Fishing.getRodInfo()

                print("✅ V1 Mode Started | Rod: " .. rod)
            else
                activeBlatantMode = nil
                Fishing.stop()

                print("❌ V1 Mode Stopped")
            end
        end
    })

    V1:Input({
        Title = "V1 Complete Delay",
        Placeholder = "Default: 0.9",
        Value = "0.9",
        Callback = function(v)
            local n = tonumber(v)
            if n then
                Config.set("FishDelay", n)
                print("✅ V1 FishDelay set to: " .. n)
            end
        end
    })

    V1:Input({
        Title = "V1 Catch Delay",
        Placeholder = "Default: 0.2",
        Value = "0.2",
        Callback = function(v)
            local n = tonumber(v)
            if n then
                Config.set("CatchDelay", n)
                print("✅ V1 CatchDelay set to: " .. n)
            end
        end
    })

    Tab:Divider()

    -- ============================================
    -- BLATANT V2 SECTION
    -- ============================================
    local V2 = Tab:Section({ Title = "Blatant V2" })



    V2:Toggle({
        Title = "Enable Blatant V2",
        Value = false,
        Callback = function(v)
            if activeBlatantMode and activeBlatantMode ~= "V2" then
                Fishing.stop()
            end

            if v then
                activeBlatantMode = "V2"
                Fishing.start(true, "V2")
                local rod, delay, bypass = Fishing.getRodInfo()

                print("✅ V2 Mode Started | Rod: " .. rod)
            else
                activeBlatantMode = nil
                Fishing.stop()

                print("❌ V2 Mode Stopped")
            end
        end
    })

    V2:Input({
        Title = "V2 Complete Delay",
        Placeholder = "Default: 0.9",
        Value = "0.9",
        Callback = function(v)
            local n = tonumber(v)
            if n then
                Config.set("FishDelay", n)
                print("✅ V2 FishDelay set to: " .. n)
            end
        end
    })

    V2:Input({
        Title = "V2 Catch Delay",
        Placeholder = "Default: 0.2",
        Value = "0.2",
        Callback = function(v)
            local n = tonumber(v)
            if n then
                Config.set("CatchDelay", n)
                print("✅ V2 CatchDelay set to: " .. n)
            end
        end
    })

    Tab:Divider()

    -- ============================================
    -- BLATANT V3 SECTION
    -- ============================================
    local V3 = Tab:Section({ Title = "Blatant V3" })


    V3:Toggle({
        Title = "Enable Blatant V3",
        Value = false,
        Callback = function(v)
            if activeBlatantMode and activeBlatantMode ~= "V3" then
                Fishing.stop()
            end

            if v then
                activeBlatantMode = "V3"
                Fishing.start(true, "V3")
                local rod, delay, bypass = Fishing.getRodInfo()

                print("✅ V3 Mode Started | Rod: " .. rod)
            else
                activeBlatantMode = nil
                Fishing.stop()

                print("❌ V3 Mode Stopped")
            end
        end
    })

    V3:Input({
        Title = "V3 Complete Delay",
        Placeholder = "Default: 0.9",
        Value = "0.9",
        Callback = function(v)
            local n = tonumber(v)
            if n then
                Config.set("FishDelay", n)
                print("✅ V3 FishDelay set to: " .. n)
            end
        end
    })

    V3:Input({
        Title = "V3 Catch Delay",
        Placeholder = "Default: 0.2",
        Value = "0.2",
        Callback = function(v)
            local n = tonumber(v)
            if n then
                Config.set("CatchDelay", n)
                print("✅ V3 CatchDelay set to: " .. n)
            end
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
