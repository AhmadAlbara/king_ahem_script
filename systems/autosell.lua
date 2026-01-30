local AutoSell = {}
AutoSell.isActive = false

local Config, Network

local function loadDeps()
    if not Config then
        Config = require(script.Parent.Parent:FindFirstChild("core"):FindFirstChild("config"))
    end
    if not Network then
        Network = require(script.Parent.Parent:FindFirstChild("core"):FindFirstChild("network"))
    end
end

local function performSell()
    local sellSuccess = pcall(function()
        if Network.Events.sell then
            Network.Events.sell:InvokeServer()
            task.wait(0.05)
            Network.Events.sell:InvokeServer()
        end
    end)
    return sellSuccess
end

task.spawn(function()
    loadDeps()
    while true do
        task.wait(Config.Current.SellDelay)
        if AutoSell.isActive then
            performSell()
        end
    end
end)

function AutoSell.enable()
    AutoSell.isActive = true
end

function AutoSell.disable()
    AutoSell.isActive = false
end

function AutoSell.sellNow()
    performSell()
end

return AutoSell