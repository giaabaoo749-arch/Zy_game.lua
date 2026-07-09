--// Zygame Hub | Login
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()
local Window = Fluent:CreateWindow({Title = "Zygame Hub", SubTitle = "Xác thực", Size = UDim2.fromOffset(300, 180), Theme = "Dark"})
local Tab = Window:AddTab({Title = "Login", Icon = "key"})
local Input = ""

Tab:AddInput("Key", {Title = "Nhập Key:", Callback = function(v) Input = v end})
Tab:AddButton({Title = "Xác nhận", Callback = function()
    if Input == "ZYGAME_VN" then
        Window:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VTDROBLOX/Animehub/refs/heads/main/Tayhub.lua", true))()
    else
        Fluent:Notify({Title = "Lỗi", Content = "Sai Key!"})
    end
end})
