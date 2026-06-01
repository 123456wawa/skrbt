-- ==========================================
-- سكربت blokspin المطور | نظام الاستجابة الفورية، الطمر الذكي، وركض 35 المضمون
-- الرمز السري: WAFI
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("BlokSpinFixGui") then
    CoreGui:FindFirstChild("BlokSpinFixGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlokSpinFixGui"
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

-- دالة المحاكاة الآمنة لضغط الأزرار في ألعاب روبلوكس وحل مشكلة عدم الاستجابة
local function safeClickButton(btn)
    pcall(function()
        btn:Activate()
        if getconnections then
            for _, c in pairs(getconnections(btn.MouseButton1Click)) do pcall(function() c:Fire() end) end
            for _, c in pairs(getconnections(btn.MouseButton1Down)) do pcall(function() c:Fire() end) end
            for _, c in pairs(getconnections(btn.Activated)) do pcall(function() c:Fire() end) end
        end
    end)
end

-- دالة البحث التلقائي عن زر الركض الخاص باللعبة وضغطه مستمراً
local function activateGameSprint()
    pcall(function()
        local pGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not pGui then return end
        for _, v in pairs(pGui:GetDescendants()) do
            if v:IsA("TextButton") or v:IsA("ImageButton") then
                local nLower = string.lower(v.Name)
                local tLower = v:IsA("TextButton") and string.lower(v.Text) or ""
                
                if string.find(nLower, "sprint") or string.find(nLower, "run") or string.find(nLower, "fast") or string.find(nLower, "ركض") or string.find(tLower, "sprint") or string.find(tLower, "run") or string.find(tLower, "ركض") then
                    if v.Visible then
                        safeClickButton(v)
                    end
                end
            end
        end
    end)
end

-- تفعيل الاستجابة الفورية لجميع المنصات (Activated بديل موثوق لـ MouseButton1Click)
GroceryButton.Activated:Connect(function()
    groceryEnabled = not groceryEnabled
    
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if groceryEnabled then
        -- تشغيل -> يقلب أخضر فوراً وبدون أي تأخير
        GroceryButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        GroceryButton.Text = "🏪 البقالة: مشغل"
        
        task.spawn(function()
            local lastPosition = Vector3.zero
            local stuckCount = 0
            
            while groceryEnabled do
                local char = LocalPlayer.Character
                local myHrp = char and char:FindFirstChild("HumanoidRootPart")
                local myHumanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                if myHumanoid and myHrp then
                    -- تحديد سرعة الركض 35 المطلوبة وتفعيل القفز التلقائي المدمج
                    myHumanoid.WalkSpeed = 35
                    myHumanoid.AutoJumpEnabled = true
                    
                    local targetPos = Vector3.new(164.98, 254.74, 204.42)
                    
                    -- حلقة المشي والركض الفيزيائي
                    while groceryEnabled and (myHrp.Position - targetPos).Magnitude > 5 do
                        -- تفعيل زر ركض اللعبة في كل خطوة
                        activateGameSprint()
                        
                        -- أمر المشي الفعلي نحو البقالة
                        myHumanoid:MoveTo(targetPos)
                        
                        -- نظام ذكي لكشف الارتطام والعوائق (لو لاعبك وقف مكانه وصدم بجدار يطمر فوراً)
                        local currentPos = myHrp.Position
                        if (currentPos - lastPosition).Magnitude < 0.4 then
                            stuckCount = stuckCount + 1
                            if stuckCount >= 3 then -- معلق لأكثر من 0.15 ثانية
                                myHumanoid.Jump = true -- يطمر فوق العائق غصب
                                stuckCount = 0
                            end
                        else
                            stuckCount = 0
                        end
                        lastPosition = currentPos
                        
                        task.wait(0.05)
                    end
                    
                    if not groceryEnabled then break end
                    
                    -- وصلنا عند الطاولة: نثبت الحركة تماماً عشان السيرفر يقبل التوظيف
                    myHumanoid:MoveTo(myHrp.Position)
                    GroceryButton.Text = "⏳ جاري التوظيف التلقائي..."
                    task.wait(1.5) -- المزامنة الذهبية لمنع خطأ Validate الحماية
                    
                    if not groceryEnabled then break end
                    
                    local jobFound = false
                    
                    -- [ المرحلة الأولى: كبس زر Apply الأخضر من الشاشة ]
                    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
                    if pGui then
                        for _, guiBtn in pairs(pGui:GetDescendants()) do
                            if guiBtn:IsA("TextButton") or guiBtn:IsA("ImageButton") then
                                local nameL = string.lower(guiBtn.Name)
                                local textL = guiBtn:IsA("TextButton") and string.lower(guiBtn.Text) or ""
                                
                                if string.find(nameL, "apply") or string.find(textL, "apply") or 
                                   string.find(nameL, "job") or string.find(textL, "job") or 
                                   string.find(nameL, "work") or string.find(textL, "work") or
                                   string.find(nameL, "توظيف") or string.find(textL, "توظيف") then
                                    
                                    if guiBtn.Visible then
                                        safeClickButton(guiBtn)
                                        jobFound = true
                                    end
                                end
                            end
                        end
                    end
                    
                    -- [ المرحلة الثانية: كبس أزرار الماب القريبة لو ما انكبس زر الشاشة ]
                    if not jobFound then
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not groceryEnabled then break end
                            
                            if obj:IsA("ProximityPrompt") then
                                local pParent = obj.Parent
                                if pParent and pParent:IsA("BasePart") and (pParent.Position - targetPos).Magnitude < 20 then
                                    myHrp.CFrame = CFrame.new(pParent.Position) * CFrame.new(0, 1, 0)
                                    task.wait(0.2)
                                    if fireproximityprompt then
                                        fireproximityprompt(obj)
                                        task.wait(0.2)
                                        fireproximityprompt(obj)
                                    end
                                    jobFound = true
                                    break
                                end
                            elseif obj:IsA("ClickDetector") then
                                local dParent = obj.Parent
                                if dParent and dParent:IsA("BasePart") and (dParent.Position - targetPos).Magnitude < 20 then
                                    myHrp.CFrame = CFrame.new(dParent.Position)
                                    task.wait(0.2)
                                    if fireclickdetector then fireclickdetector(obj) end
                                    jobFound = true
                                    break
                                end
                            end
                        end
                    end
                    
                    if jobFound then
                        GroceryButton.Text = "✅ تم القبول بنجاح!"
                        task.wait(1.5)
                        if groceryEnabled then GroceryButton.Text = "🏪 البقالة: مشغل" end
                    end
                end
                task.wait(0.5)
            end
        end)
        
    else
        -- إطفاء -> يرجع رمادي فوراً ويوقف لاعبك مكانه
        GroceryButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        GroceryButton.Text = "🏪 البقالة: مطفأ"
        if humanoid then
            humanoid:MoveTo(character.HumanoidRootPart.Position)
        end
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
