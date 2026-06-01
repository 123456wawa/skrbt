-- 1. استدعاء مكتبة الواجهة (Kavo UI)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- 2. صنع النافذة الرئيسية باسم السكربت
local Window = Library.CreateLib("وافي Hub | دوران البلوكات", "BloodTheme")

-- 3. صنع قسم الميزات الأساسية
local MainTab = Window:NewTab("ميزات اللاعب")
local MainSection = MainTab:NewSection("تعديل خصائص الحركة")

-- زر زيادة السرعة
MainSection:NewButton("زيادة السرعة (Speed)", "يمنحك سرعة ركض عالية في المدينة", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

-- زر قفزة عالية
MainSection:NewButton("قفزة عالية (Jump)", "يساعدك على القفز فوق المباني والبلوكات", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
end)

-- زر الجاذبية المنخفضة (الطيران الخفيف)
MainSection:NewButton("جاذبية منخفضة", "يجعلك تطير بخفة عند القفز", function()
    game.Workspace.Gravity = 50
end)

-- زر إرجاع الوضع الطبيعي
MainSection:NewButton("إرجاع الوضع الطبيعي", "يعيد السرعة والقفز والجاذبية لوضعها الأصلي", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    game.Workspace.Gravity = 196.2
end)
