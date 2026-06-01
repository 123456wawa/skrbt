-- ==========================================
-- سكربت blokspin المطور | نظام أزرار ذكي (Toggle)
-- ميزات: أخضر = شغال، رمادي = طافي
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- حذف أي واجهة قديمة لتجنب التكرار
if CoreGui:FindFirstChild("BlokSpinToggleGui") then
    CoreGui:FindFirstChild("BlokSpinToggleGui"):Destroy()
end

-- ==========================================
-- 1. إنشاء الواجهة الرئيسية
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlokSpinToggleGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- أسود غامق
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 180) -- حجم متناسق ومربع
MainFrame.Visible = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

-- شريط العنوان
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 35)

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 10)
UICornerTitle.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "blokspin"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- زر الإغلاق (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 20

-- حاوية الأزرار
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 15, 0, 50)
ContentFrame.Size = UDim2.new(1, -30, 1, -60)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ContentFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)

-- متغيرات تتبع حالة الأزرار (طافي في البداية)
local speedEnabled = false
local jumpEnabled = false

-- وظيفة لتصميم الأزرار بشكل افتراضي (رمادي غامق)
local function styleButton(btn, text)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- لون رمادي (طافي)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
end

-- [1] زر تشغيل/إطفاء السرعة
local SpeedToggle = Instance.new("TextButton")
SpeedToggle.Parent = ContentFrame
styleButton(SpeedToggle, "الركض السريع: معطل 🛑")

SpeedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled -- عكس الحالة الحالية
    if speedEnabled then
        SpeedToggle.BackgroundColor3 = Color3.fromRGB(46, 204, 113) -- يقلب أخضر
        SpeedToggle.Text = "الركض السريع: مشغل ✅"
    else
        SpeedToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- يرجع رمادي
        SpeedToggle.Text = "الركض السريع: معطل 🛑"
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- إرجاع للسرعة الطبيعية فوراً
        end
    end
end)

-- [2] زر تشغيل/إطفاء النقزة
local JumpToggle = Instance.new("TextButton")
JumpToggle.Parent = ContentFrame
styleButton(JumpToggle, "النقزة العالية: معطل 🛑")

JumpToggle.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled -- عكس الحالة الحالية
    if jumpEnabled then
        JumpToggle.BackgroundColor3 = Color3.fromRGB(46, 204, 113) -- يقلب أخضر
        JumpToggle.Text = "النقزة العالية: مشغل ✅"
    else
        JumpToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- يرجع رمادي
        JumpToggle.Text = "النقزة العالية: معطل 🛑"
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 50 -- إرجاع للنقزة الطبيعية فوراً
        end
    end
end)

-- [لوب داخلي مستمر] لتطبيق الميزات بدون ما تخرب عليك اللعبة عند المشي أو الترسيت
task.spawn(function()
    while true do
        task.wait(0.1)
        if speedEnabled then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 100
            end
        end
        if jumpEnabled then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = 130
            end
        end
    end
end)

-- ==========================================
-- 3. زر الفتح الدائري (B)
-- ==========================================
local OpenCircle = Instance.new("TextButton")
OpenCircle.Name = "OpenCircle"
OpenCircle.Parent = ScreenGui
OpenCircle.BackgroundColor3 = Color3.fromRGB(46, 204, 113) -- أخضر فخم للزر الدائري
OpenCircle.BorderSizePixel = 0
OpenCircle.Position = UDim2.new(0, 20, 0, 20)
OpenCircle.Size = UDim2.new(0, 55, 0, 55)
OpenCircle.Visible = false
OpenCircle.Font = Enum.Font.GothamBold
OpenCircle.Text = "B"
OpenCircle.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCircle.TextSize = 24
OpenCircle.ZIndex = 10

local UICornerCircle = Instance.new("UICorner")
UICornerCircle.CornerRadius = UDim.new(1, 0)
UICornerCircle.Parent = OpenCircle

-- برمجة السحب والإفلات للدائرة
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    OpenCircle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

OpenCircle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = OpenCircle.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

OpenCircle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- برمجة التبديل والـ X
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenCircle.Visible = true
end)

OpenCircle.MouseButton1Click:Connect(function()
    if not dragging then
        MainFrame.Visible = true
        OpenCircle.Visible = false
    end
end)

