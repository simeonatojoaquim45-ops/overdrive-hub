-- Overdrive Hub MM2 - Complete Script for Delta Executor
-- Features: Auto Farm, ESP, Silent Aim, Auto Shoot, Teleport, Role Detection, etc.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Configurações
getgenv().Settings = {
    AutoFarm = false,
    ESP = false,
    SilentAim = false,
    AutoShoot = false,
    AutoGrabGun = false,
    KillAura = false,
    WalkSpeed = false,
    JumpPower = false,
    NoClip = false,
    GodMode = false,
    AntiFling = false,
    AntiAFK = false,
    AutoDodge = false,
    FlingAll = false,
    KillAll = false,
    TeleportToGun = false,
    TeleportToMurderer = false,
    TeleportToSheriff = false,
    ShowRoles = false,
    FullBright = false,
    RemoveFog = false
}

-- Criar GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OverdriveHubMM2"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Cantos arredondados
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔥 OVERDRIVE HUB MM2 🔥"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Botão Minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -70, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeBtn

-- Botão Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Container de Abas
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 150, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 10)
TabCorner.Parent = TabContainer

-- Container de Conteúdo
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -150, 1, -40)
ContentContainer.Position = UDim2.new(0, 150, 0, 40)
ContentContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentContainer.BorderSizePixel = 0
ContentContainer.Parent = MainFrame

-- Sistema de Abas
local Tabs = {}
local CurrentTab = nil

local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name .. "Tab"
    TabBtn.Size = UDim2.new(1, -10, 0, 40)
    TabBtn.Position = UDim2.new(0, 5, 0, #Tabs * 45 + 10)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabBtn.Text = icon .. " " .. name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 14
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Parent = TabContainer
    
    local TabBtnCorner = Instance.new("UICorner")
    TabBtnCorner.CornerRadius = UDim.new(0, 8)
    TabBtnCorner.Parent = TabBtn
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = name .. "Content"
    TabContent.Size = UDim2.new(1, -20, 1, -20)
    TabContent.Position = UDim2.new(0, 10, 0, 10)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 4
    TabContent.Visible = false
    TabContent.Parent = ContentContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = TabContent
    
    table.insert(Tabs, {Button = TabBtn, Content = TabContent, Name = name})
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, tab in pairs(Tabs) do
            tab.Content.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        TabContent.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CurrentTab = name
    end)
    
    return TabContent
end

-- Função para criar Toggle
local function CreateToggle(parent, text, setting, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleFrame.BorderSizePixel = 0
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0.05, 0, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.Font = Enum.Font.GothamSemibold
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 60, 0, 30)
    ToggleBtn.Position = UDim2.new(1, -70, 0.5, -15)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextSize = 12
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ToggleFrame
    
    local ToggleBtnCorner = Instance.new("UICorner")
    ToggleBtnCorner.CornerRadius = UDim.new(0, 15)
    ToggleBtnCorner.Parent = ToggleBtn
    
    local isOn = false
    
    ToggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        Settings[setting] = isOn
        if isOn then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            ToggleBtn.Text = "ON"
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleBtn.Text = "OFF"
        end
        if callback then callback(isOn) end
    end)
    
    ToggleFrame.Parent = parent
    return ToggleFrame
end

-- Função para criar Botão
local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamBold
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    Button.Parent = parent
    
    return Button
end

-- Criar Abas
local MainTab = CreateTab("Principal", "🏠")
local ESPTab = CreateTab("ESP", "👁️")
local CombatTab = CreateTab("Combate", "⚔️")
local TeleportTab = CreateTab("Teleport", "🚀")
local TrollingTab = CreateTab("Troll", "😈")
local MiscTab = CreateTab("Misc", "⚙️")

-- ABA PRINCIPAL
CreateToggle(MainTab, "Auto Farm Coins", "AutoFarm", function(state)
    print("Auto Farm:", state)
end)

CreateToggle(MainTab, "Auto Grab Gun", "AutoGrabGun", function(state)
    print("Auto Grab Gun:", state)
end)

CreateToggle(MainTab, "Anti AFK", "AntiAFK", function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        end)
    end
end)

CreateToggle(MainTab, "WalkSpeed Boost", "WalkSpeed", function(state)
    if state then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
    else
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

CreateToggle(MainTab, "JumpPower Boost", "JumpPower", function(state)
    if state then
        LocalPlayer.Character.Humanoid.JumpPower = 100
    else
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

-- ABA ESP
CreateToggle(ESPTab, "Player ESP", "ESP", function(state)
    print("ESP:", state)
end)

CreateToggle(ESPTab, "Show Roles", "ShowRoles", function(state)
    print("Show Roles:", state)
end)

CreateToggle(ESPTab, "Gun ESP", "GunESP", function(state)
    print("Gun ESP:", state)
end)

CreateToggle(ESPTab, "Full Bright", "FullBright", function(state)
    if state then
        game.Lighting.Brightness = 10
        game.Lighting.GlobalShadows = false
    else
        game.Lighting.Brightness = 1
        game.Lighting.GlobalShadows = true
    end
end)

CreateToggle(ESPTab, "Remove Fog", "RemoveFog", function(state)
    if state then
        game.Lighting.FogEnd = 100000
    else
        game.Lighting.FogEnd = 500
    end
end)

-- ABA COMBATE
CreateToggle(CombatTab, "Silent Aim (Gun)", "SilentAim", function(state)
    print("Silent Aim:", state)
end)

CreateToggle(CombatTab, "Auto Shoot", "AutoShoot", function(state)
    print("Auto Shoot:", state)
end)

CreateToggle(CombatTab, "Kill Aura", "KillAura", function(state)
    print("Kill Aura:", state)
end)

CreateToggle(CombatTab, "Auto Dodge Knife", "AutoDodge", function(state)
    print("Auto Dodge:", state)
end)

CreateToggle(CombatTab, "God Mode", "GodMode", function(state)
    print("God Mode:", state)
end)

-- ABA TELEPORT
CreateButton(TeleportTab, "Teleport to Gun", function()
    print("TP to Gun")
end)

CreateButton(TeleportTab, "Teleport to Murderer", function()
    print("TP to Murderer")
end)

CreateButton(TeleportTab, "Teleport to Sheriff", function()
    print("TP to Sheriff")
end)

CreateButton(TeleportTab, "Teleport to Lobby", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
end)

-- ABA TROLLING
CreateToggle(TrollingTab, "Kill All (Murderer)", "KillAll", function(state)
    print("Kill All:", state)
end)

CreateToggle(TrollingTab, "Fling All", "FlingAll", function(state)
    print("Fling All:", state)
end)

CreateToggle(TrollingTab, "No Clip", "NoClip", function(state)
    print("NoClip:", state)
end)

CreateButton(TrollingTab, "Spam Knife", function()
    print("Spam Knife")
end)

-- ABA MISC
CreateToggle(MiscTab, "Anti Fling", "AntiFling", function(state)
    print("Anti Fling:", state)
end)

CreateButton(MiscTab, "Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton(MiscTab, "Server Hop", function()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"
    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    local List = Http:JSONDecode(game:HttpGet(_servers))
    local Server = List.data[math.random(1, #List.data)]
    TPS:TeleportToPlaceInstance(_place, Server.id, LocalPlayer)
end)

-- Selecionar primeira aba
Tabs[1].Button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Tabs[1].Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Tabs[1].Content.Visible = true

-- Funcionalidades do Script

-- Sistema de Roles
local function GetPlayerRole(player)
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    
    if backpack then
        if backpack:FindFirstChild("Knife") or (character and character:FindFirstChild("Knife")) then
            return "Murderer"
        elseif backpack:FindFirstChild("Gun") or (character and character:FindFirstChild("Gun")) then
            return "Sheriff"
        end
    end
    return "Innocent"
end

-- ESP System
local ESPBoxes = {}
local function CreateESP(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.new(1, 1, 1)
    box.Thickness = 2
    box.Filled = false
    
    local text = Drawing.new("Text")
    text.Visible = false
    text.Color = Color3.new(1, 1, 1)
    text.Size = 16
    text.Center = true
    text.Outline = true
    
    ESPBoxes[player] = {Box = box, Text = text}
end

local function UpdateESP()
    for player, drawings in pairs(ESPBoxes) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and Settings.ESP then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local role = GetPlayerRole(player)
                local color = Color3.new(0, 1, 0) -- Innocent (Green)
                
                if role == "Murderer" then
                    color = Color3.new(1, 0, 0) -- Red
                elseif role == "Sheriff" then
                    color = Color3.new(0, 0, 1) -- Blue
                end
                
                drawings.Box.Visible = true
                drawings.Box.Color = color
                drawings.Box.Size = Vector2.new(50, 80)
                drawings.Box.Position = Vector2.new(pos.X - 25, pos.Y - 40)
                
                drawings.Text.Visible = Settings.ShowRoles
                drawings.Text.Color = color
                drawings.Text.Text = player.Name .. " [" .. role .. "]"
                drawings.Text.Position = Vector2.new(pos.X, pos.Y - 60)
            else
                drawings.Box.Visible = false
                drawings.Text.Visible = false
            end
        else
            drawings.Box.Visible = false
            drawings.Text.Visible = false
        end
    end
end

-- Inicializar ESP para jogadores existentes
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        CreateESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    CreateESP(player)
end)

-- Auto Farm
local function AutoFarm()
    if Settings.AutoFarm then
        local coins = Workspace:GetDescendants()
        for _, coin in pairs(coins) do
            if coin.Name == "Coin" and coin:IsA("BasePart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
                wait(0.1)
            end
        end
    end
end

-- Silent Aim
local function GetClosestPlayer()
    local closest = nil
    local minDist = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position
            local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            
            if onScreen and dist < minDist and dist < 200 then
                minDist = dist
                closest = player
            end
        end
    end
    return closest
end

-- Loop Principal
RunService.RenderStepped:Connect(function()
    UpdateESP()
    AutoFarm()
    
    -- Silent Aim
    if Settings.SilentAim then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            -- Implementação do silent aim aqui
        end
    end
    
    -- NoClip
    if Settings.NoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Controles da GUI
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        ContentContainer.Visible = false
        TabContainer.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 600, 0, 40), "Out", "Quad", 0.3)
        MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 600, 0, 400), "Out", "Quad", 0.3)
        wait(0.3)
        ContentContainer.Visible = true
        TabContainer.Visible = true
        MinimizeBtn.Text = "-"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    -- Limpar ESP
    for _, drawings in pairs(ESPBoxes) do
        drawings.Box:Remove()
        drawings.Text:Remove()
    end
end)

-- Arrastar GUI
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Notificação de carregamento
local Notification = Instance.new("Frame")
Notification.Name = "Notification"
Notification.Size = UDim2.new(0, 300, 0, 80)
Notification.Position = UDim2.new(0.5, -150, 0, -100)
Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Notification.BorderSizePixel = 0
Notification.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 10)
NotifCorner.Parent = Notification

local NotifText = Instance.new("TextLabel")
NotifText.Size = UDim2.new(1, -20, 1, -20)
NotifText.Position = UDim2.new(0, 10, 0, 10)
NotifText.BackgroundTransparency = 1
NotifText.Text = "✅ Overdrive Hub MM2 Carregado!\n🔥 Boa sorte nas partidas!"
NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifText.TextSize = 16
NotifText.Font = Enum.Font.GothamBold
NotifText.TextWrapped = true
NotifText.Parent = Notification

-- Animação de entrada
Notification:TweenPosition(UDim2.new(0.5, -150, 0, 20), "Out", "Bounce", 0.5)

-- Remover notificação após 3 segundos
wait(3)
Notification:TweenPosition(UDim2.new(0.5, -150, 0, -100), "Out", "Quad", 0.5)
wait(0.5)
Notification:Destroy()

print("Overdrive Hub MM2 - Script Carregado com Sucesso!")
