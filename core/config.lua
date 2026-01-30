
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Config = {}
local CONFIG_FOLDER = "ahem_configs"
local CONFIG_FILE = CONFIG_FOLDER .. "/config_" .. LocalPlayer.UserId .. ".json"

Config.Defaults = {
    AutoSell = false,
    BlatantMode = false,
    FishDelay = 0.68,
    CatchDelay = 0.34,
    SellDelay = 100,
    TeleportLocation = "Sisyphus Statue",
    FavoriteRarity = "Mythic"
}
Config.Current = {}
for k, v in pairs(Config.Defaults) do
    Config.Current[k] = v
end

local function ensureConfigFolder()
    if not isfolder or not makefolder then return false end
    if not isfolder(CONFIG_FOLDER) then
        pcall(function() makefolder(CONFIG_FOLDER) end)
    end
    return isfolder(CONFIG_FOLDER)
end

function Config.load()
    if not readfile or not isfile or not isfile(CONFIG_FILE) then return false end
    local success = pcall(function()
        local data = HttpService:JSONDecode(readfile(CONFIG_FILE))
        for k, v in pairs(data) do
            if Config.Defaults[k] ~= nil then
                Config.Current[k] = v
            end
        end
    end)
    return success
end

function Config.save()
    if not writefile or not ensureConfigFolder() then return false end
    local success = pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode(Config.Current))
    end)
    return success
end

function Config.get(key)
    return Config.Current[key]
end

function Config.set(key, value)
    if Config.Defaults[key] == nil then return false end
    Config.Current[key] = value
    Config.save()
    return true
end

Config.load()

return Config