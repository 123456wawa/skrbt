-- ==========================================
-- سكربت blokspin المتكامل | نسخة تتبع وطباعة الإحداثيات
-- الرمز السري: WAFI
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("BlokSpinIntegratedGui") then
    CoreGui:FindFirstChild("BlokSpinIntegratedGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlokSpinIntegratedGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==========================================
-- 🛠️ قسم الإحداثيات (هنا تعدل الأرقام اللي تبي اللاعب يمشي عليها)
-- ==========================================
local CustomPath = {
    Vector3.new(180.50, 254.74, 222.00), -- [نقطة 1]: مكان التراجع للشارع الواسع
    Vector3.new(154.00, 254.74, 222.00), -- [نقطة 2]: نقطة اللفة بعيد عن الزاوية
    Vector3.new(154.00, 254.74, 204.42), -- [نقطة 3]: عند باب البقالة
    Vector3.new(164.98, 254.74, 204.42)  -- [نقطة 4]: الإحداثي النهائي عند طاولة التوظيف
}

-- ==========================================
-- 1. قائمة الرمز السري (WAFI)
-- ==========================================
local KeyFrame = Instance.new("Frame")
KeyFrame.Parent = ScreenGui
KeyFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyFrame.Position = UDim2.new(0.5, -140, 0.5, -80)
KeyFrame.Size = UDim2.new(0, 280, 0, 160)

local UICornerKey = Instance.new("UICorner")
UICornerKey.CornerRadius = UDim.new(0, 10)
UICornerKey.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Parent = KeyFrame
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 0, 0, 15)
KeyTitle.Size = UDim2.new(1, 0, 0, 25)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "أدخل الرمز السري لتفعيل السكربت"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 14

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.PlaceholderText = "اكتب الرمز هنا..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14

local UICornerInput = Instance.new("UICorner")
UICornerInput.CornerRadius = UDim.new(0, 6)
UICornerInput.Parent = KeyInput

local SubmitButton = Instance.new("TextButton")
SubmitButton.Parent = KeyFrame
SubmitButton.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
SubmitButton.Position = UDim2.new(0.1, 0, 0.7, 5)
SubmitButton.Size = UDim2.new(0.8, 0, 0, 35)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.Text = "تحقق من الرمز"
SubmitButton.TextColor3 = Color3.fromRGB(30, 30, 30)

local UICornerSubmit = Instance.new("UICorner")
UICornerSubmit.CornerRadius = UDim.new(0, 6)
UICornerSubmit.Parent = SubmitButton

-- ==========================================
-- 2. القائمة الرئيسية المحدثة (blokspin)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -110) -- تم تعديل الحجم والموضع ليتسع للزر الجديد
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Visible = false

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.Size = UDim2.new(1, 0, 0, 35)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "blokspin"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 15, 0, 50)
ContentFrame.Size = UDim2.new(1, -30, 1, -60)

-- زر البقالة (المشي التلقائي عبر الإحداثيات)
local GroceryButton = Instance.new("TextButton")
GroceryButton.Parent = ContentFrame
GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
GroceryButton.Size = UDim2.new(1, 0, 0, 50)
GroceryButton.Font = Enum.Font.GothamBold
GroceryButton.Text = "🏪 البقالة: مطفأ"
GroceryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GroceryButton.TextSize = 15

local UICornerG = Instance.new("UICorner")
UICornerG.CornerRadius = UDim.new(0, 8)
UICornerG.Parent = GroceryButton

-- [الزر الجديد]: زر طباعة الإحداثيات لاستخراج المواقع
local GetCoordsButton = Instance.new("TextButton")
GetCoordsButton.Parent = ContentFrame
GetCoordsButton.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
GetCoordsButton.Position = UDim2.new(0, 0, 0, 65)
GetCoordsButton.Size = UDim2.new(1, 0, 0, 50)
GetCoordsButton.Font = Enum.Font.GothamBold
GetCoordsButton.Text = "📍 طباعة الإحداثي الحالي"
GetCoordsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetCoordsButton.TextSize = 15

local UICornerC = Instance.new("UICorner")
UICornerC.CornerRadius = UDim.new(0, 8)
UICornerC.Parent = GetCoordsButton

local groceryEnabled = false

-- تفعيل الركض تلقائياً
local function pressGameSprint()
    pcall(function()
        local pGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not pGui then return end
        for _, v in pairs(pGui:GetDescendants()) do
            if v:IsA("TextButton") or v:IsA("ImageButton") then
                local nLower = string.lower(v.Name)
                if string.find(nLower, "sprint") or string.find(nLower, "run") then
                    if v.Visible then v:Activate() end
                end
            end
        end
    end)
end

-- ضغطة زر الـ Apply البشرية
local function singleTapGui(button)
    pcall(function()
        if button and button.AbsolutePosition and button.AbsoluteSize then
            local tapX = button.AbsolutePosition.X + (button.AbsoluteSize.X / 2)
            local tapY = button.AbsolutePosition.Y + (button.AbsoluteSize.Y / 2) + 40
            VirtualInputManager:SendMouseButtonEvent(tapX, tapY, 0, true, game, 0)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(tapX, tapY, 0, false, game, 0)
        end
    end)
end

-- ميزة استخراج وطباعة الإحداثيات عند ضغط الزر الأزرق
GetCoordsButton.Activated:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        local myHrp = char and char:FindFirstChild("HumanoidRootPart")
        if myHrp then
            local pos = myHrp.Position
            -- طباعة الإحداثي مهيأ تماماً لتنسخه مباشرة وتضعه في الأعلى
            local formatStr = string.format("Vector3.new(%.2f, %.2f, %.2f),", pos.X, pos.Y, pos.Z)
            print(formatStr)
            GetCoordsButton.Text = "✅ تم طباعة الإحداثي بنجاح!"
            task.wait(1.5)
            GetCoordsButton.Text = "📍 طباعة الإحداثي الحالي"
        else
            GetCoordsButton.Text = "❌ فشل، لم يتم العثور على الشخصية"
            task.wait(1.5)
            GetCoordsButton.Text = "📍 طباعة الإحداثي الحالي"
        end
    end)
end)

-- نظام تتبع الإحداثيات والمشي للبقالة
GroceryButton.Activated:Connect(function()
    groceryEnabled = not groceryEnabled
    
    if groceryEnabled then
        GroceryButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        GroceryButton.Text = "🏃 جاري تتبع الإحداثيات..."
        
        task.spawn(function()
            while groceryEnabled do
                local char = LocalPlayer.Character
                local myHrp = char and char:FindFirstChild("HumanoidRootPart")
                local myHumanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                if myHumanoid and myHrp then
                    -- التنقل بين النقاط المحددة بالترتيب
                    for index, point in pairs(CustomPath) do
                        if not groceryEnabled then break end
                        
                        myHumanoid:MoveTo(point)
                        pressGameSprint()
                        
                        local timeout = 0
                        while (myHrp.Position - point).Magnitude > 3 and timeout < 60 do
                            task.wait(0.05)
                            timeout = timeout + 1
                        end
                    end
                    
                    if not groceryEnabled then break end
                    
                    -- التوقف التام والتوظيف عند النقطة الأخيرة
                    myHumanoid:MoveTo(myHrp.Position)
                    GroceryButton.Text = "⏳ وصلنا للطاولة! جاري التوظيف..."
                    task.wait(1.0)
                    
                    local clicked = false
                    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
                    if pGui then
                        for _, obj in pairs(pGui:GetDescendants()) do
                            if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                                local textL = obj:IsA("TextButton") and string.lower(obj.Text) or ""
                                if string.find(textL, "apply") or string.find(textL, "توظيف") then
                                    if obj.Visible then
                                        singleTapGui(obj)
                                        clicked = true
                                        break
                                    end
                                end
                            end
                        end
                    end
                    
                    if clicked then
                        GroceryButton.Text = "✅ تم التوظيف بنجاح!"
                    else
                        GroceryButton.Text = "❌ لم يتم العثور على زر"
                    end
                    
                    task.wait(2)
                    if groceryEnabled then GroceryButton.Text = "🏪 البقالة: مشغل" end
                end
                task.wait(0.5)
            end
        end)
    else
        GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        GroceryButton.Text = "🏪 البقالة: مطفأ"
    end
end)

-- زر الفتح والإغلاق الدائري (B)
local OpenCircle = Instance.new("TextButton")
OpenCircle.Parent = ScreenGui
OpenCircle.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
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

CloseButton.Activated:Connect(function() MainFrame.Visible = false; OpenCircle.Visible = true end)
OpenCircle.Activated:Connect(function() MainFrame.Visible = true; OpenCircle.Visible = false end)
SubmitButton.Activated:Connect(function() if KeyInput.Text == "WAFI" then KeyFrame:Destroy(); MainFrame.Visible = true else KeyInput.Text = "" end end)
