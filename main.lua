-- ==========================================
-- السكربت المطور | blokspin
-- ميزات: قائمة مربعة، قفل (X)، زر دائري (B)، زر نقزة وزر نطة فورية
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- حذف أي واجهة قديمة لتجنب التكرار
if CoreGui:FindFirstChild("BlokSpinGui") then
    CoreGui:FindFirstChild("BlokSpinGui"):Destroy()
end

-- ==========================================
-- 1. إنشاء الواجهة الرئيسية
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlokSpinGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- القائمة المربعة الرئيسية (تم زيادة الارتفاع لتناسب الأزرار)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- أسود غامق عصري
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125) -- في منتصف الشاشة
MainFrame.Size = UDim2.new(0, 300, 0, 250) -- حجم مربع ممتاز
MainFrame.Visible = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

-- شريط العنوان (Top Bar)
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
TitleLabel.Text = "blokspin" -- تم تغيير الاسم هنا
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

-- ترتيب الأزرار تلقائياً لمنع اللخبطة
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 15, 0, 45)
ContentFrame.Size = UDim2.new(1, -30, 1, -55)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ContentFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- تجميل الأزرار تلقائياً
local function styleButton(btn, text)
    btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
end

-- [1] زر زيادة السرعة
local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = ContentFrame
styleButton(SpeedButton, "زيادة السرعة (Speed)")
SpeedButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
end)

-- [2] زر النقزة العالية
local JumpButton = Instance.new("TextButton")
JumpButton.Parent = ContentFrame
styleButton(JumpButton, "تفعيل النقزة العالية (Jump Power)")
JumpButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 130
    end
end)

-- [3] زر النطة الفورية (اضغطه يرفعك فوق علطول)
local HopButton = Instance.new("TextButton")
HopButton.Parent = ContentFrame
styleButton(HopButton, "💥 نطة فورية للاعلى (اضغط هنا) 💥")
HopButton.BackgroundColor3 = Color3.fromRGB(40, 80, 150) -- لون مميز للضغط
HopButton.MouseButton1Click:Connect(function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Velocity = Vector3.new(hrp.Velocity.X, 140, hrp.Velocity.Z) -- دفعة قوية للأعلى
    end
end)

-- [4] زر إرجاع الوضع الطبيعي
local ResetButton = Instance.new("TextButton")
ResetButton.Parent = ContentFrame
styleButton(ResetButton, "إرجاع الوضع الطبيعي")
ResetButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
ResetButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

-- ==========================================
-- 3. إنشاء زر الفتح الدائري القابل للسحب (B)
-- ==========================================
local OpenCircle = Instance.new("TextButton")
OpenCircle.Name = "OpenCircle"
OpenCircle.Parent = ScreenGui
OpenCircle.BackgroundColor3 = Color3.fromRGB(70, 180, 70) -- لون أخضر فخم للزر الدائري
OpenCircle.BorderSizePixel = 0
OpenCircle.Position = UDim2.new(0, 20, 0, 20)
OpenCircle.Size = UDim2.new(0, 55, 0, 55)
OpenCircle.Visible = false
OpenCircle.Font = Enum.Font.GothamBold
OpenCircle.Text = "B" -- اختصار Blokspin
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
