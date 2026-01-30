local Fishing = {}
Fishing.isActive = false
Fishing.isFishing = false
Fishing.useBlatantMode = false

local Config, Network

local function loadDeps()
    if not Config then
        Config = require(script.Parent.Parent:FindFirstChild("core"):FindFirstChild("Config"))
    end
    if not Network then
        Network = require(script.Parent.Parent:FindFirstChild("core"):FindFirstChild("Network"))
    end
end

local function castRod()
    pcall(function()
        if not Network.Events.equip then return end
        Network.Events.equip:FireServer(1)
        task.wait(0.05)
        Network.Events.charge:InvokeServer(1755848498.4834)
        task.wait(0.02)
        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
    end)
end

local function reelIn()
    pcall(function()
        if not Network.Events.fishing then return end
        Network.Events.fishing:FireServer()
    end)
end

local function blatantLoop()
    while Fishing.isActive and Fishing.useBlatantMode do
        if not Fishing.isFishing then
            Fishing.isFishing = true
            
            pcall(function()
                if not Network.Events.equip then return end
                Network.Events.equip:FireServer(1)
                task.wait(0.005)
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.02)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
                task.wait(0.06)
            end)
            
            task.wait(Config.Current.FishDelay)
            for i = 1, 15 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.01)
            end
            task.wait(Config.Current.CatchDelay * 0.12)
            Fishing.isFishing = false
        else
            task.wait(0.04)
        end
    end
end

local function normalLoop()
    while Fishing.isActive and not Fishing.useBlatantMode do
        if not Fishing.isFishing then
            Fishing.isFishing = true
            castRod()
            task.wait(Config.Current.FishDelay)
            reelIn()
            task.wait(Config.Current.CatchDelay)
            Fishing.isFishing = false
        else
            task.wait(0.1)
        end
    end
end

function Fishing.start(blatantMode)
    loadDeps()
    if Fishing.isActive then return end
    Fishing.isActive = true
    Fishing.useBlatantMode = blatantMode
    task.spawn(function()
        while Fishing.isActive do
            if Fishing.useBlatantMode then blatantLoop() else normalLoop() end
            task.wait(0.1)
        end
    end)
end

function Fishing.stop()
    Fishing.isActive = false
    Fishing.isFishing = false
end

function Fishing.setBlatantMode(enabled)
    Fishing.useBlatantMode = enabled
end

return Fishing