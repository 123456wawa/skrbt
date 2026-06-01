-- ==========================================
-- سكربت blokspin المطور | نظام المشي الحقيقي، الطمر التلقائي، وتفعيل ركض اللعبة
-- الرمز السري: WAFI
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("BlokSpinUltraGui") then
    CoreGui:FindFirstChild("BlokSpinUltraGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlokSpinUltraGui"
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

-- فنكشن تفعيل زر الركض الخاص باللعبة تلقائياً
local function clickInGameSprintButton()
    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
    if pGui then
        for _, v in pairs(pGui:GetDescendants()) do
            if v:IsA("TextButton") or v:IsA("ImageButton") then
                local nLower = string.lower(v.Name)
                local tLower = v:IsA("TextButton") and string.lower(v.Text) or ""
                
                if string.find(nLower, "sprint") or string.find(nLower, "run") or string.find(nLower, "fast") or string.find(nLower, "ركض") or string.find(tLower, "sprint") or string.find(tLower, "run") or string.find(tLower, "ركض") then
                    if v.Visible then
                        v:Activate()
                        if getconnections then
                            for _, c in pairs(getconnections(v.MouseButton1Click)) do c:Fire() end
                            for _, c in pairs(getconnections(v.MouseButton1Down)) do c:Fire() end
                        end
                    end
                end
            end
        end
    end
end

GroceryButton.MouseButton1Click:Connect(function()
    groceryEnabled = not groceryEnabled
    
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if groceryEnabled then
        GroceryButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        GroceryButton.Text = "🏪 البقالة: مشغل"
        
        task.spawn(function()
            while groceryEnabled do
                local char = LocalPlayer.Character
                local myHrp = char and char:FindFirstChild("HumanoidRootPart")
                local myHumanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                if myHumanoid and myHrp then
                    myHumanoid.AutoJumpEnabled = true -- تفعيل القفز التلقائي المدمج بروبلوكس زيادة أمان
                    local targetPos = Vector3.new(164.98, 254.74, 204.42)
                    
                    -- [ مرحلة التحرك والركض والطمر ]
                    while groceryEnabled and (myHrp.Position - targetPos).Magnitude > 4 do
                        -- تشغيل زر الركض حق اللعبة بشكل مستمر عشان ما يطفي
                        clickInGameSprintButton()
                        
                        -- أمر المشي الفيزيائي نحو الهدف
                        myHumanoid:MoveTo(targetPos)
                        
                        -- مستشعر ذكي للطمر (لو فيه جدار أو عائق قدامه يطمر فوراً)
                        local rayOrigin = myHrp.Position - Vector3.new(0, 1, 0)
                        local rayDirection = myHrp.CFrame.LookVector * 4
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterDescendantsInstances = {char}
                        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                        
                        local rayResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
                        if rayResult and rayResult.Instance and rayResult.Instance.CanCollide then
                            myHumanoid.Jump = true
                        end
                        
                        task.wait(0.05)
                    end
                    
                    if not groceryEnabled then break end
                    
                    -- وصلنا عند النقطة: نوقف مكاننا تماماً ونثبت
                    myHumanoid:MoveTo(myHrp.Position)
                    GroceryButton.Text = "⏳ جاري التوظيف غصب..."
                    task.wait(1.5) -- انتظر ثانية ونصف عشان السيرفر يستوعب إنك واقف على الأرض طبيعي ويقبل التوظيف
                    
                    if not groceryEnabled then break end
                    
                    local successClicked = false
                    
                    -- [ الهجوم الأول: فحص شاشات الـ GUI بجميع المسميات الممكنة ]
                    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
                    if pGui then
                        for _, guiObject in pairs(pGui:GetDescendants()) do
                            if guiObject:IsA("TextButton") or guiObject:IsA("ImageButton") then
                                local nameL = string.lower(guiObject.Name)
                                local textL = guiObject:IsA("TextButton") and string.lower(guiObject.Text) or ""
                                
                                -- كلمات البحث الشاملة للتوظيف
                                if string.find(nameL, "apply") or string.find(textL, "apply") or 
                                   string.find(nameL, "job") or string.find(textL, "job") or 
                                   string.find(nameL, "work") or string.find(textL, "work") or
                                   string.find(nameL, "confirm") or string.find(textL, "confirm") or
                                   string.find(nameL, "yes") or string.find(textL, "yes") or
                                   string.find(nameL, "توظيف") or string.find(textL, "توظيف") or
                                   string.find(nameL, "موافق") or string.find(textL, "موافق") then
                                    
                                    if guiObject.Visible then
                                        guiObject:Activate()
                                        if getconnections then
                                            for _, connection in pairs(getconnections(guiObject.MouseButton1Click)) do connection:Fire() end
                                            for _, connection in pairs(getconnections(guiObject.MouseButton1Down)) do connection:Fire() end
                                        end
                                        successClicked = true
                                    end
                                end
                            end
                        end
                    end
                    
                    -- [ الهجوم الثاني: فحص الأزرار الأرضية والملموسة في الماب المحيطة بك ]
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not groceryEnabled then break end
                        
                        if obj:IsA("ProximityPrompt") then
                            local promptParent = obj.Parent
                            if promptParent and promptParent:IsA("BasePart") then
                                -- إذا كان الزر على بعد أقل من 15 ستد من طاولة البقالة، يلقمه فوراً بدون شروط
                                if (promptParent.Position - targetPos).Magnitude < 15 then
                                    myHrp.CFrame = CFrame.new(promptParent.Position) * CFrame.new(0, 1, 0)
                                    task.wait(0.2)
                                    if fireproximityprompt then
                                        fireproximityprompt(obj)
                                        task.wait(0.3)
                                        fireproximityprompt(obj)
                                    end
                                    successClicked = true
                                    break
                                end
                            end
                        elseif obj:IsA("ClickDetector") then
                            local detectorParent = obj.Parent
                            if detectorParent and detectorParent:IsA("BasePart") then
                                if (detectorParent.Position - targetPos).Magnitude < 15 then
                                    myHrp.CFrame = CFrame.new(detectorParent.Position)
                                    task.wait(0.2)
                                    if fireclickdetector then
                                        fireclickdetector(obj)
                                    end
                                    successClicked = true
                                    break
                                end
                            end
                        end
                    end
                    
                    if successClicked then
                        GroceryButton.Text = "✅ تـم الـتـوظـيـف!"
                        task.wait(2)
                        if groceryEnabled then GroceryButton.Text = "🏪 البقالة: مشغل" end
                    end
                end
                task.wait(0.5)
            end
        end)
        
    else
        GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        GroceryButton.Text = "🏪 البقالة: مطفأ"
        if humanoid then
            humanoid:MoveTo(character.HumanoidRootPart.Position) -- إلغاء وجهة المشي فوراً ليقف بمكانه
        end
    end
end)

-- ==========================================
-- 3. زر الففتح الدائري (B) والإغلاق
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
