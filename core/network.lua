local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Network = {}
Network.Events = {}

function Network.initialize()
    local success, events = pcall(function()
        local net = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net
        return {
            fishing = net:WaitForChild("RE/FishingCompleted"),
            sell = net:WaitForChild("RF/SellAllItems"),
            charge = net:WaitForChild("RF/ChargeFishingRod"),
            minigame = net:WaitForChild("RF/RequestFishingMinigameStarted"),
            cancel = net:WaitForChild("RF/CancelFishingInputs"),
            equip = net:WaitForChild("RE/EquipToolFromHotbar"),
            unequip = net:WaitForChild("RE/UnequipToolFromHotbar"),
            favorite = net:WaitForChild("RE/FavoriteItem")
        }
    end)

    if success then
        Network.Events = events
    end
    return success
end

Network.initialize()

return Network