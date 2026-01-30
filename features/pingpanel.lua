-- placeholder
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local PerformanceHUD = {}
local HudState = {
    Visible = false,
    Dragging = false,
    DragStart = Vector2.zero,
    StartPos = UDim2.new(0, 20, 0, 140)
}

local Gui = Instance.new("ScreenGui")
Gui.Name = "KING_AHEM_PerformanceHUD"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui
Gui.Enabled = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(240, 100)
Frame.Position = HudState.StartPos
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Frame.BackgroundTransparency = 0.12
Frame.BorderSizePixel = 0
Frame.Parent = Gui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 32)
Header.BackgroundTransparency = 1
Header.Parent = Frame

local Content = Instance.new("TextLabel")
Content.Position = UDim2.fromOffset(12, 36)
Content.Size = UDim2.new(1, -24, 1, -40)
Content.BackgroundTransparency = 1
Content.TextXAlignment = Enum.TextXAlignment.Left
Content.TextYAlignment = Enum.TextYAlignment.Top
Content.Font = Enum.Font.Gotham
Content.TextSize = 13
Content.TextColor3 = Color3.fromRGB(230, 230, 230)
Content.TextWrapped = true
Content.Text = "Loading..."
Content.Parent = Frame

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        HudState.Dragging = true
        HudState.DragStart = input.Position
        HudState.StartPos = Frame.Position
    end
end)

Header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        HudState.Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if HudState.Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - HudState.DragStart
        Frame.Position = UDim2.new(
            HudState.StartPos.X.Scale,
            HudState.StartPos.X.Offset + delta.X,
            HudState.StartPos.Y.Scale,
            HudState.StartPos.Y.Offset + delta.Y
        )
    end
end)

local fps = 0
local frameCount = 0
local lastTick = os.clock()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = os.clock()
    if now - lastTick >= 1 then
        fps = frameCount
        frameCount = 0
        lastTick = now
    end
end)

task.spawn(function()
    while true do
        if HudState.Visible then
            local ping = 0
            pcall(function()
                ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            end)
            local memory = math.floor(Stats:GetTotalMemoryUsageMb())
            Content.Text = string.format("FPS    : %d\nPing   : %d ms\nMemory : %d MB", fps, ping, memory)
        end
        task.wait(0.5)
    end
end)

function PerformanceHUD.toggle(state)
    HudState.Visible = state
    Gui.Enabled = state
end

return PerformanceHUD