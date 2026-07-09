--// Zygame Hub | Blox Fruit Edition
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()

--// CẤU HÌNH
local CorrectKey = "ZYGAME_VN"
local GetKeyLink = "https://direct-link.net/7281791/NJUhvvC7PK7S"
local TargetScript = "https://raw.githubusercontent.com/VTDROBLOX/Animehub/refs/heads/main/Tayhub.lua"
local KeyFile = "Zygame_Auth.txt"

--// HÀM KIỂM TRA KEY 72H
local function IsKeyValid()
    if isfile and isfile(KeyFile) then
        local savedTime = tonumber(readfile(KeyFile))
        if savedTime and (os.time() - savedTime) < (72 * 3600) then return true end
        if delfile then delfile(KeyFile) end
    end
    return false
end

--// HÀM LOAD MAIN
function LoadMainHub()
    local Window = Fluent:CreateWindow({Title = "Zygame Hub | V1.0", SubTitle = "Menu chính", TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"})
    
    local FarmTab = Window:AddTab({ Title = "Script Farm", Icon = "sword" })
    FarmTab:AddToggle("FastAttack", {Title = "Fast Attack", Default = false, Callback = function(v) _G.FastAttack = v end})
    FarmTab:AddToggle("AutoClick", {Title = "Auto Click", Default = false, Callback = function(v) _G.AutoClick = v end})
    
    FarmTab:AddButton({Title = "Jay FREEMIUM", Callback = function() 
        local chat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if chat then chat.SayMessageRequest:FireServer("Jay FREEMIUM", "All") end 
    end})

    local MoveTab = Window:AddTab({ Title = "Movement", Icon = "move" })
    MoveTab:AddSlider("WalkSpeed", {Title = "Tốc độ chạy", Default = 16, Min = 16, Max = 200, Callback = function(v) 
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end 
    end})
    
    -- Tải script phụ với độ trễ nhỏ để tránh 429
    task.wait(1) 
    local success, result = pcall(function() return loadstring(game:HttpGet(TargetScript, true))() end)
    if not success then warn("Lỗi tải Script phụ: " .. tostring(result)) end
    
    Fluent:Notify({Title = "Thành công", Content = "Zygame Hub đã sẵn sàng!", Duration = 3})
end

--// KHỞI CHẠY
if IsKeyValid() then
    LoadMainHub()
else
    local KeyWindow = Fluent:CreateWindow({Title = "Zygame Hub | Login", SubTitle = "Xác thực (72h)", TabWidth = 160, Size = UDim2.fromOffset(400, 280), Theme = "Dark"})
    local KeyTab = KeyWindow:AddTab({ Title = "Login", Icon = "key" })
    local UserInput = ""

    KeyTab:AddParagraph({Title = "Hỗ trợ", Content = "Key lỗi? Vui lòng liên hệ Admin."})
    KeyTab:AddInput("KeyInput", {Title = "Nhập Key:", Default = "", Callback = function(v) UserInput = v end})
    KeyTab:AddButton({Title = "Xác nhận", Callback = function()
        if UserInput == CorrectKey then
            if writefile then writefile(KeyFile, tostring(os.time())) end
            KeyWindow:Destroy()
            LoadMainHub()
        else
            Fluent:Notify({Title = "Thất bại", Content = "Sai Key!", Duration = 3})
        end
    end})
    KeyTab:AddButton({Title = "Get Key", Callback = function() setclipboard(GetKeyLink) Fluent:Notify({Title = "Thông báo", Content = "Đã copy link!", Duration = 3}) end})
end

--// LOGIC CHẠY NGẦM
task.spawn(function()
    while task.wait(0.1) do -- Tăng thời gian chờ từ 0.05 lên 0.1 để giảm tải cho CPU
        local char = game.Players.LocalPlayer.Character
        if _G.FastAttack and char and char:FindFirstChildOfClass("Tool") then char:FindFirstChildOfClass("Tool"):Activate() end
        if _G.AutoClick then
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton1(Vector2.new(999, 999))
        end
    end
end)
