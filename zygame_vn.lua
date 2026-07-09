--// Zygame Hub | Blox Fruit Edition
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

--// CẤU HÌNH
local CorrectKey = "ZYGAME_VN"
local GetKeyLink = "https://direct-link.net/7281791/NJUhvvC7PK7S"
local TargetScript = "https://raw.githubusercontent.com/VTDROBLOX/Animehub/refs/heads/main/Tayhub.lua"
local KeyFile = "Zygame_Auth.txt"

--// HÀM KIỂM TRA KEY 72H
local function IsKeyValid()
    if not isfile or not readfile or not isfile(KeyFile) then return false end
    local savedTime = tonumber(readfile(KeyFile))
    if not savedTime then return false end
    
    local currentTime = os.time()
    local expiryTime = 72 * 60 * 60 -- 72 giờ (259,200 giây)
    
    if (currentTime - savedTime) < expiryTime then
        return true
    else
        if delfile then delfile(KeyFile) end
        return false
    end
end

--// HÀM CHÍNH ĐỂ LOAD HUB
function LoadMainHub()
    local Window = Fluent:CreateWindow({
        Title = "Zygame Hub | V1.0",
        SubTitle = "Chào mừng bạn đã trở lại",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
    })

    local FarmTab = Window:AddTab({ Title = "Script Farm", Icon = "sword" })
    FarmTab:AddToggle("FastAttack", {Title = "Fast Attack", Default = false, Callback = function(v) _G.FastAttack = v end})
    FarmTab:AddToggle("AutoClick", {Title = "Auto Click", Default = false, Callback = function(v) _G.AutoClick = v end})
    
    FarmTab:AddButton({
        Title = "Jay FREEMIUM",
        Callback = function()
            local chat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
            if chat then chat.SayMessageRequest:FireServer("Jay FREEMIUM", "All") end
        end
    })

    local MoveTab = Window:AddTab({ Title = "Movement", Icon = "move" })
    MoveTab:AddSlider("WalkSpeed", {
        Title = "Tốc độ chạy", Default = 16, Min = 16, Max = 200, 
        Callback = function(v) 
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then 
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v 
            end 
        end
    })
    
    Fluent:Notify({Title = "Thành công", Content = "Hub đã sẵn sàng!", Duration = 3})
end

--// LOGIC KIỂM TRA TỰ ĐỘNG
if IsKeyValid() then
    loadstring(game:HttpGet(TargetScript))()
    LoadMainHub()
else
    --// CỬA SỔ LOGIN
    local KeyWindow = Fluent:CreateWindow({
        Title = "Zygame Hub | Security",
        SubTitle = "Xác thực truy cập (72h)",
        TabWidth = 160,
        Size = UDim2.fromOffset(400, 320),
        Theme = "Dark",
    })

    local KeyTab = KeyWindow:AddTab({ Title = "Login", Icon = "key" })
    
    KeyTab:AddParagraph({
        Title = "Hỗ trợ",
        Content = "Nếu Key bị lỗi hoặc gặp vấn đề, vui lòng liên hệ Admin để được hỗ trợ."
    })

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
                if writefile then writefile(KeyFile, tostring(os.time())) end
                KeyWindow:Destroy()
                loadstring(game:HttpGet(TargetScript))()
                LoadMainHub()
            else
                Fluent:Notify({Title = "Thất bại", Content = "Key sai! Liên hệ Admin nếu lỗi.", Duration = 3})
            end
        end
    })

    KeyTab:AddButton({
        Title = "Get Key",
        Callback = function()
            setclipboard(GetKeyLink)
            Fluent:Notify({Title = "Thông báo", Content = "Đã copy link! Nếu lỗi hãy nhắn tin Admin.", Duration = 3})
        end
    })
end

--// LOGIC CHẠY NGẦM
task.spawn(function()
    while task.wait(0.05) do
        local char = game.Players.LocalPlayer.Character
        if _G.FastAttack and char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
        if _G.AutoClick then
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(999, 999))
        end
    end
end)
