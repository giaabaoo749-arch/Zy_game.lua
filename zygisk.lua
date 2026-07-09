local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local CorrectKey = "ZYGAME_VN"
local KeyLink = "https://direct-link.net/7281791/NJUhvvC7PK7S"
local TargetScript = "https://raw.githubusercontent.com/VTDROBLOX/Animehub/refs/heads/main/Tayhub.lua"

-- 1. Cửa sổ Login
local KeyWindow = Fluent:CreateWindow({
    Title = "Zygame Hub | Login",
    SubTitle = "Xác thực truy cập",
    TabWidth = 160,
    Size = UDim2.fromOffset(400, 250),
    Theme = "Dark",
})

local KeyTab = KeyWindow:AddTab({ Title = "Login", Icon = "key" })
local InputKey = ""

KeyTab:AddInput("Input", {Title = "Nhập Key:", Default = "", Callback = function(v) InputKey = v end})

KeyTab:AddButton({
    Title = "Xác nhận",
    Callback = function()
        if InputKey == CorrectKey then
            KeyWindow:Destroy()
            -- Tự động chạy script khi đúng Key
            loadstring(game:HttpGet(TargetScript))()
            -- Hiện Menu của bạn
            LoadMainHub()
        else
            Fluent:Notify({Title = "Thất bại", Content = "Key sai!", Duration = 3})
        end
    end
})

KeyTab:AddButton({
    Title = "Get Key",
    Callback = function()
        setclipboard(KeyLink)
        Fluent:Notify({Title = "Thông báo", Content = "Đã copy link!", Duration = 3})
    end
})

-- 2. Menu chính
function LoadMainHub()
    local Window = Fluent:CreateWindow({
        Title = "Zygame Hub | Blox Fruit",
        SubTitle = "v1.0",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
    })

    local FarmTab = Window:AddTab({ Title = "Script Farm", Icon = "sword" })
    FarmTab:AddToggle("FastAttack", {Title = "Fast Attack", Default = false, Callback = function(v) _G.FastAttack = v end})
    FarmTab:AddToggle("AutoFarm", {Title = "Auto Farm Level", Default = false, Callback = function(v) _G.AutoFarm = v end})
    
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
        if _G.FastAttack then
            local char = game.Players.LocalPlayer.Character
            local tool = char and char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
end)
