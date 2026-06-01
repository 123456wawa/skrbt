-- ==========================================
-- سكربت blokspin المطور | نظام المشي في الجو (Air Float)، الإيقاف الفوري، والتوظيف الذكي
-- الرمز السري: WAFI
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("BlokSpinAirGui") then
    CoreGui:FindFirstChild("BlokSpinAirGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlokSpinAirGui"
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

-- زر البقالة (Toggle)
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
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if groceryEnabled then
        -- [ تشغيل -> يقلب أخضر ]
        GroceryButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        GroceryButton.Text = "🏪 البقالة: مشغل"
        
        task.spawn(function()
            while groceryEnabled do
                local char = LocalPlayer.Character
                local myHrp = char and char:FindFirstChild("HumanoidRootPart")
                local myHumanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                if myHumanoid and myHrp then
                    local targetPos = Vector3.new(164.98, 254.74, 204.42)
                    
                    if (myHrp.Position - targetPos).Magnitude > 8 then
                        -- حفظ زاوية دوران اللاعب عشان يمشي وهو واقف مستقيم
                        local originalRot = myHrp.CFrame - myHrp.Position
                        
                        -- 1. الارتفاع في الجو أولاً لتفادي المباني
                        local flyHeight = math.max(myHrp.Position.Y, targetPos.Y) + 35
                        while groceryEnabled and myHrp.Position.Y < flyHeight do
                            myHrp.Velocity = Vector3.zero
                            myHrp.CFrame = CFrame.new(myHrp.Position + Vector3.new(0, 2.5, 0)) * originalRot
                            task.wait(0.02)
                        end
                        
                        -- 2. الطيران الأفقي في الهواء نحو إحداثيات البقالة بالضبط
                        while groceryEnabled do
                            local currentPos = myHrp.Position
                            local targetAir = Vector3.new(targetPos.X, currentPos.Y, targetPos.Z)
                            local distance = (targetAir - currentPos).Magnitude
                            
                            if distance < 4 then break end
                            
                            myHrp.Velocity = Vector3.zero
                            local direction = (targetAir - currentPos).Unit
                            -- المشي في الجو بمقدار 2.5 ستد في كل فريم (سريع وآمن)
                            myHrp.CFrame = CFrame.new(currentPos + direction * 2.5) * originalRot
                            task.wait(0.02)
                        end
                        
                        -- 3. الهبوط العمودي الهادئ فوق طاولة العمل مباشرة
                        while groceryEnabled and (myHrp.Position - targetPos).Magnitude > 3 do
                            myHrp.Velocity = Vector3.zero
                            local direction = (targetPos - myHrp.Position).Unit
                            myHrp.CFrame = CFrame.new(myHrp.Position + direction * 2) * originalRot
                            task.wait(0.02)
                        end
                    end
                    
                    -- فحص فوري للإيقاف
                    if not groceryEnabled then 
                        myHrp.Velocity = Vector3.zero
                        break 
                    end
                    
                    -- السقوط والثبات: نثبت السرعة وننتظر المزامنة عشان تخطي حماية روبلوكس والـ Validate
                    myHrp.Velocity = Vector3.zero
                    GroceryButton.Text = "⏳ جاري مزامنة الموقع..."
                    task.wait(1.5)
                    
                    if not groceryEnabled then break end
                    
                    -- 4. لقم زر التوظيف بشكل تلقائي ومؤكد
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
                                        task.wait(0.4)
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
                        task.wait(2)
                        if groceryEnabled then GroceryButton.Text = "🏪 البقالة: مشغل" end
                    end
                end
                task.wait(0.5)
            end
        end)
        
    else
        -- [ إطفاء -> يقلب رمادي ويوقف مكانه في الجو فوراً ويطيح ]
        GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        GroceryButton.Text = "🏪 البقالة: مطفأ"
        
        if hrp then
            hrp.Velocity = Vector3.zero -- تصفير الفيزياء عشان يطيح سيدة بدون اندفاع عشوائي
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
