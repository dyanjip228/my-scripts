--[[
    Educational Cheat Menu Script for Roblox (v9)
    Features: Aimbot, ESP, Movement, Wallbang, Spinbot (model), Keybinds for ALL toggles,
              i18n RU/EN, Neon Purple UI, LEFT Tabs
    DISCLAIMER: Use only in YOUR OWN game for anti-cheat testing!
]]

-- ============ SERVICES ============
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ============ THEME ============
local Theme = {
    Neon = Color3.fromRGB(170, 60, 255),
    NeonSoft = Color3.fromRGB(210, 130, 255),
    NeonDark = Color3.fromRGB(90, 20, 150),
    BgDark = Color3.fromRGB(20, 12, 28),
    BgMid = Color3.fromRGB(30, 18, 42),
    BgTab = Color3.fromRGB(26, 15, 38),
    BgTabActive = Color3.fromRGB(48, 26, 70),
    BgRow = Color3.fromRGB(38, 22, 55),
    BgRowHover = Color3.fromRGB(50, 30, 72),
    Text = Color3.fromRGB(235, 225, 245),
    TextDim = Color3.fromRGB(150, 130, 170),
    Green = Color3.fromRGB(0, 230, 130),
    Red = Color3.fromRGB(255, 70, 100),
    Orange = Color3.fromRGB(255, 170, 60),
    Blue = Color3.fromRGB(100, 200, 255),
    Pink = Color3.fromRGB(255, 150, 255),
}

-- ============ CONFIG ============
local Config = {
    Language = "RU",
    Aimbot = {
        Enabled = false, Key = Enum.KeyCode.E, -- hold key
        ToggleKey = Enum.KeyCode.Q,            -- toggle
        FOV = 120, Smoothness = 0.25, MaxDistance = 500,
        WallCheck = true, TeamCheck = true, Part = "Head",
        TeamCheckKey = Enum.KeyCode.Z,
        WallCheckKey = Enum.KeyCode.C,
    },
    ESP = {
        Enabled = false, Key = Enum.KeyCode.G,
        Box = true, Name = true, Health = true, Distance = true,
        Tracer = false, TeamCheck = true,
        BoxKey = Enum.KeyCode.One,
        NameKey = Enum.KeyCode.Two,
        HealthKey = Enum.KeyCode.Three,
        DistanceKey = Enum.KeyCode.Four,
        TracerKey = Enum.KeyCode.Five,
        TeamCheckKey = Enum.KeyCode.Six,
        MaxDistance = 1000,
        Color = Color3.fromRGB(0, 255, 170),
        EnemyColor = Color3.fromRGB(255, 60, 60),
    },
    Movement = {
        WalkSpeed = 16, JumpPower = 50,
        SpeedEnabled = false, JumpEnabled = false,
        SpeedKey = Enum.KeyCode.H,
        JumpKey = Enum.KeyCode.J,
        FlyEnabled = false, FlySpeed = 50, NoClip = false,
        FlyKey = Enum.KeyCode.F,
        NoClipKey = Enum.KeyCode.N,
    },
    Wallbang = {
        Enabled = false, WallbangKey = Enum.KeyCode.B,
        IgnoreWalls = true, IgnoreEnemyCollide = true,
        IgnoreWallsKey = Enum.KeyCode.Seven,
        IgnoreEnemiesKey = Enum.KeyCode.Eight,
        Radius = 200, RestoreDelay = 0.15,
        JitterEnabled = false, JitterAmount = 25,
        JitterKey = Enum.KeyCode.K,
        SpinEnabled = false, SpinSpeed = 400,
        SpinPitch = 0, SpinDirection = "Yaw",
        SpinKey = Enum.KeyCode.X,
    },
    UI = { ToggleKey = Enum.KeyCode.RightShift },
}

-- ============ I18N ============
local L = {
    RU = {
        title = "⚡ УЧЕБНОЕ МЕНЮ",
        tab_combat = "⚔  Combat",
        tab_visual = "👁  Visual",
        tab_move = "💨  Movement",
        tab_misc = "⚙  Misc",
        bind_wait = "Нажмите клавишу...",
        bind_change = "Изменить",
        sec_aimbot = "🎯 AIMBOT",
        aim_enable = "Включить Aimbot",
        aim_team = "Проверка на команду",
        aim_wall = "Только видимые (Wall Check)",
        aim_fov = "FOV (радиус)",
        aim_smooth = "Плавность (smooth)",
        aim_dist = "Макс. дистанция",
        aim_key = "Клавиша активации (hold)",
        aim_toggle_key = "Клавиша вкл/выкл",
        aim_team_key = "Бинд Team Check",
        aim_wall_key = "Бинд Wall Check",
        sec_wall = "🌀 WALLBANG + SPINBOT",
        wall_enable = "Wallbang (прострел сквозь стены)",
        wall_ignore = "Игнорировать стены",
        wall_enemy = "Отключить коллизии врагов",
        wall_radius = "Радиус обработки",
        wall_spin = "Спинбот модели",
        wall_jitter = "Джитер",
        wall_jitter_val = "Сила джитера",
        wall_spin_val = "Скорость вращения",
        wall_pitch = "Наклон (Pitch)",
        wall_dir = "Направление спина",
        wall_key = "Клавиша вкл/выкл",
        wall_ignore_key = "Бинд Ignore Walls",
        wall_enemy_key = "Бинд Enemy Collide",
        wall_jitter_key = "Бинд Jitter",
        sec_esp = "👁️ ESP / WALLHACK",
        esp_enable = "Включить ESP",
        esp_box = "Боксы",
        esp_name = "Имена",
        esp_health = "Здоровье",
        esp_dist = "Дистанция",
        esp_tracer = "Трейсеры",
        esp_team = "Только враги",
        esp_max = "Макс. дистанция ESP",
        esp_key = "Клавиша вкл/выкл",
        esp_box_key = "Бинд Box",
        esp_name_key = "Бинд Name",
        esp_health_key = "Бинд Health",
        esp_dist_key = "Бинд Distance",
        esp_tracer_key = "Бинд Tracer",
        esp_team_key = "Бинд Team Check",
        sec_move = "💨 ДВИЖЕНИЕ",
        move_speed = "Изменить скорость",
        move_speed_val = "Скорость",
        move_jump = "Изменить прыжок",
        move_jump_val = "Прыжок",
        move_fly = "Полёт",
        move_fly_val = "Скорость полёта",
        move_noclip = "NoClip (сквозь стены)",
        move_fly_key = "Клавиша полёта",
        move_speed_key = "Бинд Speed",
        move_jump_key = "Бинд Jump",
        move_noclip_key = "Бинд NoClip",
        sec_ui = "⚙️ ИНТЕРФЕЙС",
        ui_key = "Клавиша открытия меню",
        sec_lang = "🌐 ЯЗЫК",
        lang_switch = "Сменить язык",
        footer = "Educational purposes only • Только для тестирования античита",
    },
    EN = {
        title = "⚡ EDUCATIONAL MENU",
        tab_combat = "⚔  Combat",
        tab_visual = "👁  Visual",
        tab_move = "💨  Movement",
        tab_misc = "⚙  Misc",
        bind_wait = "Press a key...",
        bind_change = "Change",
        sec_aimbot = "🎯 AIMBOT",
        aim_enable = "Enable Aimbot",
        aim_team = "Team check",
        aim_wall = "Visible only (Wall Check)",
        aim_fov = "FOV (radius)",
        aim_smooth = "Smoothness",
        aim_dist = "Max distance",
        aim_key = "Hold key",
        aim_toggle_key = "Toggle key",
        aim_team_key = "Team Check bind",
        aim_wall_key = "Wall Check bind",
        sec_wall = "🌀 WALLBANG + SPINBOT",
        wall_enable = "Wallbang (through walls)",
        wall_ignore = "Ignore walls",
        wall_enemy = "Disable enemy collides",
        wall_radius = "Processing radius",
        wall_spin = "Model spinbot",
        wall_jitter = "Jitter",
        wall_jitter_val = "Jitter strength",
        wall_spin_val = "Rotation speed",
        wall_pitch = "Pitch offset",
        wall_dir = "Spin direction",
        wall_key = "Toggle key",
        wall_ignore_key = "Ignore Walls bind",
        wall_enemy_key = "Enemy Collide bind",
        wall_jitter_key = "Jitter bind",
        sec_esp = "👁️ ESP / WALLHACK",
        esp_enable = "Enable ESP",
        esp_box = "Boxes",
        esp_name = "Names",
        esp_health = "Health",
        esp_dist = "Distance",
        esp_tracer = "Tracers",
        esp_team = "Enemies only",
        esp_max = "Max ESP distance",
        esp_key = "Toggle key",
        esp_box_key = "Box bind",
        esp_name_key = "Name bind",
        esp_health_key = "Health bind",
        esp_dist_key = "Distance bind",
        esp_tracer_key = "Tracer bind",
        esp_team_key = "Team Check bind",
        sec_move = "💨 MOVEMENT",
        move_speed = "Modify speed",
        move_speed_val = "Speed",
        move_jump = "Modify jump",
        move_jump_val = "Jump",
        move_fly = "Fly",
        move_fly_val = "Fly speed",
        move_noclip = "NoClip (through walls)",
        move_fly_key = "Fly key",
        move_speed_key = "Speed bind",
        move_jump_key = "Jump bind",
        move_noclip_key = "NoClip bind",
        sec_ui = "⚙️ INTERFACE",
        ui_key = "Menu open key",
        sec_lang = "🌐 LANGUAGE",
        lang_switch = "Switch language",
        footer = "Educational purposes only • For anti-cheat testing only",
    },
}

local function T(key) return (L[Config.Language] and L[Config.Language][key]) or key end

local LocalizedElements = {}
local function register(key, obj, field)
    table.insert(LocalizedElements, {key = key, obj = obj, field = field or "Text"})
end
local function updateLanguage()
    for _, item in ipairs(LocalizedElements) do
        if item.obj and item.obj.Parent then
            item.obj[item.field] = T(item.key)
        end
    end
end

-- ============ UTIL ============
local function create(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do inst[k] = v end
    return inst
end

local function isAlive(plr)
    local char = plr.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

-- ============ BIND REGISTRY ============
-- binds[KeyCode] = function() toggle() end
local Binds = {}

local function registerBind(keyField, tableRef, toggleFn)
    local key = tableRef[keyField]
    Binds[key] = toggleFn
end

local function rebuildBinds()
    -- Очистка и пересборка — на случай переназначения
    for k in pairs(Binds) do Binds[k] = nil end
    if BindRegistry then
        for _, entry in ipairs(BindRegistry) do
            local key = entry.table[entry.keyField]
            if key then Binds[key] = entry.fn end
        end
    end
end
BindRegistry = {}

local function addBind(entry)
    table.insert(BindRegistry, entry)
    if entry.table[entry.keyField] then
        Binds[entry.table[entry.keyField]] = entry.fn
    end
end

-- ============ ESP ============
local ESPStorage = {}
local function createDrawing(class, props)
    local ok, drawing = pcall(function() return Drawing.new(class) end)
    if not ok then return nil end
    for k, v in pairs(props or {}) do drawing[k] = v end
    return drawing
end

local function createESP(plr)
    if plr == LocalPlayer or ESPStorage[plr] then return end
    ESPStorage[plr] = {
        Box = createDrawing("Square", {Thickness=1.5, Filled=false, Color=Config.ESP.Color, Transparency=1}),
        Name = createDrawing("Text", {Size=14, Center=true, Outline=true, Color=Color3.new(1,1,1)}),
        Health = createDrawing("Text", {Size=12, Center=false, Outline=true, Color=Color3.fromRGB(0,255,100)}),
        Distance = createDrawing("Text", {Size=12, Center=true, Outline=true, Color=Color3.fromRGB(200,200,200)}),
        Tracer = createDrawing("Line", {Thickness=1.5, Color=Config.ESP.Color, Transparency=1}),
    }
end

local function removeESP(plr)
    if ESPStorage[plr] then
        for _, d in pairs(ESPStorage[plr]) do
            if d then pcall(function() d:Remove() end) end
        end
        ESPStorage[plr] = nil
    end
end

local function updateESP()
    for plr, drawings in pairs(ESPStorage) do
        local hide = function()
            for _, d in pairs(drawings) do if d then d.Visible = false end end
        end
        if not Config.ESP.Enabled or not isAlive(plr) then hide(); continue end
        local char = plr.Character
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not head or not hum then hide(); continue end
        if Config.ESP.TeamCheck and plr.Team == LocalPlayer.Team then hide(); continue end
        local distance = (hrp.Position - Camera.CFrame.Position).Magnitude
        if distance > Config.ESP.MaxDistance then hide(); continue end
        local headPos, hOn = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
        local hrpPos, rOn = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 0.5, 0))
        if not hOn or not rOn then hide(); continue end
        local height = math.abs(headPos.Y - hrpPos.Y)
        local width = height / 2
        local color = (plr.Team and plr.Team == LocalPlayer.Team) and Config.ESP.Color or Config.ESP.EnemyColor
        if drawings.Box then
            drawings.Box.Visible = Config.ESP.Box
            drawings.Box.Size = Vector2.new(width, height)
            drawings.Box.Position = Vector2.new(headPos.X - width/2, headPos.Y)
            drawings.Box.Color = color
        end
        if drawings.Name then
            drawings.Name.Visible = Config.ESP.Name
            drawings.Name.Text = plr.DisplayName
            drawings.Name.Position = Vector2.new(headPos.X, headPos.Y - 18)
            drawings.Name.Color = color
        end
        if drawings.Health then
            drawings.Health.Visible = Config.ESP.Health
            drawings.Health.Text = string.format("%d HP", math.floor(hum.Health))
            drawings.Health.Position = Vector2.new(headPos.X + width/2 + 5, headPos.Y + height/2)
        end
        if drawings.Distance then
            drawings.Distance.Visible = Config.ESP.Distance
            drawings.Distance.Text = string.format("[%d m]", math.floor(distance))
            drawings.Distance.Position = Vector2.new(headPos.X, headPos.Y + height + 2)
        end
        if drawings.Tracer then
            drawings.Tracer.Visible = Config.ESP.Tracer
            drawings.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
            drawings.Tracer.To = Vector2.new(headPos.X, headPos.Y + height/2)
            drawings.Tracer.Color = color
        end
    end
end

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then createESP(plr) end
end
Players.PlayerAdded:Connect(createESP)
Players.PlayerRemoving:Connect(removeESP)

-- ============ AIMBOT ============
local function getClosestTarget()
    local closest, shortest = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        if Config.Aimbot.TeamCheck and plr.Team == LocalPlayer.Team then continue end
        if not isAlive(plr) then continue end
        local char = plr.Character
        local part = char:FindFirstChild(Config.Aimbot.Part) or char:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if dist > Config.Aimbot.FOV then continue end
        local worldDist = (part.Position - Camera.CFrame.Position).Magnitude
        if worldDist > Config.Aimbot.MaxDistance then continue end
        if Config.Aimbot.WallCheck and not Config.Wallbang.Enabled then
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = {LocalPlayer.Character, plr.Character}
            params.FilterType = Enum.RaycastFilterType.Exclude
            local ray = Workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, params)
            if ray then continue end
        end
        if dist < shortest then shortest = dist; closest = part end
    end
    return closest
end

local function smoothAim(target)
    if not target then return end
    local targetCF = CFrame.new(Camera.CFrame.Position, target.Position)
    Camera.CFrame = Camera.CFrame:Lerp(targetCF, Config.Aimbot.Smoothness)
end

RunService.RenderStepped:Connect(function()
    if Config.Aimbot.Enabled and UserInputService:IsKeyDown(Config.Aimbot.Key) then
        smoothAim(getClosestTarget())
    end
    if Config.ESP.Enabled then updateESP() end
end)

-- ============ MOVEMENT ============
local flyBodyVel, flyBodyGyro = nil, nil

local function applyMovement()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    hum.WalkSpeed = Config.Movement.SpeedEnabled and Config.Movement.WalkSpeed or 16
    hum.JumpPower = Config.Movement.JumpEnabled and Config.Movement.JumpPower or 50
end

local function stopFly()
    local char = LocalPlayer.Character
    if flyBodyVel then flyBodyVel:Destroy(); flyBodyVel = nil end
    if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.Anchored = false end
end

local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    stopFly()
    flyBodyVel = create("BodyVelocity", {
        Parent = hrp, MaxForce = Vector3.new(1,1,1) * 1e5,
        Velocity = Vector3.new(0,0,0), P = 1250,
    })
    flyBodyGyro = create("BodyGyro", {
        Parent = hrp, MaxTorque = Vector3.new(1,1,1) * 1e5,
        P = 1250, CFrame = hrp.CFrame,
    })
end

RunService.RenderStepped:Connect(function()
    applyMovement()
    if Config.Movement.FlyEnabled and flyBodyVel and Camera then
        local move = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0,1,0) end
        flyBodyVel.Velocity = move.Unit * Config.Movement.FlySpeed * (move.Magnitude > 0 and 1 or 0)
        flyBodyGyro.CFrame = Camera.CFrame
    end
    if Config.Movement.NoClip then
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

-- ============ WALLBANG ============
local wallbangRestoreTasks = {}

local function applyWallbang()
    if not Config.Wallbang.Enabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local origin = hrp.Position
    local radius = Config.Wallbang.Radius

    if Config.Wallbang.IgnoreWalls then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part ~= hrp then
                if part:IsDescendantOf(char) then continue end
                local isPlayerPart = false
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and part:IsDescendantOf(plr.Character) then
                        isPlayerPart = true
                        break
                    end
                end
                if isPlayerPart then continue end
                if (part.Position - origin).Magnitude > radius then continue end
                if part.CanQuery then
                    local old = part.CanQuery
                    part.CanQuery = false
                    if not wallbangRestoreTasks[part] then
                        wallbangRestoreTasks[part] = true
                        task.delay(Config.Wallbang.RestoreDelay, function()
                            if part and part.Parent then part.CanQuery = old end
                            wallbangRestoreTasks[part] = nil
                        end)
                    end
                end
            end
        end
    end

    if Config.Wallbang.IgnoreEnemyCollide then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == LocalPlayer then continue end
            if plr.Team == LocalPlayer.Team then continue end
            if not isAlive(plr) then continue end
            local echar = plr.Character
            local ehrp = echar and echar:FindFirstChild("HumanoidRootPart")
            if not ehrp then continue end
            if (ehrp.Position - origin).Magnitude > radius then continue end
            for _, part in ipairs(echar:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    local old = part.CanCollide
                    part.CanCollide = false
                    if not wallbangRestoreTasks[part] then
                        wallbangRestoreTasks[part] = true
                        task.delay(Config.Wallbang.RestoreDelay, function()
                            if part and part.Parent then part.CanCollide = old end
                            wallbangRestoreTasks[part] = nil
                        end)
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        if Config.Wallbang.Enabled then pcall(applyWallbang) end
        task.wait(0.05)
    end
end)

-- ============ SPINBOT ============
local spinAngle = 0
local spinAlignOrientation = nil

local function stopSpinbot()
    if spinAlignOrientation then
        spinAlignOrientation:Destroy()
        spinAlignOrientation = nil
    end
end

local function startSpinbot()
    stopSpinbot()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local att0 = Instance.new("Attachment"); att0.Parent = hrp
    local att1 = Instance.new("Attachment"); att1.Parent = hrp
    att1.Position = Vector3.new(0, 0, 1)
    spinAlignOrientation = Instance.new("AlignOrientation")
    spinAlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    spinAlignOrientation.Attachment0 = att0
    spinAlignOrientation.Attachment1 = att1
    spinAlignOrientation.MaxTorque = 1e6
    spinAlignOrientation.Responsiveness = 200
    spinAlignOrientation.Parent = hrp
end

RunService.RenderStepped:Connect(function(dt)
    if not Config.Wallbang.SpinEnabled then
        if spinAlignOrientation then stopSpinbot() end
        return
    end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    spinAngle = (spinAngle + Config.Wallbang.SpinSpeed * dt) % 360
    local jitterYaw = 0
    if Config.Wallbang.JitterEnabled then
        jitterYaw = math.rad(math.random(-Config.Wallbang.JitterAmount, Config.Wallbang.JitterAmount))
    end
    local yawPart = (Config.Wallbang.SpinDirection == "Yaw" or Config.Wallbang.SpinDirection == "Both")
        and math.rad(spinAngle) + jitterYaw or 0
    local pitchPart = (Config.Wallbang.SpinDirection == "Pitch" or Config.Wallbang.SpinDirection == "Both")
        and math.rad(Config.Wallbang.SpinPitch) or 0
    hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(pitchPart, yawPart, 0)
end)

-- ============ UI ROOT ============
local ScreenGui = create("ScreenGui", {
    Name = "EducationalMenu", ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = LocalPlayer:WaitForChild("PlayerGui"),
})

local MainFrame = create("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 660, 0, 500),
    Position = UDim2.new(0.5, -330, 0.5, -250),
    BackgroundColor3 = Theme.BgDark,
    BorderSizePixel = 0,
})
create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = MainFrame})
local MainStroke = create("UIStroke", {Color = Theme.Neon, Thickness = 1.8, Parent = MainFrame, Transparency = 0.15})
create("UIGradient", {
    Parent = MainFrame,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.BgMid),
        ColorSequenceKeypoint.new(0.5, Theme.BgDark),
        ColorSequenceKeypoint.new(1, Theme.BgMid),
    }),
    Rotation = 90,
})
local GlowFrame = create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, 20, 1, 20),
    Position = UDim2.new(0, -10, 0, -10),
    BackgroundTransparency = 1, ZIndex = 0,
})
local GlowStroke = create("UIStroke", {Color = Theme.Neon, Thickness = 4, Parent = GlowFrame, Transparency = 0.9})
create("UICorner", {CornerRadius = UDim.new(0, 18), Parent = GlowFrame})

-- ============ TITLE BAR ============
local TitleBar = create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, 0, 0, 44),
    BackgroundColor3 = Theme.BgMid, BorderSizePixel = 0,
})
create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = TitleBar})
create("Frame", {
    Parent = TitleBar, Size = UDim2.new(1, 0, 0, 22),
    Position = UDim2.new(0, 0, 1, -22), BackgroundColor3 = Theme.BgMid, BorderSizePixel = 0,
})
create("Frame", {
    Parent = TitleBar, Size = UDim2.new(1, -20, 0, 2),
    Position = UDim2.new(0, 10, 1, -2),
    BackgroundColor3 = Theme.Neon, BorderSizePixel = 0, ZIndex = 2,
})

local Title = create("TextLabel", {
    Parent = TitleBar,
    Size = UDim2.new(1, -220, 1, 0), Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1, Text = T("title"),
    TextColor3 = Theme.NeonSoft,
    Font = Enum.Font.GothamBold, TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
})
register("title", Title)

local LangBtn = create("TextButton", {
    Parent = TitleBar,
    Size = UDim2.new(0, 84, 0, 28), Position = UDim2.new(1, -196, 0, 8),
    BackgroundColor3 = Theme.NeonDark, Text = "RU / EN",
    TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 12,
    BorderSizePixel = 0, AutoButtonColor = false,
})
create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = LangBtn})
create("UIStroke", {Color = Theme.Neon, Thickness = 1, Parent = LangBtn, Transparency = 0.3})

local CloseBtn = create("TextButton", {
    Parent = TitleBar,
    Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -36, 0, 8),
    BackgroundColor3 = Theme.Red, Text = "✕",
    TextColor3 = Color3.new(1,1,1),
    Font = Enum.Font.GothamBold, TextSize = 14, BorderSizePixel = 0, AutoButtonColor = false,
})
create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = CloseBtn})

local MinBtn = create("TextButton", {
    Parent = TitleBar,
    Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -70, 0, 8),
    BackgroundColor3 = Theme.Orange, Text = "—",
    TextColor3 = Color3.new(1,1,1),
    Font = Enum.Font.GothamBold, TextSize = 14, BorderSizePixel = 0, AutoButtonColor = false,
})
create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = MinBtn})

local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ============ LAYOUT ============
local Body = create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, -20, 1, -64),
    Position = UDim2.new(0, 10, 0, 54),
    BackgroundTransparency = 1,
})

local SideBar = create("Frame", {
    Parent = Body,
    Size = UDim2.new(0, 160, 1, 0),
    BackgroundColor3 = Theme.BgTab, BorderSizePixel = 0,
})
create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = SideBar})
create("UIStroke", {Color = Theme.Neon, Thickness = 1, Parent = SideBar, Transparency = 0.55})
create("UIListLayout", {
    Parent = SideBar, Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
})
create("UIPadding", {
    Parent = SideBar, PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6),
})

local ContentFrame = create("Frame", {
    Parent = Body,
    Size = UDim2.new(1, -172, 1, 0),
    Position = UDim2.new(0, 172, 0, 0),
    BackgroundColor3 = Theme.BgTab, BorderSizePixel = 0,
})
create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = ContentFrame})
create("UIStroke", {Color = Theme.Neon, Thickness = 1, Parent = ContentFrame, Transparency = 0.55})

-- ============ TABS ============
local Tabs = {}
local ActiveTab = nil

local function createTabPage(parent)
    local page = create("ScrollingFrame", {
        Parent = parent,
        Size = UDim2.new(1, -16, 1, -16),
        Position = UDim2.new(0, 8, 0, 8),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Neon,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    })
    create("UIListLayout", {Parent = page, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})
    create("UIPadding", {Parent = page, PaddingRight = UDim.new(0, 6), PaddingLeft = UDim.new(0, 2)})
    return page
end

local function switchTab(id)
    if ActiveTab == id then return end
    for tid, tab in pairs(Tabs) do
        if tid == id then
            tab.page.Visible = true
            TweenService:Create(tab.button, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
                BackgroundColor3 = Theme.BgTabActive,
            }):Play()
            TweenService:Create(tab.stroke, TweenInfo.new(0.2), {Transparency = 0.1, Thickness = 1.5}):Play()
        else
            tab.page.Visible = false
            TweenService:Create(tab.button, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
                BackgroundColor3 = Color3.fromRGB(34, 20, 48),
            }):Play()
            TweenService:Create(tab.stroke, TweenInfo.new(0.2), {Transparency = 0.8, Thickness = 1}):Play()
        end
    end
    ActiveTab = id
end

local function addTab(id, locKey)
    local btn = create("TextButton", {
        Parent = SideBar,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(34, 20, 48),
        Text = T(locKey),
        TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        BorderSizePixel = 0, AutoButtonColor = false,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 7), Parent = btn})
    create("UIPadding", {Parent = btn, PaddingLeft = UDim.new(0, 12)})
    local stroke = create("UIStroke", {Color = Theme.Neon, Thickness = 1, Parent = btn, Transparency = 0.8})
    local page = createTabPage(ContentFrame)
    register(locKey, btn)

    btn.MouseEnter:Connect(function()
        if ActiveTab ~= id then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.BgRowHover}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if ActiveTab ~= id then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(34, 20, 48)}):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function() switchTab(id) end)

    Tabs[id] = {button = btn, page = page, stroke = stroke}
    return page
end

local CombatPage = addTab("combat", "tab_combat")
local VisualPage = addTab("visual", "tab_visual")
local MovePage = addTab("move", "tab_move")
local MiscPage = addTab("misc", "tab_misc")

-- ============ BIND INPUT SYSTEM ============
local binding = nil
local bindOverlay = nil
local function keyName(key)
    if not key or key == Enum.KeyCode.Unknown then return "—" end
    return key.Name
end

local function stopBindMode()
    if bindOverlay then bindOverlay:Destroy(); bindOverlay = nil end
    if binding and binding.uiLabel then
        binding.uiLabel.Text = T("bind_change")
        TweenService:Create(binding.uiLabel, TweenInfo.new(0.2), {BackgroundColor3 = Theme.NeonDark}):Play()
    end
    binding = nil
end

local function startBindMode(bindInfo)
    stopBindMode()
    binding = bindInfo
    bindInfo.uiLabel.Text = T("bind_wait")
    TweenService:Create(bindInfo.uiLabel, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Neon}):Play()
    bindOverlay = create("TextButton", {
        Parent = ScreenGui,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 100,
    })
    bindOverlay.MouseButton1Click:Connect(function() stopBindMode() end)
end

-- Обработка нажатий: бинды и бинд-режим
UserInputService.InputBegan:Connect(function(input, gp)
    -- Режим бинда
    if binding then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.Escape then
                -- отвязать клавишу
                binding.target[binding.keyField] = nil
                if binding.uiLabel then binding.uiLabel.Text = "—" end
                binding = nil
                if bindOverlay then bindOverlay:Destroy(); bindOverlay = nil end
                rebuildBinds()
                return
            end
            binding.target[binding.keyField] = input.KeyCode
            if binding.uiLabel then binding.uiLabel.Text = keyName(input.KeyCode) end
            TweenService:Create(binding.uiLabel, TweenInfo.new(0.2), {BackgroundColor3 = Theme.NeonDark}):Play()
            binding = nil
            if bindOverlay then bindOverlay:Destroy(); bindOverlay = nil end
            rebuildBinds()
        end
        return
    end

    if gp then return end

    -- Хоткей меню
    if input.KeyCode == Config.UI.ToggleKey then
        MainFrame.Visible = not MainFrame.Visible
        return
    end

    -- Универсальная обработка биндов-переключателей
    if Binds[input.KeyCode] then
        Binds[input.KeyCode]()
    end
end)

-- ============ UI BUILDERS ============
local function createSection(parent, locKey, color)
    color = color or Theme.Neon
    local section = create("Frame", {
        Parent = parent, Size = UDim2.new(1, -10, 0, 34),
        BackgroundColor3 = Theme.BgMid, BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = section})
    create("UIStroke", {Color = color, Thickness = 1, Parent = section, Transparency = 0.4})
    local accent = create("Frame", {
        Parent = section, Size = UDim2.new(0, 3, 1, -8),
        Position = UDim2.new(0, 8, 0, 4),
        BackgroundColor3 = color, BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = accent})
    local lbl = create("TextLabel", {
        Parent = section,
        Size = UDim2.new(1, -24, 1, 0), Position = UDim2.new(0, 18, 0, 0),
        BackgroundTransparency = 1, Text = T(locKey),
        TextColor3 = color, Font = Enum.Font.GothamBold, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    register(locKey, lbl)
    return section
end

local function hoverAnimation(row, normalColor, hoverColor)
    row.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
    end)
    row.MouseLeave:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
    end)
end

-- Тумблер с дополнительной кнопкой бинда
local function createToggle(parent, locKey, default, callback, bindTable, bindField)
    local row = create("Frame", {
        Parent = parent, Size = UDim2.new(1, -10, 0, 32),
        BackgroundColor3 = Theme.BgRow, BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = row})
    local label = create("TextLabel", {
        Parent = row, Size = UDim2.new(1, -100, 1, 0), Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1, Text = T(locKey),
        TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    register(locKey, label)

    -- Кнопка бинда (если переданы bindTable / bindField)
    if bindTable and bindField then
        local bindBtn = create("TextButton", {
            Parent = row, Size = UDim2.new(0, 44, 0, 20), Position = UDim2.new(1, -104, 0.5, -10),
            BackgroundColor3 = Theme.NeonDark, Text = keyName(bindTable[bindField]),
            TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 11,
            BorderSizePixel = 0, AutoButtonColor = false,
        })
        create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = bindBtn})
        create("UIStroke", {Color = Theme.Neon, Thickness = 1, Parent = bindBtn, Transparency = 0.4})
        bindBtn.MouseButton1Click:Connect(function()
            startBindMode({target = bindTable, keyField = bindField, uiLabel = bindBtn})
        end)
    end

    local btn = create("TextButton", {
        Parent = row, Size = UDim2.new(0, 44, 0, 20), Position = UDim2.new(1, -54, 0.5, -10),
        BackgroundColor3 = default and Theme.Green or Color3.fromRGB(55, 40, 75),
        Text = "", BorderSizePixel = 0, AutoButtonColor = false,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = btn})
    local knob = create("Frame", {
        Parent = btn, Size = UDim2.new(0, 16, 0, 16),
        Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Color3.new(1,1,1), BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = knob})
    local state = default

    local function setState(newState)
        state = newState
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Theme.Green or Color3.fromRGB(55, 40, 75)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        }):Play()
        callback(state)
    end

    btn.MouseButton1Click:Connect(function() setState(not state) end)
    hoverAnimation(row, Theme.BgRow, Theme.BgRowHover)

    -- Регистрируем бинд-toggle
    if bindTable and bindField then
        addBind({
            table = bindTable, keyField = bindField,
            fn = function() setState(not state) end,
        })
    end

    return row
end

local function createSlider(parent, locKey, min, max, default, callback)
    local row = create("Frame", {
        Parent = parent, Size = UDim2.new(1, -10, 0, 42),
        BackgroundColor3 = Theme.BgRow, BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = row})
    local label = create("TextLabel", {
        Parent = row, Size = UDim2.new(1, -100, 0, 20), Position = UDim2.new(0, 10, 0, 2),
        BackgroundTransparency = 1, Text = T(locKey),
        TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    register(locKey, label)
    local valueLabel = create("TextLabel", {
        Parent = row, Size = UDim2.new(0, 80, 0, 20), Position = UDim2.new(1, -90, 0, 2),
        BackgroundTransparency = 1, Text = tostring(default),
        TextColor3 = Theme.NeonSoft, Font = Enum.Font.GothamBold, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
    })
    local bar = create("Frame", {
        Parent = row, Size = UDim2.new(1, -20, 0, 6), Position = UDim2.new(0, 10, 0, 28),
        BackgroundColor3 = Color3.fromRGB(55, 40, 75), BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 3), Parent = bar})
    local fill = create("Frame", {
        Parent = bar, Size = UDim2.new((default - min)/(max - min), 0, 1, 0),
        BackgroundColor3 = Theme.Neon, BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 3), Parent = fill})
    create("UIStroke", {Color = Theme.NeonSoft, Thickness = 1, Parent = fill, Transparency = 0.4})
    local button = create("TextButton", {
        Parent = bar, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "",
    })
    local draggingS = false
    local function update(input)
        local relX = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * relX + 0.5)
        fill.Size = UDim2.new(relX, 0, 1, 0)
        valueLabel.Text = tostring(val)
        callback(val)
    end
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingS = true; update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingS = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingS and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
    end)
    hoverAnimation(row, Theme.BgRow, Theme.BgRowHover)
    return row
end

local function createCycleButton(parent, locKey, options, defaultIndex, callback)
    local row = create("Frame", {
        Parent = parent, Size = UDim2.new(1, -10, 0, 32),
        BackgroundColor3 = Theme.BgRow, BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = row})
    local label = create("TextLabel", {
        Parent = row, Size = UDim2.new(0.55, -10, 1, 0), Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1, Text = T(locKey),
        TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    register(locKey, label)
    local btn = create("TextButton", {
        Parent = row, Size = UDim2.new(0.35, 0, 0, 22), Position = UDim2.new(0.6, -10, 0.5, -11),
        BackgroundColor3 = Theme.NeonDark, Text = options[defaultIndex],
        TextColor3 = Theme.NeonSoft, Font = Enum.Font.GothamBold, TextSize = 12,
        BorderSizePixel = 0, AutoButtonColor = false,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = btn})
    create("UIStroke", {Color = Theme.Neon, Thickness = 1, Parent = btn, Transparency = 0.4})
    local idx = defaultIndex
    btn.MouseButton1Click:Connect(function()
        idx = idx % #options + 1
        btn.Text = options[idx]
        callback(options[idx])
    end)
    hoverAnimation(row, Theme.BgRow, Theme.BgRowHover)
    return row
end

-- Отдельная кнопка бинда (для параметров, не тумблеров — например, hold-клавиш)
local function createKeybind(parent, locKey, targetTable, keyField)
    local row = create("Frame", {
        Parent = parent, Size = UDim2.new(1, -10, 0, 32),
        BackgroundColor3 = Theme.BgRow, BorderSizePixel = 0,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = row})
    local label = create("TextLabel", {
        Parent = row, Size = UDim2.new(0.55, -10, 1, 0), Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1, Text = T(locKey),
        TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    register(locKey, label)
    local btn = create("TextButton", {
        Parent = row, Size = UDim2.new(0.35, 0, 0, 22), Position = UDim2.new(0.6, -10, 0.5, -11),
        BackgroundColor3 = Theme.NeonDark, Text = keyName(targetTable[keyField]),
        TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 12,
        BorderSizePixel = 0, AutoButtonColor = false,
    })
    create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = btn})
    create("UIStroke", {Color = Theme.Neon, Thickness = 1, Parent = btn, Transparency = 0.4})
    btn.MouseButton1Click:Connect(function()
        startBindMode({target = targetTable, keyField = keyField, uiLabel = btn})
    end)
    hoverAnimation(row, Theme.BgRow, Theme.BgRowHover)
    return row
end

-- ============ BUILD PAGES ============
-- COMBAT — Aimbot + Wallbang/Spinbot
createSection(CombatPage, "sec_aimbot")
createToggle(CombatPage, "aim_enable", false, function(v) Config.Aimbot.Enabled = v end, Config.Aimbot, "ToggleKey")
createToggle(CombatPage, "aim_team", true, function(v) Config.Aimbot.TeamCheck = v end, Config.Aimbot, "TeamCheckKey")
createToggle(CombatPage, "aim_wall", true, function(v) Config.Aimbot.WallCheck = v end, Config.Aimbot, "WallCheckKey")
createKeybind(CombatPage, "aim_key", Config.Aimbot, "Key")
createSlider(CombatPage, "aim_fov", 30, 500, 120, function(v) Config.Aimbot.FOV = v end)
createSlider(CombatPage, "aim_smooth", 1, 100, 25, function(v) Config.Aimbot.Smoothness = v / 100 end)
createSlider(CombatPage, "aim_dist", 50, 2000, 500, function(v) Config.Aimbot.MaxDistance = v end)

createSection(CombatPage, "sec_wall", Theme.Pink)
createToggle(CombatPage, "wall_enable", false, function(v) Config.Wallbang.Enabled = v end, Config.Wallbang, "WallbangKey")
createToggle(CombatPage, "wall_ignore", true, function(v) Config.Wallbang.IgnoreWalls = v end, Config.Wallbang, "IgnoreWallsKey")
createToggle(CombatPage, "wall_enemy", true, function(v) Config.Wallbang.IgnoreEnemyCollide = v end, Config.Wallbang, "IgnoreEnemiesKey")
createSlider(CombatPage, "wall_radius", 50, 1000, 200, function(v) Config.Wallbang.Radius = v end)
createToggle(CombatPage, "wall_spin", false, function(v)
    Config.Wallbang.SpinEnabled = v
    if v then startSpinbot() else stopSpinbot() end
end, Config.Wallbang, "SpinKey")
createToggle(CombatPage, "wall_jitter", false, function(v) Config.Wallbang.JitterEnabled = v end, Config.Wallbang, "JitterKey")
createSlider(CombatPage, "wall_jitter_val", 1, 100, 25, function(v) Config.Wallbang.JitterAmount = v end)
createSlider(CombatPage, "wall_spin_val", 50, 2000, 400, function(v) Config.Wallbang.SpinSpeed = v end)
createSlider(CombatPage, "wall_pitch", -90, 90, 0, function(v) Config.Wallbang.SpinPitch = v end)
createCycleButton(CombatPage, "wall_dir", {"Yaw", "Pitch", "Both"}, 1, function(v) Config.Wallbang.SpinDirection = v end)

-- VISUAL — ESP
createSection(VisualPage, "sec_esp", Theme.Blue)
createToggle(VisualPage, "esp_enable", false, function(v) Config.ESP.Enabled = v end, Config.ESP, "Key")
createToggle(VisualPage, "esp_box", true, function(v) Config.ESP.Box = v end, Config.ESP, "BoxKey")
createToggle(VisualPage, "esp_name", true, function(v) Config.ESP.Name = v end, Config.ESP, "NameKey")
createToggle(VisualPage, "esp_health", true, function(v) Config.ESP.Health = v end, Config.ESP, "HealthKey")
createToggle(VisualPage, "esp_dist", true, function(v) Config.ESP.Distance = v end, Config.ESP, "DistanceKey")
createToggle(VisualPage, "esp_tracer", false, function(v) Config.ESP.Tracer = v end, Config.ESP, "TracerKey")
createToggle(VisualPage, "esp_team", true, function(v) Config.ESP.TeamCheck = v end, Config.ESP, "TeamCheckKey")
createSlider(VisualPage, "esp_max", 100, 5000, 1000, function(v) Config.ESP.MaxDistance = v end)

-- MOVEMENT
createSection(MovePage, "sec_move", Theme.Green)
createToggle(MovePage, "move_speed", false, function(v) Config.Movement.SpeedEnabled = v end, Config.Movement, "SpeedKey")
createSlider(MovePage, "move_speed_val", 1, 500, 16, function(v) Config.Movement.WalkSpeed = v end)
createToggle(MovePage, "move_jump", false, function(v) Config.Movement.JumpEnabled = v end, Config.Movement, "JumpKey")
createSlider(MovePage, "move_jump_val", 1, 500, 50, function(v) Config.Movement.JumpPower = v end)
createToggle(MovePage, "move_fly", false, function(v)
    Config.Movement.FlyEnabled = v
    if v then startFly() else stopFly() end
end, Config.Movement, "FlyKey")
createSlider(MovePage, "move_fly_val", 5, 500, 50, function(v) Config.Movement.FlySpeed = v end)
createToggle(MovePage, "move_noclip", false, function(v) Config.Movement.NoClip = v end, Config.Movement, "NoClipKey")

-- MISC
createSection(MiscPage, "sec_ui", Theme.Orange)
createKeybind(MiscPage, "ui_key", Config.UI, "ToggleKey")

createSection(MiscPage, "sec_lang", Theme.NeonSoft)
local langRow = create("Frame", {
    Parent = MiscPage, Size = UDim2.new(1, -10, 0, 32),
    BackgroundColor3 = Theme.BgRow, BorderSizePixel = 0,
})
create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = langRow})
local langLabel = create("TextLabel", {
    Parent = langRow, Size = UDim2.new(0.55, -10, 1, 0), Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1, Text = T("lang_switch"),
    TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
})
register("lang_switch", langLabel)
local langChoice = create("TextButton", {
    Parent = langRow, Size = UDim2.new(0.35, 0, 0, 22), Position = UDim2.new(0.6, -10, 0.5, -11),
    BackgroundColor3 = Theme.NeonDark, Text = "RU / EN",
    TextColor3 = Theme.NeonSoft, Font = Enum.Font.GothamBold, TextSize = 12,
    BorderSizePixel = 0, AutoButtonColor = false,
})
create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = langChoice})
create("UIStroke", {Color = Theme.Neon, Thickness = 1, Parent = langChoice, Transparency = 0.4})
hoverAnimation(langRow, Theme.BgRow, Theme.BgRowHover)

local footer = create("TextLabel", {
    Parent = MiscPage, Size = UDim2.new(1, -10, 0, 30),
    BackgroundTransparency = 1, Text = T("footer"),
    TextColor3 = Theme.TextDim, Font = Enum.Font.Gotham, TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Center,
})
register("footer", footer)

-- ============ LOGIC ============
local function switchLanguage()
    Config.Language = (Config.Language == "RU") and "EN" or "RU"
    langChoice.Text = (Config.Language == "RU") and "RU / EN" or "EN / RU"
    LangBtn.Text = (Config.Language == "RU") and "RU / EN" or "EN / RU"
    updateLanguage()
end
LangBtn.MouseButton1Click:Connect(switchLanguage)
langChoice.MouseButton1Click:Connect(switchLanguage)

local minimized = false
CloseBtn.MouseButton1Click:Connect(function() ScreenGui.Enabled = false end)
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = minimized and UDim2.new(0, 660, 0, 44) or UDim2.new(0, 660, 0, 500)
    }):Play()
end)

task.spawn(function()
    while ScreenGui.Parent do
        TweenService:Create(MainStroke, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Theme.NeonSoft, Transparency = 0.35
        }):Play()
        TweenService:Create(GlowStroke, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 1, Thickness = 2
        }):Play()
        task.wait(1.8)
        TweenService:Create(MainStroke, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Theme.Neon, Transparency = 0.15
        }):Play()
        TweenService:Create(GlowStroke, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.85, Thickness = 6
        }):Play()
        task.wait(1.8)
    end
end)

switchTab("combat")

print("[Educational Menu v9] Loaded — NO camera • Binds for ALL features • LEFT Tabs • i18n • Neon Purple")
print("[WARNING] Use only in YOUR OWN game for anti-cheat testing!")
