--[[
    ═══════════════════════════════════════════════════════════════════════
    2K SCRIPT — CYBER NEON OBSIDIAN UI TEMPLATE (PRODUCTION READY)
    Zero Emojis • Pure SVG/Asset Icons • Thick Bold Typography • Animated Neon Glow
    Draggable Floating Toggle • Drag/Click Separation • Full Teardown Support
    ═══════════════════════════════════════════════════════════════════════
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- // 1. CLEANUP PREVIOUS INSTANCES \\ --
local HUB_NAME = "2K_CyberNeon_Hub"
pcall(function()
    if getgenv().TwoKHubInstance then
        getgenv().TwoKHubInstance:Destroy()
        getgenv().TwoKHubInstance = nil
    end
    for _, v in ipairs(CoreGui:GetChildren()) do
        if v.Name == HUB_NAME then v:Destroy() end
    end
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        for _, v in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
            if v.Name == HUB_NAME then v:Destroy() end
        end
    end
end)

-- // 2. COLOR PALETTE \\ --
local THEME = {
    MainBg       = Color3.fromRGB(10, 14, 25),
    SidebarBg    = Color3.fromRGB(12, 17, 30),
    CardBg       = Color3.fromRGB(16, 23, 40),
    CardStroke   = Color3.fromRGB(0, 170, 255),
    RowBg        = Color3.fromRGB(13, 19, 34),
    RowStroke    = Color3.fromRGB(0, 130, 220),
    NeonCyan     = Color3.fromRGB(0, 235, 255),
    NeonBlue     = Color3.fromRGB(0, 130, 255),
    TextWhite    = Color3.fromRGB(255, 255, 255),
    TextCyan     = Color3.fromRGB(140, 225, 255),
    TextMuted    = Color3.fromRGB(170, 195, 230),
    TextDark     = Color3.fromRGB(115, 145, 185),
    ToggleOff    = Color3.fromRGB(28, 38, 60),
    ToggleOn     = Color3.fromRGB(0, 195, 255),
    SliderTrack  = Color3.fromRGB(22, 32, 52),
    SliderFill   = Color3.fromRGB(0, 220, 255)
}

-- // 3. SCREEN GUI \\ --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = HUB_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    pcall(function()
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 5) or LocalPlayer.PlayerGui
    end)
end
getgenv().TwoKHubInstance = ScreenGui

-- // 4. HELPERS \\ --
local function tween(obj, prop, duration, style, dir)
    local t = TweenService:Create(obj, TweenInfo.new(duration or 0.22, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), prop)
    t:Play()
    return t
end

local function makeDraggable(guiObj, dragHandle)
    local dragging = false
    local dragInput, dragStart, startPos
    dragHandle = dragHandle or guiObj

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObj.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObj.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- // 5. FLOATING TOGGLE BUTTON (WITH ROTATING LIGHT BEAM) \\ --
local FloatingBtn = Instance.new("Frame")
FloatingBtn.Name = "FloatingToggleBtn"
FloatingBtn.Size = UDim2.new(0, 64, 0, 64)
FloatingBtn.Position = UDim2.new(0, 20, 0, 140)
FloatingBtn.BackgroundColor3 = THEME.MainBg
FloatingBtn.BorderSizePixel = 0
FloatingBtn.ZIndex = 60
FloatingBtn.Parent = ScreenGui

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatingBtn

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Thickness = 3
FloatStroke.Color = Color3.fromRGB(255, 255, 255)
FloatStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FloatStroke.Parent = FloatingBtn

local FloatGradient = Instance.new("UIGradient")
FloatGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 140, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 16, 28)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 140, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
})
FloatGradient.Rotation = 0
FloatGradient.Parent = FloatStroke

-- Infinite Beam Rotation
task.spawn(function()
    local t = TweenService:Create(FloatGradient, TweenInfo.new(3.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
    t:Play()
end)

makeDraggable(FloatingBtn)

-- // 6. MAIN WINDOW FRAME \\ --
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 760, 0, 480)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = THEME.MainBg
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.6
MainStroke.Color = THEME.CardStroke
MainStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = THEME.SidebarBg
Header.BorderSizePixel = 0
Header.ZIndex = 11
Header.Parent = MainFrame
makeDraggable(MainFrame, Header)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 160, 0, 24)
TitleLabel.Position = UDim2.new(0, 18, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "2K SCRIPT"
TitleLabel.TextColor3 = THEME.TextWhite
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 12
TitleLabel.Parent = Header

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(0, 240, 0, 14)
SubtitleLabel.Position = UDim2.new(0, 18, 0, 30)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Font = Enum.Font.GothamBold
SubtitleLabel.Text = "HIGH-PERFORMANCE SYSTEM"
SubtitleLabel.TextColor3 = THEME.TextDark
SubtitleLabel.TextSize = 9.5
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.ZIndex = 12
SubtitleLabel.Parent = Header

-- Window Controls
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -74, 0.5, -16)
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 28, 48)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "—"
MinBtn.TextColor3 = THEME.TextMuted
MinBtn.TextSize = 14
MinBtn.AutoButtonColor = false
MinBtn.ZIndex = 13
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 18, 28)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 120, 140)
CloseBtn.TextSize = 13
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 13
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Toggle Visibility Logic
local isUIOpen = true
local function toggleWindow()
    isUIOpen = not isUIOpen
    if isUIOpen then
        MainFrame.Visible = true
        tween(MainFrame, {Size = UDim2.new(0, 760, 0, 480), BackgroundTransparency = 0}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    else
        tween(MainFrame, {Size = UDim2.new(0, 700, 0, 440), BackgroundTransparency = 1}, 0.2).Completed:Connect(function()
            if not isUIOpen then MainFrame.Visible = false end
        end)
    end
end

MinBtn.MouseButton1Click:Connect(toggleWindow)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Click vs Drag Separation for Floating Button
local floatClickStart = Vector2.new()
local floatDragDist = 0

FloatingBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        floatClickStart = Vector2.new(input.Position.X, input.Position.Y)
        floatDragDist = 0
    end
end)

FloatingBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local currentPos = Vector2.new(input.Position.X, input.Position.Y)
        floatDragDist = (currentPos - floatClickStart).Magnitude
    end
end)

FloatingBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if floatDragDist < 6 then
            toggleWindow()
        end
    end
end)

-- // 7. SIDEBAR & TABS \\ --
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 210, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = THEME.SidebarBg
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Sidebar.Parent = MainFrame

local TabList = Instance.new("ScrollingFrame")
TabList.Size = UDim2.new(1, -16, 1, -70)
TabList.Position = UDim2.new(0, 8, 0, 10)
TabList.BackgroundTransparency = 1
TabList.ScrollBarThickness = 0
TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabList.ZIndex = 12
TabList.Parent = Sidebar

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 6)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabList

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -210, 1, -50)
ContentArea.Position = UDim2.new(0, 210, 0, 50)
ContentArea.BackgroundTransparency = 1
ContentArea.ClipsDescendants = true
ContentArea.ZIndex = 11
ContentArea.Parent = MainFrame

local tabs = {}

local function createTab(nameTh, nameEn, iconAsset)
    local page = Instance.new("ScrollingFrame")
    page.Name = nameEn .. "_Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = THEME.NeonCyan
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.ZIndex = 12
    page.Parent = ContentArea

    local pagePad = Instance.new("UIPadding")
    pagePad.PaddingTop = UDim.new(0, 14)
    pagePad.PaddingBottom = UDim.new(0, 20)
    pagePad.PaddingLeft = UDim.new(0, 14)
    pagePad.PaddingRight = UDim.new(0, 14)
    pagePad.Parent = page

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 10)
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Parent = page

    -- Tab Button
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 44)
    tabBtn.BackgroundColor3 = THEME.RowBg
    tabBtn.BackgroundTransparency = 1
    tabBtn.AutoButtonColor = false
    tabBtn.Text = ""
    tabBtn.ZIndex = 13
    tabBtn.Parent = TabList

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabBtn

    local tabTitle = Instance.new("TextLabel")
    tabTitle.Size = UDim2.new(1, -24, 0, 18)
    tabTitle.Position = UDim2.new(0, 16, 0, 6)
    tabTitle.BackgroundTransparency = 1
    tabTitle.Font = Enum.Font.GothamBold
    tabTitle.Text = nameTh
    tabTitle.TextColor3 = THEME.TextMuted
    tabTitle.TextSize = 13
    tabTitle.TextXAlignment = Enum.TextXAlignment.Left
    tabTitle.ZIndex = 14
    tabTitle.Parent = tabBtn

    local tabSub = Instance.new("TextLabel")
    tabSub.Size = UDim2.new(1, -24, 0, 12)
    tabSub.Position = UDim2.new(0, 16, 0, 24)
    tabSub.BackgroundTransparency = 1
    tabSub.Font = Enum.Font.GothamBold
    tabSub.Text = nameEn
    tabSub.TextColor3 = THEME.TextDark
    tabSub.TextSize = 9
    tabSub.TextXAlignment = Enum.TextXAlignment.Left
    tabSub.ZIndex = 14
    tabSub.Parent = tabBtn

    local tabData = { Button = tabBtn, Page = page, Title = tabTitle, Sub = tabSub }
    table.insert(tabs, tabData)

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabs) do
            if t.Button == tabBtn then
                t.Page.Visible = true
                tween(t.Button, {BackgroundTransparency = 0.2, BackgroundColor3 = THEME.NeonBlue}, 0.2)
                tween(t.Title, {TextColor3 = THEME.TextWhite}, 0.2)
            else
                t.Page.Visible = false
                tween(t.Button, {BackgroundTransparency = 1, BackgroundColor3 = THEME.RowBg}, 0.2)
                tween(t.Title, {TextColor3 = THEME.TextMuted}, 0.2)
            end
        end
    end)

    return page
end

-- // 8. TOGGLE COMPONENT \\ --
local function addToggle(page, order, titleTh, titleEn, defaultVal, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 48)
    row.BackgroundColor3 = THEME.RowBg
    row.LayoutOrder = order
    row.ZIndex = 13
    row.Parent = page

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 8)
    rowCorner.Parent = row

    local rowStroke = Instance.new("UIStroke")
    rowStroke.Thickness = 1
    rowStroke.Color = THEME.RowStroke
    rowStroke.Transparency = 0.6
    rowStroke.Parent = row

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -80, 0, 20)
    title.Position = UDim2.new(0, 14, 0, 6)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = titleTh
    title.TextColor3 = THEME.TextWhite
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 14
    title.Parent = row

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, -80, 0, 14)
    sub.Position = UDim2.new(0, 14, 0, 26)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.GothamBold
    sub.Text = titleEn
    sub.TextColor3 = THEME.TextCyan
    sub.TextSize = 9.5
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.ZIndex = 14
    sub.Parent = row

    -- Switch
    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0, 44, 0, 24)
    switch.Position = UDim2.new(1, -58, 0.5, -12)
    switch.BackgroundColor3 = defaultVal and THEME.ToggleOn or THEME.ToggleOff
    switch.Text = ""
    switch.AutoButtonColor = false
    switch.ZIndex = 14
    switch.Parent = row

    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1, 0)
    switchCorner.Parent = switch

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = defaultVal and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = THEME.TextWhite
    knob.BorderSizePixel = 0
    knob.ZIndex = 15
    knob.Parent = switch

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local isEnabled = defaultVal
    switch.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        if isEnabled then
            tween(switch, {BackgroundColor3 = THEME.ToggleOn}, 0.18)
            tween(knob, {Position = UDim2.new(1, -21, 0.5, -9)}, 0.18)
        else
            tween(switch, {BackgroundColor3 = THEME.ToggleOff}, 0.18)
            tween(knob, {Position = UDim2.new(0, 3, 0.5, -9)}, 0.18)
        end
        if callback then
            task.spawn(callback, isEnabled)
        end
    end)
end

-- Example setup
local mainTab = createTab("ฟาร์มหลัก", "Main Farming", "")
addToggle(mainTab, 1, "เปิดออโต้ฟาร์ม", "Auto Farm Enabled", false, function(state)
    print("Auto Farm set to:", state)
end)

print("[2K SCRIPT] Hub template loaded successfully!")
