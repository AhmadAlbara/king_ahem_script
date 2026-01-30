local Fishing = {}
Fishing.isActive = false
Fishing.isFishing = false
Fishing.useBlatantMode = false
Fishing.blatantVersion = "BETA" -- BETA, V1, V2, V3

local Config, Network

local function loadDeps()
    if not Config then
        Config = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/core/config.lua"))()
    end
    if not Network then
        Network = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/AhmadAlbara/king_ahem_script/main/core/network.lua"))()
    end
end

local function blatantLoopBETA()
    while Fishing.isActive and Fishing.useBlatantMode and Fishing.blatantVersion == "BETA" do
        if not Fishing.isFishing then
            Fishing.isFishing = true

            pcall(function()
                if not Network.Events.equip then return end
                Network.Events.equip:FireServer(1)
                task.wait(0.01)
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
                task.wait(0.05)

                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
            end)

            task.wait(Config.Current.FishDelay)

            for i = 1, 3 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.01)
            end
            task.wait(Config.Current.CatchDelay * 0.5)
            Fishing.isFishing = false
        else
            task.wait(0.01)
        end
    end
end

local function blatantLoopV1()
    while Fishing.isActive and Fishing.useBlatantMode and Fishing.blatantVersion == "V1" do
        if not Fishing.isFishing then
            Fishing.isFishing = true

            pcall(function()
                if not Network.Events.equip then return end
                Network.Events.equip:FireServer(1)
                task.wait(0.01)
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
                task.wait(0.05)

                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
            end)

            task.wait(Config.Current.FishDelay)

            for i = 1, 5 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.01)
            end
            task.wait(Config.Current.CatchDelay * 0.5)
            Fishing.isFishing = false
        else
            task.wait(0.01)
        end
    end
end

local function blatantLoopV2()
    while Fishing.isActive and Fishing.useBlatantMode and Fishing.blatantVersion == "V2" do
        if not Fishing.isFishing then
            Fishing.isFishing = true

            pcall(function()
                if not Network.Events.equip then return end
                Network.Events.equip:FireServer(1)
                task.wait(0.01)
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
                task.wait(0.05)

                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
            end)

            task.wait(Config.Current.FishDelay)

            for i = 1, 7 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.01)
            end
            task.wait(Config.Current.CatchDelay * 0.5)
            Fishing.isFishing = false
        else
            task.wait(0.01)
        end
    end
end

local function blatantLoopV3()
    while Fishing.isActive and Fishing.useBlatantMode and Fishing.blatantVersion == "V3" do
        if not Fishing.isFishing then
            Fishing.isFishing = true

            pcall(function()
                if not Network.Events.equip then return end
                Network.Events.equip:FireServer(1)
                task.wait(0.01)
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
                task.wait(0.05)

                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                    end
                end)
            end)

            task.wait(Config.Current.FishDelay)

            for i = 1, 12 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.01)
            end
            task.wait(Config.Current.CatchDelay * 0.5)
            Fishing.isFishing = false
        else
            task.wait(0.01)
        end
    end
end

function Fishing.start(blatantMode, version)
    loadDeps()
    if Fishing.isActive then return end
    Fishing.isActive = true
    Fishing.useBlatantMode = blatantMode
    Fishing.blatantVersion = version or "BETA"
    
    task.spawn(function()
        while Fishing.isActive do
            if Fishing.useBlatantMode then
                if Fishing.blatantVersion == "BETA" then
                    blatantLoopBETA()
                elseif Fishing.blatantVersion == "V1" then
                    blatantLoopV1()
                elseif Fishing.blatantVersion == "V2" then
                    blatantLoopV2()
                elseif Fishing.blatantVersion == "V3" then
                    blatantLoopV3()
                end
            end
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

function Fishing.setVersion(version)
    if version == "BETA" or version == "V1" or version == "V2" or version == "V3" then
        Fishing.blatantVersion = version
    end
end

return Fishing