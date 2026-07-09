local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Zygame Hub | Fluent",
    SubTitle = "v1.0",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
})

_G.FastAttack = false

-- Logic (Giữ nguyên)
task.spawn(function()
    while task.wait(0.05) do
        if _G.FastAttack then
            local tool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
end)

-- Tạo Menu
local MainTab = Window:AddTab({ Title = "Main", Icon = "sword" })
MainTab:AddToggle("FastAttack", {Title = "Fast Attack", Default = false, Callback = function(v) _G.FastAttack = v end})

local MoveTab = Window:AddTab({ Title = "Movement", Icon = "move" })
MoveTab:AddSlider("Speed", {Title = "WalkSpeed", Default = 16, Min = 16, Max = 200, Callback = function(v) 
    if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end 
end})

Fluent:Notify({Title = "Success", Content = "Fluent UI Loaded!", Duration = 3})
