-- ============================================
-- BANANA HUB - PREMIUM KEY SYSTEM
-- Key: BANANACAT-KEY_CJEQ749100ML
-- ============================================

-- ============================================
-- PART 1: EXECUTOR CHECK
-- ============================================

if not game:IsLoaded() then game.Loaded:Wait() end
if not game.Players.LocalPlayer then repeat task.wait() until game.Players.LocalPlayer end

local currentPlayer = game.Players.LocalPlayer.Name

-- ============================================
-- PART 2: KEY DATABASE
-- ============================================

local MASTER_KEY = "BANANACAT-KEY_CJEQ749100ML"

local keyDatabase = {
    [MASTER_KEY] = {
        username = currentPlayer,
        expiry = "2099-12-31",
        tier = "OWNER",
        permanent = true
    }
}

-- ============================================
-- PART 3: KEY VALIDATION FUNCTION
-- ============================================

local function validateKey(key)
    if key == MASTER_KEY then
        return true, "✅ WELCOME OWNER! | Tier: OWNER"
    end
    
    local keyData = keyDatabase[key]
    if not keyData then
        return false, "❌ Key does not exist!"
    end
    
    if keyData.username ~= "Public" and keyData.username ~= currentPlayer then
        return false, "❌ This key belongs to someone else!"
    end
    
    if not keyData.permanent then
        local currentDate = os.date("%Y-%m-%d")
        if currentDate > keyData.expiry then
            return false, "❌ Key has expired! (Expired: " .. keyData.expiry .. ")"
        end
    end
    
    return true, "✅ Key is valid! | Tier: " .. keyData.tier
end

-- ============================================
-- PART 4: SAVE/LOAD KEY
-- ============================================

local function saveKeyToFile(key)
    if writefile then
        pcall(function()
            writefile("BananaHub_Key.txt", key)
        end)
    end
    getgenv().BananaHubKey = key
end

local function loadSavedKey()
    if readfile then
        local success, data = pcall(function()
            return readfile("BananaHub_Key.txt")
        end)
        if success and data and data ~= "" then
            return data
        end
    end
    return getgenv().BananaHubKey
end

-- ============================================
-- PART 5: KEY INPUT GUI
-- ============================================

local function createKeyWindow()
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    
    local KeyWindow = Fluent:CreateWindow({
        Title = "🔐 Banana Hub - Premium",
        SubTitle = "Enter your key to activate",
        Size = UDim2.fromOffset(400, 260),
        Theme = "Dark",
        Acrylic = true
    })
    
    local KeyTab = KeyWindow:AddTab({ Title = "🔑 Key", Icon = "key" })
    
    local KeySection = KeyTab:AddSection("Authentication")
    KeySection:AddParagraph("🍌 Banana Hub", "Premium | Blox Fruits")
    
    KeySection:AddLabel("🔹 Please enter your key below")
    KeySection:AddLabel("👤 User: " .. currentPlayer)
    
    local keyInput = ""
    KeySection:AddInput("keyInput", {
        Title = "🔑 Enter Key:",
        Placeholder = "BANANACAT-KEY_CJEQ749100ML",
        Callback = function(value)
            keyInput = value
        end
    })
    
    KeySection:AddButton("✅ Confirm", function()
        if keyInput == "" then
            Fluent:Notify({
                Title = "⚠️ Error",
                Content = "Please enter a key!",
                Duration = 3
            })
            return
        end
        
        local isValid, message = validateKey(keyInput)
        
        if isValid then
            Fluent:Notify({
                Title = "✅ Success",
                Content = message,
                Duration = 5
            })
            
            saveKeyToFile(keyInput)
            
            if keyInput == MASTER_KEY then
                Fluent:Notify({
                    Title = "👑 WELCOME OWNER!",
                    Content = "You have activated the special version!",
                    Duration = 5
                })
            end
            
            task.wait(0.5)
            KeyWindow:Destroy()
            task.wait(0.5)
            loadMainScript()
        else
            Fluent:Notify({
                Title = "❌ Error",
                Content = message,
                Duration = 5
            })
        end
    end)
    
    KeySection:AddButton("🆘 Get Key", function()
        if setclipboard then
            setclipboard("BANANACAT-KEY_CJEQ749100ML")
            Fluent:Notify({
                Title = "📋 Copied",
                Content = "Key has been copied!",
                Duration = 3
            })
        end
    end)
end

-- ============================================
-- PART 6: MAIN SCRIPT (BANANA HUB)
-- ============================================

local function loadMainScript()
    print("✅ Key authentication successful! Loading Banana Hub...")
    
    -- Initialize variables
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")

    -- Load Fluent library (GUI)
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    -- Create main window
    local Window = Fluent:CreateWindow({
        Title = "🍌 Banana Hub",
        SubTitle = "Premium | Blox Fruits",
        Size = UDim2.fromOffset(580, 460),
        Theme = "Dark",
        Acrylic = false
    })

    -- Create Tabs
    local TabHome = Window:AddTab({ Title = "🏠 Home", Icon = "home" })
    local TabAuto = Window:AddTab({ Title = "⚡ Auto Farm", Icon = "rocket" })
    local TabCombat = Window:AddTab({ Title = "⚔️ Combat", Icon = "sword" })
    local TabMovement = Window:AddTab({ Title = "🚀 Movement", Icon = "map" })
    local TabPlayers = Window:AddTab({ Title = "👤 Players", Icon = "user" })
    local TabSettings = Window:AddTab({ Title = "⚙️ Settings", Icon = "settings" })

    -- ==============================
    -- TAB HOME
    -- ==============================
    local SectionHome = TabHome:AddSection("Information")
    SectionHome:AddParagraph("🍌 Banana Hub", "Version 2.0 | Blox Fruits")
    SectionHome:AddLabel("👑 Owner: " .. currentPlayer)
    SectionHome:AddLabel("🔑 Key: " .. MASTER_KEY)
    SectionHome:AddLabel("Status: Connected ✅")

    SectionHome:AddButton("Reconnect", function()
        print("Reconnected!")
        Fluent:Notify({ Title = "Success", Content = "Reconnected!", Duration = 3 })
    end)

    -- ==============================
    -- TAB AUTO FARM
    -- ==============================
    local AutoSection = TabAuto:AddSection("Farm Settings")

    -- State variables
    local autoFarmEnabled = false
    local autoCollectEnabled = false
    local autoSkillEnabled = false
    local farmRadius = 150
    local selectedMob = "All"

    -- Mob list (Blox Fruits)
    local mobList = {"All", "Bandit", "Gorilla", "Diamond", "Pirate", "Marine", "Zombie"}

    -- Toggle: Auto Farm
    AutoSection:AddToggle("autoFarm", {
        Title = "🔄 Auto Farm",
        Description = "Automatically farm nearest mob",
        Default = false,
        Callback = function(value)
            autoFarmEnabled = value
            if value then
                Fluent:Notify({ Title = "On", Content = "Auto Farm enabled", Duration = 2 })
                startAutoFarm()
            else
                stopAutoFarm()
                Fluent:Notify({ Title = "Off", Content = "Auto Farm disabled", Duration = 2 })
            end
        end
    })

    -- Toggle: Auto Collect
    AutoSection:AddToggle("autoCollect", {
        Title = "📦 Auto Collect",
        Description = "Automatically collect items",
        Default = false,
        Callback = function(value)
            autoCollectEnabled = value
        end
    })

    -- Toggle: Auto Skill
    AutoSection:AddToggle("autoSkill", {
        Title = "✨ Auto Skill",
        Description = "Automatically use skills",
        Default = false,
        Callback = function(value)
            autoSkillEnabled = value
        end
    })

    -- Slider: Radius
    AutoSection:AddSlider("farmRadius", {
        Title = "📏 Farm Radius",
        Description = "Mob search radius",
        Default = 150,
        Min = 50,
        Max = 500,
        Rounding = 1,
        Callback = function(value)
            farmRadius = value
        end
    })

    -- Dropdown: Select Mob
    AutoSection:AddDropdown("selectMob", {
        Title = "🎯 Select Mob",
        Description = "Choose mob type to farm",
        Values = mobList,
        Default = 1,
        Callback = function(value)
            selectedMob = value
        end
    })

    -- Buttons
    AutoSection:AddButton("⚔️ Farm Boss", function()
        Fluent:Notify({ Title = "Boss", Content = "Searching for boss...", Duration = 3 })
        startBossFarm()
    end)

    AutoSection:AddButton("⏹ Stop Farm", function()
        stopAutoFarm()
        Fluent:Notify({ Title = "Stopped", Content = "All farming stopped", Duration = 2 })
    end)

    -- ==============================
    -- TAB COMBAT
    -- ==============================
    local CombatSection = TabCombat:AddSection("Combat")

    local autoParry = false
    local autoDodge = false
    local autoCombo = false
    local combatMode = "PvE"

    CombatSection:AddToggle("autoParry", {
        Title = "🛡️ Auto Parry",
        Description = "Automatically parry attacks",
        Default = false,
        Callback = function(value) autoParry = value end
    })

    CombatSection:AddToggle("autoDodge", {
        Title = "💨 Auto Dodge",
        Description = "Automatically dodge attacks",
        Default = false,
        Callback = function(value) autoDodge = value end
    })

    CombatSection:AddToggle("autoCombo", {
        Title = "🔥 Auto Combo",
        Description = "Automatically execute combos",
        Default = false,
        Callback = function(value) autoCombo = value end
    })

    CombatSection:AddDropdown("combatMode", {
        Title = "🎯 Combat Mode",
        Values = {"PvE", "PvP", "Mixed"},
        Default = 1,
        Callback = function(value) combatMode = value end
    })

    CombatSection:AddButton("🔄 Reset Target", function()
        Fluent:Notify({ Title = "Target", Content = "Target reset", Duration = 2 })
    end)

    -- ==============================
    -- TAB MOVEMENT
    -- ==============================
    local MoveSection = TabMovement:AddSection("Movement")

    local flyEnabled = false
    local noclipEnabled = false
    local walkspeed = 16
    local jumppower = 50

    MoveSection:AddToggle("flyToggle", {
        Title = "✈️ Fly",
        Description = "Enable flight mode",
        Default = false,
        Callback = function(value)
            flyEnabled = value
            toggleFly(value)
        end
    })

    MoveSection:AddSlider("flySpeed", {
        Title = "🚀 Fly Speed",
        Default = 100,
        Min = 0,
        Max = 500,
        Callback = function(value)
            setFlySpeed(value)
        end
    })

    MoveSection:AddToggle("noclipToggle", {
        Title = "🚪 Noclip",
        Description = "Walk through walls",
        Default = false,
        Callback = function(value)
            noclipEnabled = value
            toggleNoclip(value)
        end
    })

    MoveSection:AddSlider("walkSpeed", {
        Title = "🏃 Walk Speed",
        Default = 16,
        Min = 16,
        Max = 250,
        Callback = function(value)
            walkspeed = value
            if humanoid then humanoid.WalkSpeed = value end
        end
    })

    MoveSection:AddSlider("jumpPower", {
        Title = "🦘 Jump Power",
        Default = 50,
        Min = 50,
        Max = 500,
        Callback = function(value)
            jumppower = value
            if humanoid then humanoid.JumpPower = value end
        end
    })

    -- Island list (Blox Fruits)
    local islandList = {"Jungle", "Desert", "Snow", "Marine", "Pirate", "Sky"}
    MoveSection:AddDropdown("teleportIsland", {
        Title = "🏝️ Teleport to Island",
        Values = islandList,
        Callback = function(value)
            teleportToIsland(value)
        end
    })

    MoveSection:AddButton("🔄 Return to Spawn", function()
        teleportToSpawn()
    end)

    -- ==============================
    -- TAB PLAYERS
    -- ==============================
    local PlayersSection = TabPlayers:AddSection("ESP & Players")

    local espEnabled = false
    local espName = false
    local espHealth = false
    local espBox = false
    local espTracers = false
    local espColor = "Red"

    -- ESP Settings
    PlayersSection:AddToggle("espToggle", {
        Title = "👁️ ESP",
        Description = "Enable ESP",
        Default = false,
        Callback = function(value)
            espEnabled = value
            toggleESP(value)
        end
    })

    PlayersSection:AddToggle("espName", {
        Title = "📛 Name",
        Default = true,
        Callback = function(value) espName = value end
    })

    PlayersSection:AddToggle("espHealth", {
        Title = "❤️ Health",
        Default = true,
        Callback = function(value) espHealth = value end
    })

    PlayersSection:AddToggle("espBox", {
        Title = "📦 Box",
        Default = true,
        Callback = function(value) espBox = value end
    })

    PlayersSection:AddToggle("espTracers", {
        Title = "📈 Tracers",
        Default = false,
        Callback = function(value) espTracers = value end
    })

    PlayersSection:AddDropdown("espColor", {
        Title = "🎨 ESP Color",
        Values = {"Red", "Green", "Blue", "Yellow", "Purple", "Cyan"},
        Default = 1,
        Callback = function(value) espColor = value end
    })

    PlayersSection:AddButton("🔄 Refresh Players", function()
        updatePlayerList()
    end)

    -- Player list
    local playerList = PlayersSection:AddListbox("playerList", {
        Title = "Player List",
        Values = {},
        Callback = function(selected)
            if selected then
                teleportToPlayer(selected)
            end
        end
    })

    -- ==============================
    -- TAB SETTINGS
    -- ==============================
    local SettingsSection = TabSettings:AddSection("Settings")

    SettingsSection:AddButton("🔄 Reload UI", function()
        Window:Destroy()
        Fluent:Notify({ Title = "Reload", Content = "Reloading UI...", Duration = 3 })
        task.wait(1)
    end)

    SettingsSection:AddToggle("saveConfig", {
        Title = "💾 Save Config",
        Default = true,
        Callback = function(value)
            if value then
                SaveManager:Save()
            end
        end
    })

    SettingsSection:AddButton("🗑️ Reset Config", function()
        SaveManager:Reset()
        Fluent:Notify({ Title = "Reset", Content = "Config cleared!", Duration = 3 })
    end)

    SettingsSection:AddButton("🔑 Get Key", function()
        if setclipboard then
            setclipboard("BANANACAT-KEY_CJEQ749100ML")
            Fluent:Notify({ Title = "📋 Copied", Content = "Key copied to clipboard!", Duration = 3 })
        end
    end)

    SettingsSection:AddLabel("🔹 Made by obiyeueim")
    SettingsSection:AddLabel("🔹 Version 2.0")
    SettingsSection:AddLabel("🔹 Key: " .. MASTER_KEY)

    SettingsSection:AddButton("❌ Destroy Hub", function()
        Window:Destroy()
        Fluent:Destroy()
        stopAllFunctions()
    end)

    -- ==============================
    -- CORE FUNCTIONS
    -- ==============================

    -- Auto Farm
    local farmLoop = nil
    function startAutoFarm()
        if farmLoop then return end
        farmLoop = game:GetService("RunService").Heartbeat:Connect(function()
            if not autoFarmEnabled then return end
            local nearestMob = getNearestMob(farmRadius)
            if nearestMob then
                if character and rootPart then
                    local mobPos = nearestMob.Position
                    rootPart.CFrame = CFrame.new(mobPos.X, mobPos.Y + 5, mobPos.Z)
                    if humanoid then humanoid.WalkSpeed = 50 end
                end
            end
        end)
    end

    function stopAutoFarm()
        if farmLoop then
            farmLoop:Disconnect()
            farmLoop = nil
        end
        if humanoid then humanoid.WalkSpeed = 16 end
    end

    function startBossFarm()
        Fluent:Notify({ Title = "Boss", Content = "Boss found!", Duration = 3 })
    end

    function getNearestMob(radius)
        local nearest = nil
        local shortestDist = math.huge
        for _, mob in pairs(game:GetService("Workspace").Mobs:GetChildren()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") then
                local dist = (mob.HumanoidRootPart.Position - rootPart.Position).Magnitude
                if dist < radius and dist < shortestDist then
                    nearest = mob
                    shortestDist = dist
                end
            end
        end
        return nearest and nearest.HumanoidRootPart
    end

    -- Fly
    local flyLoop = nil
    function toggleFly(state)
        if state then
            if not flyLoop then
                flyLoop = game:GetService("RunService").Heartbeat:Connect(function()
                    if character and rootPart then
                        local flySpeed = 100
                        rootPart.Velocity = Vector3.new(
                            (rootPart.CFrame.LookVector.X + rootPart.CFrame.RightVector.X) * flySpeed,
                            (rootPart.CFrame.UpVector.Y + 2) * flySpeed,
                            (rootPart.CFrame.LookVector.Z + rootPart.CFrame.RightVector.Z) * flySpeed
                        )
                    end
                end)
            end
        else
            if flyLoop then
                flyLoop:Disconnect()
                flyLoop = nil
            end
        end
    end

    function setFlySpeed(speed) end

    -- Noclip
    local noclipLoop = nil
    function toggleNoclip(state)
        if state then
            if not noclipLoop then
                noclipLoop = game:GetService("RunService").Stepped:Connect(function()
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end
        else
            if noclipLoop then
                noclipLoop:Disconnect()
                noclipLoop = nil
            end
        end
    end

    -- Teleport
    function teleportToIsland(islandName)
        local islandPos = getIslandPosition(islandName)
        if islandPos and rootPart then
            rootPart.CFrame = CFrame.new(islandPos)
            Fluent:Notify({ Title = "Teleport", Content = "Arrived at " .. islandName, Duration = 2 })
        end
    end

    function teleportToSpawn()
        local spawnPos = game:GetService("Workspace").SpawnLocation.Position
        if rootPart then
            rootPart.CFrame = CFrame.new(spawnPos)
        end
    end

    function teleportToPlayer(playerName)
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr.Name == playerName and plr.Character
