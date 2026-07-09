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
    -- Thực thi script ngay lập tức
    loadstring(game:HttpGet(TargetScript, true))()
    
    -- Giao diện Hub
    local Window = Fluent:CreateWindow({Title = "Zygame Hub | V1.0", SubTitle = "Menu chính", TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"})
    
    local Tab = Window:AddTab({ Title = "Thông tin", Icon = "info" })
    Tab:AddParagraph({Title = "Trạng thái", Content = "Zygame Hub đã hoạt động. Script chính đã được kích hoạt."})
    
    Fluent:Notify({Title = "Thành công", Content = "Đã kích hoạt Tayhub!", Duration = 3})
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
