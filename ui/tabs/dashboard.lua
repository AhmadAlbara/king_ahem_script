local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/core/config.lua"))()
local Fishing = loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/systems/fishing.lua"))()

local Dashboard = {}

function Dashboard.load(Window)
    local Tab = Window:Tab({Title = "Dashboard", Icon = "layout-dashboard"})
    
    Tab:Paragraph({Title = "Dashboard", Desc = "Fast & Stable Auto Fishing with Blatant Mode"})
    Tab:Divider()
    
    local V1 = Tab:Section({Title = "Blatant V1"})
    
    V1:Toggle({
        Title = "Enable Blatant V1",
        Value = Config.Current.BlatantMode,
        Callback = function(v)
            Config.set("BlatantMode", v)
            Fishing.setBlatantMode(v)
            Config.set("AutoFish", v)
            if v then
                Fishing.start(Config.Current.BlatantMode)
            else
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
    
    local PerformanceHUD = require(script.Parent.Parent.Parent:FindFirstChild("features"):FindFirstChild("PerformanceHUD"))
    Tab:Toggle({
        Title = "📊 Performance HUD",
        Desc = "Show FPS, Ping, and Memory usage",
        Value = false,
        Callback = function(v)
            PerformanceHUD.toggle(v)
        end
    })
end

return Dashboard