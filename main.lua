-- 1. استدعاء مكتبة الواجهة عشان تسوي لنا المربع والأزرار
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- 2. صنع النافذة الرئيسية باسمك (وافي Hub) واختيار اللون (أحمر وأسود)
local Window = Library.CreateLib("وافي Hub", "BloodTheme")

-- 3. صنع قسم داخل القائمة نسميه "الميزات"
local MainTab = Window:NewTab("الميزات")
local MainSection = MainTab:NewSection("تعديل اللاعب")

-- 4. صنع زر داخل القائمة يزود السرعة
MainSection:NewButton("زيادة السرعة (Speed)", "يخلي اللاعب سريع جداً", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 150
end)

-- 5. صنع زر ثاني يرجع السرعة طبيعية
MainSection:NewButton("سرعة طبيعية", "يرجع السرعة لوضعها الأصلي", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)
