-- ==========================================
-- سكربت blokspin الإعجازي | نظام اختراق الجدران والكبس البشري الحقيقي
-- الرمز السري: WAFI
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager") -- محاكي الضغط الحقيقي
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("BlokSpinGodGui") then
    CoreGui:FindFirstChild("BlokSpinGodGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlokSpinGodGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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
-- 2. القائمة الرئيسية (blokspin)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.Size = UDim2.new(0, 300, 0, 130)
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
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

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

local GroceryButton = Instance.new("TextButton")
GroceryButton.Parent = ContentFrame
GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
GroceryButton.BorderSizePixel = 0
GroceryButton.Size = UDim2.new(1, 0, 0, 50)
GroceryButton.Font = Enum.Font.GothamBold
GroceryButton.Text = "🏪 البقالة: مطفأ"
GroceryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GroceryButton.TextSize = 15

local UICornerG = Instance.new("UICorner")
UICornerG.CornerRadius = UDim.new(0, 8)
UICornerG.Parent = GroceryButton

local groceryEnabled = false
local noclipConnection = nil

-- دالة المحاكاة الفوق-بشرية لضغط زر الشاشة (ترسل نقرة حقيقية بإحداثيات الشاشة)
local function humanClickGui(button)
    pcall(function()
        if button and button.AbsolutePosition and button.AbsoluteSize then
            local clickX = button.AbsolutePosition.X + (button.AbsoluteSize.X / 2)
            local clickY = button.AbsolutePosition.Y + (button.AbsoluteSize.Y / 2) + 40 -- تعويض شريط روبلوكس العلوي
            
            VirtualInputManager:SendMouseButtonEvent(clickX, clickY, 0, true, game, 0)
            task.wait(0.02)
            VirtualInputManager:SendMouseButtonEvent(clickX, clickY, 0, false, game, 0)
        end
    end)
end

GroceryButton.Activated:Connect(function()
    groceryEnabled = not groceryEnabled
    
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if groceryEnabled then
        GroceryButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        GroceryButton.Text = "🏪 البقالة: مشغل"
        
        -- [ تفعيل نظام تخطي واختراق الجدران (Noclip) فوراً ]
        noclipConnection = RunService.Stepped:Connect(function()
            if not groceryEnabled then return end
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
        
        task.spawn(function()
            while groceryEnabled do
                local char = LocalPlayer.Character
                local myHrp = char and char:FindFirstChild("HumanoidRootPart")
                local myHumanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                if myHumanoid and myHrp then
                    local targetPos = Vector3.new(164.98, 254.74, 204.42)
                    
                    -- [ الطيران المخترق للجدران بارتفاع بسيط وسرعة 35 ]
                    if (myHrp.Position - targetPos).Magnitude > 5 then
                        local originalRot = myHrp.CFrame - myHrp.Position
                        
                        while groceryEnabled do
                            local myPos = myHrp.Position
                            -- مرتفع تكتين عن الأرض (3 ستد) عشان يطوف فوق الأرصفة والسيارات
                            local hoverTarget = Vector3.new(targetPos.X, targetPos.Y + 3, targetPos.Z)
                            local distance = (hoverTarget - myPos).Magnitude
                            
                            if distance < 3 then break end
                            
                            myHrp.Velocity = Vector3.zero
                            local direction = (hoverTarget - myPos).Unit
                            -- سرعة 35 بالملي
                            myHrp.CFrame = CFrame.new(myPos + direction * 0.7) * originalRot
                            task.wait(0.02)
                        end
                        
                        if not groceryEnabled then break end
                        -- السقوط المباشر فوق النقطة تماماً للتثبيت
                        myHrp.CFrame = CFrame.new(targetPos) * originalRot
                        myHrp.Velocity = Vector3.zero
                    end
                    
                    if not groceryEnabled then break end
                    
                    myHrp.Velocity = Vector3.zero
                    GroceryButton.Text = "⚡ جاري التوظيف غصب (نقرات بشرية)..."
                    task.wait(1.0) -- انتظار المزامنة لمنع طرد الحماية
                    
                    if not groceryEnabled then break end
                    
                    -- [ هجوم كبس الأزرار الانتحاري والمحاكاة الحقيقية ]
                    for round = 1, 10 do
                        if not groceryEnabled then break end
                        
                        -- 1. كبس زر الشاشة Apply الأخضر بنقرات ماوس حقيقية محاكية للبشر
                        local pGui = LocalPlayer:FindFirstChild("PlayerGui")
                        if pGui then
                            for _, v in pairs(pGui:GetDescendants()) do
                                if v:IsA("TextButton") or v:IsA("ImageButton") then
                                    local nLower = string.lower(v.Name)
                                    local tLower = v:IsA("TextButton") and string.lower(v.Text) or ""
                                    
                                    if string.find(nLower, "apply") or string.find(tLower, "apply") or 
                                       string.find(nLower, "job") or string.find(tLower, "job") or
                                       string.find(nLower, "توظيف") or string.find(tLower, "توظيف") then
                                        if v.Visible then
                                            humanClickGui(v) -- يضغط بمنتصف الزر غصب كأنه إصبع حقيقي
                                        end
                                    end
                                end
                            end
                        end
                        
                        -- 2. تفعيل أي أزرار ملموسة محيطة بالطاولة (ProximityPrompt)
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") then
                                local pParent = obj.Parent
                                if pParent and pParent:IsA("BasePart") and (pParent.Position - targetPos).Magnitude < 15 then
                                    if fireproximityprompt then fireproximityprompt(obj) end
                                end
                            elseif obj:IsA("ClickDetector") then
                                local dParent = obj.Parent
                                if dParent and dParent:IsA("BasePart") and (dParent.Position - targetPos).Magnitude < 15 then
                                    if fireclickdetector then fireclickdetector(obj) end
                                end
                            end
                        end
                        
                        task.wait(0.2)
                    end
                    
                    GroceryButton.Text = "✅ انتهت محاولة التوظيف!"
                    task.wait(1.5)
                    if groceryEnabled then GroceryButton.Text = "🏪 البقالة: مشغل" end
                end
                task.wait(0.5)
            end
        end)
        
    else
        GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        GroceryButton.Text = "🏪 البقالة: مطفأ"
        
        -- إطفاء نظام النوكليب فوراً ليعود اللاعب طبيعي ويقع على الأرض
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if hrp then hrp.Velocity = Vector3.zero end
    end
end)

-- ==========================================
-- 3. زر الفتح الدائري (B) وقائمة كلمة السر
-- ==========================================
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

local dragging = false
local dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    OpenCircle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
OpenCircle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = OpenCircle.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
OpenCircle.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

CloseButton.Activated:Connect(function() MainFrame.Visible = false; OpenCircle.Visible = true end)
OpenCircle.Activated:Connect(function() if not dragging then MainFrame.Visible = true; OpenCircle.Visible = false end end)

SubmitButton.Activated:Connect(function()
    if KeyInput.Text == "WAFI" then KeyFrame:Destroy(); MainFrame.Visible = true else KeyInput.Text = ""; KeyInput.PlaceholderText = "❌ رمز خاطئ!" end
end)
