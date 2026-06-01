-- ==========================================
-- وافي | قائمة مخصصة خفيفة
-- ميزات: قائمة مربعة، قفل (X)، زر تدوير سحب وإفلات
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- حذف أي واجهة قديمة لتجنب التكرار
if CoreGui:FindFirstChild("WafiGui") then
    CoreGui:FindFirstChild("WafiGui"):Destroy()
end

-- ==========================================
-- 1. إنشاء الواجهة الرئيسية
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WafiGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- القائمة المربعة الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- أسود غامق عصري
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100) -- في منتصف الشاشة
MainFrame.Size = UDim2.new(0, 300, 0, 200) -- مربعة ومتوسطة
MainFrame.Visible = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

-- شريط العنوان (Top Bar)
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- أفتح قليلاً
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 35)

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 10)
UICornerTitle.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "وافي" -- تم التعديل هنا ليكون "وافي" فقط
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
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100) -- أحمر خفيف
CloseButton.TextSize = 20

-- ==========================================
-- 2. محتوى القائمة المربعة (السرعة والقفز)
-- ==========================================
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)

-- زر السرعة (Speed)
local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = ContentFrame
SpeedButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedButton.BorderSizePixel = 0
SpeedButton.Position = UDim2.new(0.1, 0, 0.1, 0)
SpeedButton.Size = UDim2.new(0.8, 0, 0, 40)
SpeedButton.Font = Enum.Font.GothamMedium
SpeedButton.Text = "زيادة السرعة (Speed)"
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.TextSize = 14

local UICornerSpeed = Instance.new("UICorner")
UICornerSpeed.CornerRadius = UDim.new(0, 8)
UICornerSpeed.Parent = SpeedButton

SpeedButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
end)

-- زر القفز (Jump)
local JumpButton = Instance.new("TextButton")
JumpButton.Parent = ContentFrame
JumpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
JumpButton.BorderSizePixel = 0
JumpButton.Position = UDim2.new(0.1, 0, 0.4, 0)
JumpButton.Size = UDim2.new(0.8, 0, 0, 40)
JumpButton.Font = Enum.Font.GothamMedium
JumpButton.Text = "قفزة عالية (Jump)"
JumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpButton.TextSize = 14

local UICornerJump = Instance.new("UICorner")
UICornerJump.CornerRadius = UDim.new(0, 8)
UICornerJump.Parent = JumpButton

JumpButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 120
    end
end)

-- ==========================================
-- 3. إنشاء زر الفتح الدائري القابل للسحب (Minimize Button)
-- ==========================================
local OpenCircle = Instance.new("TextButton")
OpenCircle.Name = "OpenCircle"
OpenCircle.Parent = ScreenGui
OpenCircle.BackgroundColor3 = Color3.fromRGB(255, 60, 60) -- أحمر زاهي
OpenCircle.BorderSizePixel = 0
OpenCircle.Position = UDim2.new(0, 20, 0, 20) -- البداية فوق يسار
OpenCircle.Size = UDim2.new(0, 50, 0, 50) -- دائري
OpenCircle.Visible = false -- مخفي في البداية
OpenCircle.Font = Enum.Font.GothamBold
OpenCircle.Text = "W" -- اختصار وافي
OpenCircle.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCircle.TextSize = 24
OpenCircle.ZIndex = 10 -- دائماً فوق كل شيء

local UICornerCircle = Instance.new("UICorner")
UICornerCircle.CornerRadius = UDim.new(1, 0) -- لجعله دائرة مثالية
UICornerCircle.Parent = OpenCircle

-- ==========================================
-- 4. برمجة السحب والإفلات (Dragging) للدائرة
-- ==========================================
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
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

OpenCircle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- ==========================================
-- 5. برمجة التبديل بين القائمة والزر الدائري
-- ==========================================

-- عند ضغط (X) في القائمة
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenCircle.Visible = true
end)

-- عند ضغط الزر الدائري (الفتـح)
OpenCircle.MouseButton1Click:Connect(function()
    if not dragging then
        MainFrame.Visible = true
        OpenCircle.Visible = false
    end
end)
