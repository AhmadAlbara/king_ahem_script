local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

return true