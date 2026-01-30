
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "KING AHEM",
    Icon = "crown",
    Author = "Ahmad Albara",
    Folder = "KING_AHEM",
    Size = UDim2.fromOffset(650, 480),
    Theme = "Dark",
    Transparent = true,
    Resizable = false
})

-- Load tabs
local DashboardTab = require(script.Parent:FindFirstChild("tabs"):FindFirstChild("Dashboard"))
local SellTab = require(script.Parent:FindFirstChild("tabs"):FindFirstChild("AutoSell"))
local TeleportTab = require(script.Parent:FindFirstChild("tabs"):FindFirstChild("Teleport"))
local InfoTab = require(script.Parent:FindFirstChild("tabs"):FindFirstChild("Info"))

DashboardTab.load(Window)
SellTab.load(Window)
TeleportTab.load(Window)
InfoTab.load(Window)



WindUI:Notify({Title = "KING AHEM", Content = "Loaded Successfully - All systems ready!", Duration = 5, Icon = "crown"})

-- FLOATING BUTTON
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AUTOFISH_FLOATING_BUTTON"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = CoreGui

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingToggleButton"
FloatingButton.Size = UDim2.fromOffset(50, 50)
FloatingButton.Position = UDim2.new(0.05, 0, 0.5, 0)
FloatingButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://7229442422"
FloatingButton.ImageColor3 = Color3.new(1, 1, 1)
FloatingButton.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1, 0)
Corner.Parent = FloatingButton

local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 0, 1, 0)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.5
Shadow.BorderSizePixel = 0
Shadow.ZIndex = FloatingButton.ZIndex - 1
Shadow.Parent = FloatingButton

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(1, 0)
ShadowCorner.Parent = Shadow

FloatingButton.MouseEnter:Connect(function()
    TweenService:Create(FloatingButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(60, 60)}):Play()
    TweenService:Create(FloatingButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(0, 220, 120)}):Play()
end)

FloatingButton.MouseLeave:Connect(function()
    TweenService:Create(FloatingButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(50, 50)}):Play()
    TweenService:Create(FloatingButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
end)

local debounce = false
FloatingButton.MouseButton1Click:Connect(function()
    if debounce then return end
    debounce = true
    Window:Toggle()
    task.delay(0.3, function() debounce = false end)
end)

local dragging = false
local dragStart = nil
local startPos = nil
local targetPos = FloatingButton.Position

FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = FloatingButton.Position
    end
end)

FloatingButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and dragStart and startPos then
        local delta = input.Position - dragStart
        targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

RunService.RenderStepped:Connect(function()
    if FloatingButton.Parent then
        FloatingButton.Position = FloatingButton.Position:Lerp(targetPos, 0.15)
    end
end)

local function createTooltip()
    local Tooltip = Instance.new("TextLabel")
    Tooltip.Name = "Tooltip"
    Tooltip.Size = UDim2.fromOffset(150, 50)
    Tooltip.Position = UDim2.new(0, 60, 0, -10)
    Tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Tooltip.TextColor3 = Color3.new(1, 1, 1)
    Tooltip.TextSize = 14
    Tooltip.Text = "Click to toggle\nDrag to move"
    Tooltip.Font = Enum.Font.GothamMedium
    Tooltip.BorderSizePixel = 0
    Tooltip.BackgroundTransparency = 0.1
    Tooltip.Visible = false
    Tooltip.Parent = FloatingButton
    local TooltipCorner = Instance.new("UICorner")
    TooltipCorner.CornerRadius = UDim.new(0, 6)
    TooltipCorner.Parent = Tooltip
    return Tooltip
end

local Tooltip = createTooltip()

FloatingButton.MouseEnter:Connect(function()
    TweenService:Create(Tooltip, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3}):Play()
    Tooltip.Visible = true
end)

FloatingButton.MouseLeave:Connect(function()
    TweenService:Create(Tooltip, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
    Tooltip.Visible = false
end)

Window:OnDestroy(function()
    ScreenGui:Destroy()
end)

return true