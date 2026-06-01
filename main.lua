-- ==========================================
-- سكربت blokspin المطور | نظام الارتفاع البسيط والسرعة 35 المضمونة
-- الرمز السري: WAFI
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("BlokSpinHoverGui") then
    CoreGui:FindFirstChild("BlokSpinHoverGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlokSpinHoverGui"
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

-- زر البقالة التبدلي (Toggle)
local GroceryButton = Instance.new("TextButton")
GroceryButton.Parent = ContentFrame
GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120) -- رمادي افتراضي
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

GroceryButton.MouseButton1Click:Connect(function()
    groceryEnabled = not groceryEnabled
    
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if groceryEnabled then
        -- [ تشغيل -> يقلب أخضر ويطير طيران منخفض ]
        GroceryButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        GroceryButton.Text = "🏪 البقالة: مشغل"
        
        task.spawn(function()
            while groceryEnabled do
                local char = LocalPlayer.Character
                local myHrp = char and char:FindFirstChild("HumanoidRootPart")
                local myHumanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                if myHumanoid and myHrp then
                    local targetPos = Vector3.new(164.98, 254.74, 204.42)
                    
                    -- إذا كان اللاعب بعيد عن البقالة يبدأ التحرك وهو مرتفع قليلاً
                    if (myHrp.Position - targetPos).Magnitude > 5 then
                        local originalRot = myHrp.CFrame - myHrp.Position
                        
                        -- حلقة التحرك بارتفاع بسيط وبسرعة 35 وثبات فوري عند الإطفاء
                        while groceryEnabled do
                            local myPos = myHrp.Position
                            -- تحديد نقطة الهدف مع الحفاظ على ارتفاع بسيط (ارتفاع البقالة + 3 ستد فقط)
                            local hoverTarget = Vector3.new(targetPos.X, targetPos.Y + 3, targetPos.Z)
                            local distance = (hoverTarget - myPos).Magnitude
                            
                            if distance < 3 then break end -- وصلنا فوق النقطة
                            
                            myHrp.Velocity = Vector3.zero -- إلغاء الجاذبية والاندفاع
                            local direction = (hoverTarget - myPos).Unit
                            
                            -- سرعة 35 تعني التحرك بمقدار 0.7 ستد في كل فريم (0.02 ثانية)
                            myHrp.CFrame = CFrame.new(myPos + direction * 0.7) * originalRot
                            task.wait(0.02)
                        end
                        
                        if not groceryEnabled then break end
                        
                        -- النزول فوق طاولة التوظيف بالظبط
                        myHrp.CFrame = CFrame.new(targetPos) * originalRot
                        myHrp.Velocity = Vector3.zero
                    end
                    
                    if not groceryEnabled then break end
                    
                    -- الثبات ومزامنة الموقع لحل مشكلة Validate الحماية البنية
                    myHrp.Velocity = Vector3.zero
                    GroceryButton.Text = "⏳ جاري مزامنة الموقع..."
                    task.wait(1.5)
                    
                    if not groceryEnabled then break end
                    
                    -- البحث عن الزر التلقائي وضغطه بشكل نظامي ومؤكد
                    local foundPrompt = false
                    for _, v in pairs(workspace:GetDescendants()) do
                        if not groceryEnabled then break end
                        if v:IsA("ProximityPrompt") then
                            local promptParent = v.Parent
                            if promptParent and (promptParent:IsA("BasePart") or promptParent:IsA("Model")) then
                                local pPos = promptParent:IsA("Model") and promptParent:GetPivot().Position or promptParent.Position
                                
                                if (pPos - targetPos).Magnitude < 15 then
                                    myHrp.CFrame = CFrame.new(pPos) * CFrame.new(0, 0.5, 0)
                                    task.wait(0.3)
                                    
                                    if fireproximityprompt and groceryEnabled then
                                        fireproximityprompt(v)
                                        task.wait(0.5)
                                        if groceryEnabled then fireproximityprompt(v) end
                                    end
                                    foundPrompt = true
                                    task.wait(1)
                                    break
                                end
                            end
                        end
                    end
                    
                    if foundPrompt then
                        GroceryButton.Text = "✅ تم العمل بنجاح!"
                        task.wait(1.5)
                        if groceryEnabled then GroceryButton.Text = "🏪 البقالة: مشغل" end
                    end
                end
                task.wait(0.5)
            end
        end)
        
    else
        -- [ إطفاء -> يقلب رمادي ويوقف فوراً بمكانه ويطيح ]
        GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        GroceryButton.Text = "🏪 البقالة: مطفأ"
        
        if hrp then
            hrp.Velocity = Vector3.zero -- تصفير الحركة لكي يسقط في مكانه الحالي فوراً
        end
    end
end)

-- ==========================================
-- 3. زر الفتح الدائري (B)
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

CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible = false; OpenCircle.Visible = true end)
OpenCircle.MouseButton1Click:Connect(function() if not dragging then MainFrame.Visible = true; OpenCircle.Visible = false end end)

SubmitButton.MouseButton1Click:Connect(function()
    if KeyInput.Text == "WAFI" then KeyFrame:Destroy(); MainFrame.Visible = true else KeyInput.Text = ""; KeyInput.PlaceholderText = "❌ رمز خاطئ!" end
end)
