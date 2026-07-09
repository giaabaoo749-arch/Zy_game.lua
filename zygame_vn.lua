local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Cấu hình
local CorrectKey = "zygamevn"
local GetKeyLink = "https://direct-link.net/7281791/NJUhvvC7PK7S"
local TargetScript = "https://raw.githubusercontent.com/VTDROBLOX/Animehub/refs/heads/main/Tayhub.lua"

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
            -- Load script phụ tự động
            loadstring(game:HttpGet(TargetScript))()
            -- Load menu chính
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

    -- Đổi tên Tab thành "Script Farm"
    local FarmTab = Window:AddTab({ Title = "Script Farm", Icon = "sword" })
    FarmTab:AddToggle("FastAttack", {Title = "Fast Attack", Default = false, Callback = function(v) _G.FastAttack = v end})
    FarmTab:AddToggle("AutoClick", {Title = "Auto Click", Default = false, Callback = function(v) _G.AutoClick = v end})
    
    -- Thêm tính năng Jay FREEMIUM
    FarmTab:AddButton({
        Title = "Jay FREEMIUM",
        Callback = function()
            local chat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
            if chat then chat.SayMessageRequest:FireServer("Jay FREEMIUM", "All") end
        end
    })

    local MoveTab = Window:AddTab({ Title = "Movement", Icon = "move" })
    MoveTab:AddSlider("WalkSpeed", {Title = "Tốc độ chạy", Default = 16, Min = 16, Max = 200, Callback = function(v) 
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then 
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v 
        end 
    end})
end

-- 3. Logic chạy ngầm
task.spawn(function()
    while task.wait(0.05) do
        local player = game.Players.LocalPlayer
        local char = player.Character
        
        if _G.FastAttack and char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
        
        -- Sửa lại AutoClick để tránh lỗi tràn bộ nhớ
        if _G.AutoClick then
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(999, 999))
        end
    end
end)
