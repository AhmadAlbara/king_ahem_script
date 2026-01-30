local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Teleport = {}

Teleport.Locations = {
    ["Fisherman Island"]     = Vector3.new(-33, 10, 2770),
    ["Traveling Merchant"]   = Vector3.new(-135, 2, 2764),
    ["Kohana"]               = CFrame.new(-604, 2, 546) * CFrame.Angles(0, math.rad(90), 0),
    ["Kohana Lava"]          = CFrame.new(-592, 59, 127) * CFrame.Angles(0, math.rad(75), 0),
    ["Esoteric Island"]      = Vector3.new(1991, 6, 1390),
    ["Esoteric Depths"]      = CFrame.new(3243, -1302, 1404) * CFrame.Angles(0, math.rad(160), 0),
    ["Tropical Grove"]       = CFrame.new(-2136, 53, 3631) * CFrame.Angles(0, math.rad(120), 0),
    ["Coral Reef"]           = Vector3.new(-3138, 4, 2132),
    ["Weather Machine"]      = Vector3.new(-1517, 3, 1910),
    ["Sisyphus Statue"]      = CFrame.new(-3657, -134, -963) * CFrame.Angles(0, math.rad(100), 0),
    ["Treasure Room"]        = Vector3.new(-3599, -276, -1641),
    ["Ancient Jungle"]       = CFrame.new(1483, 11, -302) * CFrame.Angles(0, math.rad(0), 0),
    ["Ancient Ruin"]         = Vector3.new(6067, -586, 4714),
    ["Sacred Temple"]        = Vector3.new(1498, -22, -640),
    ["Crater Island"]        = CFrame.new(1015, 15, 5097) * CFrame.Angles(0, math.rad(140), 0),
    ["Underground Cellar"]   = Vector3.new(2135, -91, -700),
    ["Pirate Treasure Room"] = Vector3.new(3305, -306, 3080),
    ["Leviatan's Den"]       = CFrame.new(3473, -288, 3473) * CFrame.Angles(0, math.rad(200), 0),
    ["Pirate Cove"]          = CFrame.new(3471, 4, 3442) * CFrame.Angles(0, math.rad(140), 0),
    ["Leviatan Doors"]       = CFrame.new(3448, -288, 3407),
    ["Crystal Depths"]       = CFrame.new(5746, -877, 15376) * CFrame.Angles(0, math.rad(20), 0)
}

function Teleport.to(locationName)
    local targetPos = Teleport.Locations[locationName]
    if not targetPos then return false end

    local success, err = pcall(function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        HRP.AssemblyLinearVelocity = Vector3.zero
        HRP.AssemblyAngularVelocity = Vector3.zero
        local heightOffset = Vector3.new(0, 3, 0)
        if typeof(targetPos) == "Vector3" then
            HRP.CFrame = CFrame.new(targetPos + heightOffset)
        elseif typeof(targetPos) == "CFrame" then
            HRP.CFrame = targetPos + heightOffset
        end
    end)

    return success
end

function Teleport.getLocationNames()
    local names = {}
    for name, _ in pairs(Teleport.Locations) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

return Teleport