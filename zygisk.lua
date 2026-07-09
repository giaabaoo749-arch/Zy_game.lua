local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Cấu hình
local CorrectKey = "zygamevn"
local GetKeyLink = "https://google.com" -- Thay link lấy key của bạn vào đây

-- 1. Cửa sổ Key System
local KeyWindow = Fluent:CreateWindow({
    Title = "Zygame Hub | Security",
    SubTitle = "Xác thực truy cập",
    TabWidth = 160,
    Size = UDim2.fromOffset(400, 280),
    Theme = "Dark",
})

local KeyTab = KeyWindow:AddTab({ Title = "Login", Icon = "key" })
local UserInput = ""

KeyTab:AddInput("KeyInput", {
    Title = "Nhập Key:",
    Default = "",
    Callback = function(v) UserInput = v end
})

KeyTab:AddButton({
    Title = "Xác nhận",
    Callback = function()
        if UserInput == CorrectKey then
            KeyWindow:Destroy()
            LoadMainHub()
        else
            Fluent:Notify({Title = "Thất bại", Content = "Key sai rồi!", Duration = 3})
        end
    end
})

KeyTab:AddButton({
    Title = "Get Key",
    Callback = function()
        setclipboard(GetKeyLink)
        Fluent:Notify({Title = "Thông báo", Content = "Đã copy link lấy key!", Duration = 3})
    end
})

-- 2. Logic Menu Chính
function LoadMainHub()
    local Window = Fluent:CreateWindow({
        Title = "Zygame Hub | V1.0",
        SubTitle = "Chào mừng bạn đã trở lại",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
    })

    local MainTab = Window:AddTab({ Title = "Main", Icon = "sword" })
    MainTab:AddToggle("FastAttack", {Title = "Fast Attack", Default = false, Callback = function(v) _G.FastAttack = v end})
    MainTab:AddToggle("AutoClick", {Title = "Auto Click", Default = false, Callback = function(v) _G.AutoClick = v end})

    local MoveTab = Window:AddTab({ Title = "Movement", Icon = "move" })
    MoveTab:AddSlider("WalkSpeed", {Title = "Tốc độ chạy", Default = 16, Min = 16, Max = 200, Callback = function(v) 
        if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end 
    end})

    Fluent:Notify({Title = "Thành công", Content = "Zygame Hub đã sẵn sàng!", Duration = 3})
end

-- 3. Logic chạy ngầm (Fast Attack & Auto Click)
task.spawn(function()
    while task.wait(0.05) do
        local player = game.Players.LocalPlayer
        local char = player.Character
        
        if _G.FastAttack and char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
        
        if _G.AutoClick then
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
        end
    end
end)
