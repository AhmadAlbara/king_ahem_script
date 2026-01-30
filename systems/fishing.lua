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

-- ============================================
-- ROD DETECTION SYSTEM
-- ============================================
local RodDelaysV2 = {
    ["Ares Rod"] = {custom = 1.12, bypass = 1.45},
    ["Angler Rod"] = {custom = 1.12, bypass = 1.45},
    ["Ghostfinn Rod"] = {custom = 1.12, bypass = 1.45},
    ["Astral Rod"] = {custom = 1.9, bypass = 1.45},
    ["Chrome Rod"] = {custom = 2.3, bypass = 2},
    ["Steampunk Rod"] = {custom = 2.5, bypass = 2.3},
    ["Lucky Rod"] = {custom = 3.5, bypass = 3.6},
    ["Midnight Rod"] = {custom = 3.3, bypass = 3.4},
    ["Demascus Rod"] = {custom = 3.9, bypass = 3.8},
    ["Grass Rod"] = {custom = 3.8, bypass = 3.9},
    ["Luck Rod"] = {custom = 4.2, bypass = 4.1},
    ["Carbon Rod"] = {custom = 4, bypass = 3.8},
    ["Lava Rod"] = {custom = 4.2, bypass = 4.1},
    ["Starter Rod"] = {custom = 4.3, bypass = 4.2},
}

local customDelayV2 = 1
local BypassDelayV2 = 0.5
local detectedRod = nil

local function getValidRodName()
    local player = game:GetService("Players").LocalPlayer
    if not player or not player.PlayerGui then return nil end
    
    local display = player.PlayerGui:FindFirstChild("Backpack")
    if not display then return nil end
    
    display = display:FindFirstChild("Display")
    if not display then return nil end
    
    for _, tile in ipairs(display:GetChildren()) do
        local success, itemNamePath = pcall(function()
            return tile.Inner.Tags.ItemName
        end)
        if success and itemNamePath and itemNamePath:IsA("TextLabel") then
            local name = itemNamePath.Text
            if RodDelaysV2[name] then
                return name
            end
        end
    end
    return nil
end

local function updateDelayBasedOnRod()
    local rodName = getValidRodName()
    if rodName and RodDelaysV2[rodName] then
        customDelayV2 = RodDelaysV2[rodName].custom
        BypassDelayV2 = RodDelaysV2[rodName].bypass
        detectedRod = rodName
        print("✅ Rod Detected: " .. rodName .. " | Delay: " .. customDelayV2 .. "s | Bypass: " .. BypassDelayV2 .. "s")
    else
        customDelayV2 = Config.Current.FishDelay or 0.68
        BypassDelayV2 = Config.Current.CatchDelay or 0.34
        detectedRod = "Unknown"
        print("⚠️ Rod not detected, using default delays")
    end
end

-- ============================================
-- BLATANT BETA MODE (3 reel loops)
-- ============================================
local function blatantLoopBETA()
    while Fishing.isActive and Fishing.useBlatantMode and Fishing.blatantVersion == "BETA" do
        if not Fishing.isFishing then
            Fishing.isFishing = true

            pcall(function()
                if not Network.Events.equip then return end
                
                -- STEP 1: Equip Rod
                Network.Events.equip:FireServer(1)
                task.wait(0.05)
                
                -- STEP 2: Charge Rod (with dual spawn for stability)
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        if Network.Events.minigame then
                            Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                        end
                    end
                end)
                task.wait(0.05)

                -- Redundant charge for stability
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.01)
                        if Network.Events.minigame then
                            Network.Events.minigame:InvokeServer(1.2854545116425, 1)
                        end
                    end
                end)
            end)

            -- STEP 3: Wait for fish to bite
            task.wait(Config.Current.FishDelay or 0.68)

            -- STEP 4: Reel In (BETA = 3 loops)
            for i = 1, 3 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.01)
            end
            
            task.wait(Config.Current.CatchDelay * 0.5 or 0.17)
            Fishing.isFishing = false
        else
            task.wait(0.01)
        end
    end
end

-- ============================================
-- BLATANT V1 MODE (5 reel loops)
-- ============================================
local function blatantLoopV1()
    while Fishing.isActive and Fishing.useBlatantMode and Fishing.blatantVersion == "V1" do
        if not Fishing.isFishing then
            Fishing.isFishing = true

            pcall(function()
                if not Network.Events.equip then return end
                
                -- STEP 1: Equip Rod
                Network.Events.equip:FireServer(1)
                task.wait(0.08)
                
                -- STEP 2: Charge Rod
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.02)
                        if Network.Events.minigame then
                            Network.Events.minigame:InvokeServer(-0.7499996423721313 + math.random(-100, 100) / 1000000, 1)
                        end
                    end
                end)
                task.wait(0.08)

                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.02)
                        if Network.Events.minigame then
                            Network.Events.minigame:InvokeServer(-0.7499996423721313 + math.random(-100, 100) / 1000000, 1)
                        end
                    end
                end)
            end)

            -- STEP 3: Wait for fish to bite (V1 = 0.9s)
            task.wait(0.9)

            -- STEP 4: Reel In (V1 = 5 loops)
            for i = 1, 5 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.01)
            end
            
            task.wait(0.2)
            Fishing.isFishing = false
        else
            task.wait(0.01)
        end
    end
end

-- ============================================
-- BLATANT V2 MODE (7 reel loops)
-- ============================================
local function blatantLoopV2()
    while Fishing.isActive and Fishing.useBlatantMode and Fishing.blatantVersion == "V2" do
        if not Fishing.isFishing then
            Fishing.isFishing = true

            pcall(function()
                if not Network.Events.equip then return end
                
                -- STEP 1: Equip Rod
                Network.Events.equip:FireServer(1)
                task.wait(0.08)
                
                -- STEP 2: Charge Rod dengan perfect cast variation
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.02)
                        if Network.Events.minigame then
                            local x = -0.7499996423721313 + (math.random(-500, 500) / 10000000)
                            local y = 1 + (math.random(-500, 500) / 10000000)
                            Network.Events.minigame:InvokeServer(x, y)
                        end
                    end
                end)
                task.wait(0.08)

                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.02)
                        if Network.Events.minigame then
                            local x = -0.7499996423721313 + (math.random(-500, 500) / 10000000)
                            local y = 1 + (math.random(-500, 500) / 10000000)
                            Network.Events.minigame:InvokeServer(x, y)
                        end
                    end
                end)
            end)

            -- STEP 3: Wait for fish to bite (V2 = 0.9s)
            task.wait(0.9)

            -- STEP 4: Reel In (V2 = 7 loops)
            for i = 1, 7 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.01)
            end
            
            task.wait(0.2)
            Fishing.isFishing = false
        else
            task.wait(0.01)
        end
    end
end

-- ============================================
-- BLATANT V3 MODE (12 reel loops - AGGRESSIVE)
-- ============================================
local function blatantLoopV3()
    while Fishing.isActive and Fishing.useBlatantMode and Fishing.blatantVersion == "V3" do
        if not Fishing.isFishing then
            Fishing.isFishing = true

            pcall(function()
                if not Network.Events.equip then return end
                
                -- STEP 1: Equip Rod
                Network.Events.equip:FireServer(1)
                task.wait(0.10)
                
                -- STEP 2: Charge Rod dengan timing optimal
                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.03)
                        if Network.Events.minigame then
                            local x = -0.7499996423721313 + (math.random(-500, 500) / 10000000)
                            local y = 1 + (math.random(-500, 500) / 10000000)
                            Network.Events.minigame:InvokeServer(x, y)
                        end
                    end
                end)
                task.wait(0.10)

                task.spawn(function()
                    if Network.Events.charge then
                        Network.Events.charge:InvokeServer(1755848498.4834)
                        task.wait(0.03)
                        if Network.Events.minigame then
                            local x = -0.7499996423721313 + (math.random(-500, 500) / 10000000)
                            local y = 1 + (math.random(-500, 500) / 10000000)
                            Network.Events.minigame:InvokeServer(x, y)
                        end
                    end
                end)
            end)

            -- STEP 3: Wait for fish to bite (V3 = 0.9s)
            task.wait(0.9)

            -- STEP 4: Reel In (V3 = 12 loops - VERY AGGRESSIVE)
            for i = 1, 12 do
                pcall(function()
                    if Network.Events.fishing then
                        Network.Events.fishing:FireServer()
                    end
                end)
                task.wait(0.007)  -- Slightly faster interval
            end
            
            task.wait(0.1)
            Fishing.isFishing = false
        else
            task.wait(0.01)
        end
    end
end

-- ============================================
-- MAIN FUNCTIONS
-- ============================================

function Fishing.start(blatantMode, version)
    loadDeps()
    if Fishing.isActive then return end
    
    Fishing.isActive = true
    Fishing.useBlatantMode = blatantMode
    Fishing.blatantVersion = version or "BETA"
    
    updateDelayBasedOnRod()
    
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

function Fishing.updateRodDelay()
    updateDelayBasedOnRod()
    return {
        rod = detectedRod,
        delay = customDelayV2,
        bypass = BypassDelayV2
    }
end

return Fishing