--// Zygame Hub | Login
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()

-- THÊM DÒNG NÀY ĐỂ CHỜ THƯ VIỆN LOAD XONG
task.wait(1) 

local Window = Fluent:CreateWindow({
    Title = "Zygame Hub", 
    SubTitle = "Xác thực", 
    Size = UDim2.fromOffset(300, 180), 
    Theme = "Dark"
})

local Tab = Window:AddTab({Title = "Login", Icon = "key"})
local Input = ""

Tab:AddInput("Key", {Title = "Nhập Key:", Callback = function(v) Input = v end})

Tab:AddButton({Title = "Xác nhận", Callback = function()
    if Input == "ZYGAME_VN" then
        Window:Destroy()
        -- Kích hoạt script Zygame VIP
        local success, result = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/giaabaoo749-arch/Zy_game.lua/refs/heads/main/zygame_vnvip.lua", true))()
        end)
        
        if not success then
            warn("Lỗi tải Script VIP: " .. tostring(result))
            Fluent:Notify({Title = "Lỗi", Content = "Không thể tải Script VIP!"})
        end
    else
        Fluent:Notify({Title = "Lỗi", Content = "Sai Key!"})
    end
end})
