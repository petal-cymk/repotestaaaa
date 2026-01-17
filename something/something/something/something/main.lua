--[[                          __            __    __          
  _________  __  ______  / /____  _____/ /_  / /___  _  __
 / ___/ __ \/ / / / __ \/ __/ _ \/ ___/ __ \/ / __ \| |/_/
/ /__/ /_/ / /_/ / / / / /_/  __/ /  / /_/ / / /_/ />  <  
\___/\____/\__,_/_/ /_/\__/\___/_/  /_.___/_/\____/_/|_|  
    ____  ___  / /_____ _/ /                              
   / __ \/ _ \/ __/ __ `/ /                               
  / /_/ /  __/ /_/ /_/ / /                                
 / .___/\___/\__/\__,_/_/                                 
/_/                                 ]]                      
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
-- ============= --
-- [[ MODULES ]] --
-- ============= --

--[[ esp ]] loadstring(game:HttpGet("https://hasteb.in/Z5y1xKn6I8omPtd"))()



local library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local thememanager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local savemanager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local window = library:CreateWindow({
    Title = 'petal.lua | counterblox',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local tabs = {
    wallhacks = window:AddTab('wallhacks'),
    combat = window:AddTab('combat'),
    plr = window:AddTab('local'),
    world = window:AddTab('world'),
    ['ui settings'] = window:AddTab('ui settings'),
}


local Lighting = game:GetService("Lighting")

local lightingGroup = tabs.world:AddLeftGroupbox("visual")

local ambtoggle = lightingGroup:AddToggle("OverrideAmbient", {
    Text = "Override Ambient",
    Default = false
})

ambtoggle:AddColorPicker("AmbientColor", {
    Title = "Ambient Color",
    Default = Lighting.Ambient,
    Transparency = 0
})

ambtoggle:AddColorPicker("OutdoorAmbientColor", {
    Title = "Outdoor Ambient",
    Default = Lighting.OutdoorAmbient,
    Transparency = 0
})

Options.AmbientColor:OnChanged(function()
    if Toggles.OverrideAmbient.Value then
        Lighting.Ambient = Options.AmbientColor.Value
    end
end)

Options.OutdoorAmbientColor:OnChanged(function()
    if Toggles.OverrideAmbient.Value then
        Lighting.OutdoorAmbient = Options.OutdoorAmbientColor.Value
    end
end)

Toggles.OverrideAmbient:OnChanged(function(v)
    if v then
        Lighting.Ambient = Options.AmbientColor.Value
        Lighting.OutdoorAmbient = Options.OutdoorAmbientColor.Value
    else
        Lighting.Ambient = Color3.fromRGB(128,128,128) -- default fallback
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    end
end)

lightingGroup:AddToggle("OverrideBrightness", {
    Text = "Override Brightness",
    Default = false
})

lightingGroup:AddSlider("BrightnessValue", {
    Text = "Brightness",
    Min = 0,
    Max = 10,
    Rounding = 2,
    Default = Lighting.Brightness
})

Options.BrightnessValue:OnChanged(function()
    if Toggles.OverrideBrightness.Value then
        Lighting.Brightness = Options.BrightnessValue.Value
    end
end)

Toggles.OverrideBrightness:OnChanged(function(v)
    if v then
        Lighting.Brightness = Options.BrightnessValue.Value
    else
        Lighting.Brightness = 2
    end
end)

local colshifttoggle = lightingGroup:AddToggle("OverrideColorShift", {
    Text = "Override ColorShift",
    Default = false
})

colshifttoggle:AddColorPicker("ColorShiftTop", {
    Title = "ColorShift Top",
    Default = Lighting.ColorShift_Top,
    Transparency = 0
})

colshifttoggle:AddColorPicker("ColorShiftBottom", {
    Title = "ColorShift Bottom",
    Default = Lighting.ColorShift_Bottom,
    Transparency = 0
})

Options.ColorShiftTop:OnChanged(function()
    if Toggles.OverrideColorShift.Value then
        Lighting.ColorShift_Top = Options.ColorShiftTop.Value
    end
end)

Options.ColorShiftBottom:OnChanged(function()
    if Toggles.OverrideColorShift.Value then
        Lighting.ColorShift_Bottom = Options.ColorShiftBottom.Value
    end
end)

Toggles.OverrideColorShift:OnChanged(function(v)
    if v then
        Lighting.ColorShift_Top = Options.ColorShiftTop.Value
        Lighting.ColorShift_Bottom = Options.ColorShiftBottom.Value
    else
        Lighting.ColorShift_Top = Color3.new(0,0,0)
        Lighting.ColorShift_Bottom = Color3.new(0,0,0)
    end
end)

lightingGroup:AddToggle("ShadowsEnabled", {
    Text = "Shadows",
    Default = Lighting.ShadowSoftness > 0
})

Toggles.ShadowsEnabled:OnChanged(function(v)
    Lighting.GlobalShadows = v
end)

lightingGroup:AddToggle("OverrideClockTime", {
    Text = "Override ClockTime",
    Default = false
})

lightingGroup:AddSlider("ClockTimeValue", {
    Text = "ClockTime",
    Min = 0,
    Max = 24,
    Rounding = 2,
    Default = Lighting.ClockTime
})

Options.ClockTimeValue:OnChanged(function()
    if Toggles.OverrideClockTime.Value then
        Lighting.ClockTime = Options.ClockTimeValue.Value
    end
end)

Toggles.OverrideClockTime:OnChanged(function(v)
    if v then
        Lighting.ClockTime = Options.ClockTimeValue.Value
    else
        Lighting.ClockTime = 14
    end
end)

local fogcoltoggle = lightingGroup:AddToggle("OverrideFogColor", {
    Text = "Override Fog Color",
    Default = false
})

fogcoltoggle:AddColorPicker("FogColorValue", {
    Text = "Fog Color",
    Default = Lighting.FogColor,
    Transparency = 0
})

Options.FogColorValue:OnChanged(function()
    if Toggles.OverrideFogColor.Value then
        Lighting.FogColor = Options.FogColorValue.Value
    end
end)

Toggles.OverrideFogColor:OnChanged(function(v)
    if v then
        Lighting.FogColor = Options.FogColorValue.Value
    else
        Lighting.FogColor = Color3.fromRGB(192,192,192)
    end
end)

lightingGroup:AddToggle("OverrideFogDistance", {
    Text = "Override Fog Distance",
    Default = false
})

lightingGroup:AddSlider("FogStartValue", {
    Text = "Fog Start",
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Default = Lighting.FogStart
})

lightingGroup:AddSlider("FogEndValue", {
    Text = "Fog End",
    Min = 0,
    Max = 10000,
    Rounding = 0,
    Default = Lighting.FogEnd
})

local function updateFog()
    if Toggles.OverrideFogDistance.Value then
        Lighting.FogStart = Options.FogStartValue.Value
        Lighting.FogEnd = Options.FogEndValue.Value
    end
end

Options.FogStartValue:OnChanged(updateFog)
Options.FogEndValue:OnChanged(updateFog)

Toggles.OverrideFogDistance:OnChanged(function(v)
    if v then
        updateFog()
    else
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
    end
end)

local function applyLightingSettings()
    if Toggles.OverrideAmbient.Value then
        Lighting.Ambient = Options.AmbientColor.Value
        Lighting.OutdoorAmbient = Options.OutdoorAmbientColor.Value
    else
        Lighting.Ambient = Color3.fromRGB(128,128,128)
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    end

    if Toggles.OverrideBrightness.Value then
        Lighting.Brightness = Options.BrightnessValue.Value
    else
        Lighting.Brightness = 2
    end

    if Toggles.OverrideColorShift.Value then
        Lighting.ColorShift_Top = Options.ColorShiftTop.Value
        Lighting.ColorShift_Bottom = Options.ColorShiftBottom.Value
    else
        Lighting.ColorShift_Top = Color3.new(0,0,0)
        Lighting.ColorShift_Bottom = Color3.new(0,0,0)
    end

    Lighting.GlobalShadows = Toggles.ShadowsEnabled.Value

    if Toggles.OverrideClockTime.Value then
        Lighting.ClockTime = Options.ClockTimeValue.Value
    else
        Lighting.ClockTime = 14
    end

    if Toggles.OverrideFogColor.Value then
        Lighting.FogColor = Options.FogColorValue.Value
    else
        Lighting.FogColor = Color3.fromRGB(192,192,192)
    end

    if Toggles.OverrideFogDistance.Value then
        Lighting.FogStart = Options.FogStartValue.Value
        Lighting.FogEnd = Options.FogEndValue.Value
    else
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
    end
end

applyLightingSettings()

for _, toggle in pairs({
    Toggles.OverrideAmbient,
    Toggles.OverrideBrightness,
    Toggles.OverrideColorShift,
    Toggles.ShadowsEnabled,
    Toggles.OverrideClockTime,
    Toggles.OverrideFogColor,
    Toggles.OverrideFogDistance
}) do
    toggle:OnChanged(applyLightingSettings)
end



local resolvers = tabs.plr:AddLeftGroupbox('resolvers/manip')

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

getgenv().TPKillEnabled = false
getgenv().TPKillKey = Enum.KeyCode.J
local holding = false
local target = nil
local originalPos = nil
local camLocked = false

local function getClosestPlayerToMouse()
    local cam = workspace.CurrentCamera
    local mousePos = UIS:GetMouseLocation()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= lp and (not lp.Team or plr.Team ~= lp.Team) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local rootPos = plr.Character.HumanoidRootPart.Position
            local screenPos, onScreen = cam:WorldToViewportPoint(rootPos)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPlayer = plr
                end
            end
        end
    end
    return closestPlayer
end

local function followTarget()
    if holding and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") 
        and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then

        local tRoot = target.Character.HumanoidRootPart
        local offset = -tRoot.CFrame.LookVector * 3
        local behindPos = tRoot.Position + offset
        local lookAtPos = tRoot.Position
        local direction = (lookAtPos - behindPos).Unit

        lp.Character.HumanoidRootPart.CFrame = CFrame.new(behindPos, behindPos + direction)

        if not camLocked then
            workspace.CurrentCamera.CFrame = CFrame.new(behindPos, behindPos + direction)
            camLocked = true
        end
    end
end

resolvers:AddToggle('TPKillEnabled', {
    Text = 'tp kill',
    Default = getgenv().TPKillEnabled
})

Toggles.TPKillEnabled:OnChanged(function(val)
    getgenv().TPKillEnabled = val
    if not val then
        holding = false
        target = nil
        camLocked = false
    end
end)

Toggles.TPKillEnabled:AddKeyPicker('TPKillKey', {
    Text = 'tpkill',
    Default = 'None',
    Mode = 'Toggle'
})

Options.TPKillKey:OnChanged(function()
    local v = Options.TPKillKey.Value
    if v == "None" then
        getgenv().TPKillKey = nil
    elseif v == "MB1" then
        getgenv().TPKillKey = Enum.UserInputType.MouseButton1
    elseif v == "MB2" then
        getgenv().TPKillKey = Enum.UserInputType.MouseButton2
    else
        getgenv().TPKillKey = Enum.KeyCode[v]
    end
end)

UIS.InputBegan:Connect(function(input)
    if not getgenv().TPKillEnabled then return end

    local keyMatch = (typeof(getgenv().TPKillKey) == "EnumItem" and
        ((getgenv().TPKillKey.EnumType == Enum.KeyCode and input.KeyCode == getgenv().TPKillKey) or
        (getgenv().TPKillKey.EnumType == Enum.UserInputType and input.UserInputType == getgenv().TPKillKey))
    )

    if keyMatch then
        target = getClosestPlayerToMouse()
        if target and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            holding = true
            camLocked = false
            originalPos = lp.Character.HumanoidRootPart.Position
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if holding then
        local keyMatch = (typeof(getgenv().TPKillKey) == "EnumItem" and
            ((getgenv().TPKillKey.EnumType == Enum.KeyCode and input.KeyCode == getgenv().TPKillKey) or
            (getgenv().TPKillKey.EnumType == Enum.UserInputType and input.UserInputType == getgenv().TPKillKey))
        )
        if keyMatch then
            holding = false
            target = nil
            camLocked = false
            if originalPos and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                lp.Character.HumanoidRootPart.CFrame = CFrame.new(originalPos)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if holding then
        followTarget()
    end
end)



local speedGroup = tabs.plr:AddRightGroupbox('speed')

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer

getgenv().SpeedEnabled = getgenv().SpeedEnabled or false
getgenv().SpeedValue = getgenv().SpeedValue or 24
getgenv().SpeedKey = nil

local normalSpeed = 16
local humanoid

local function updateHumanoid()
    local char = lp.Character
    if char then
        humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            normalSpeed = humanoid.WalkSpeed
        end
    end
end

lp.CharacterAdded:Connect(function()
    task.wait(0.3)
    updateHumanoid()
end)

updateHumanoid()

speedGroup:AddToggle('SpeedEnabled', {
    Text = 'speedhack',
    Default = getgenv().SpeedEnabled
})

Toggles.SpeedEnabled:OnChanged(function(v)
    getgenv().SpeedEnabled = v
    if humanoid and not v then
        humanoid.WalkSpeed = normalSpeed
    end
end)

speedGroup:AddSlider('SpeedValue', {
    Text = 'walkspeed',
    Min = 16,
    Max = 100,
    Default = getgenv().SpeedValue,
    Rounding = 0
})

Options.SpeedValue:OnChanged(function()
    getgenv().SpeedValue = Options.SpeedValue.Value
end)

Toggles.SpeedEnabled:AddKeyPicker('SpeedKey', {
    Text = 'speed key',
    Default = 'None',
    Mode = 'Toggle'
})

Options.SpeedKey:OnChanged(function()
    local v = Options.SpeedKey.Value
    if v == "None" then
        getgenv().SpeedKey = nil
    elseif v == "MB1" then
        getgenv().SpeedKey = Enum.UserInputType.MouseButton1
    elseif v == "MB2" then
        getgenv().SpeedKey = Enum.UserInputType.MouseButton2
    else
        getgenv().SpeedKey = Enum.KeyCode[v]
    end
end)

RunService.RenderStepped:Connect(function()
    if not humanoid then return end

    if getgenv().SpeedEnabled then
        humanoid.WalkSpeed = getgenv().SpeedValue
    end
end)


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local lp = Players.LocalPlayer

local cam = Workspace.CurrentCamera
if not cam then
    Workspace:GetPropertyChangedSignal("CurrentCamera"):Wait()
    cam = Workspace.CurrentCamera
end

local weaponsGroup = tabs.combat:AddRightGroupbox('Gun mods')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Weapons = ReplicatedStorage:WaitForChild("Weapons")

local originalValues = {}

local function storeAndZeroSpread(obj)
    if obj:IsA("NumberValue") and obj.Name == "Spread" then
        if not originalValues[obj] then
            originalValues[obj] = obj.Value
        end
        obj.Value = 0
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("NumberValue") then
                if not originalValues[child] then
                    originalValues[child] = child.Value
                end
                child.Value = 0
            end
            storeAndZeroSpread(child)
        end
        return
    end

    for _, child in ipairs(obj:GetChildren()) do
        storeAndZeroSpread(child)
    end
end

local function restoreSpread(obj)
    if obj:IsA("NumberValue") and originalValues[obj] then
        obj.Value = originalValues[obj]
    end

    for _, child in ipairs(obj:GetChildren()) do
        restoreSpread(child)
    end
end

weaponsGroup:AddToggle('ZeroSpread', {
    Text = 'inf accuracy',
    Tooltip = 'removes recoil/spread',
    Default = false
})

Toggles.ZeroSpread:OnChanged(function(val)
    if val then
        for _, weaponFolder in ipairs(Weapons:GetChildren()) do
            if weaponFolder:IsA("Folder") then
                storeAndZeroSpread(weaponFolder)
            end
        end
    else
        for _, weaponFolder in ipairs(Weapons:GetChildren()) do
            if weaponFolder:IsA("Folder") then
                restoreSpread(weaponFolder)
            end
        end
    end
end)

local originalReloads = {}

local function storeAndSetReload(obj)
    if obj:IsA("NumberValue") and obj.Name == "ReloadTime" then
        if not originalReloads[obj] then
            originalReloads[obj] = obj.Value
        end
        obj.Value = 0.05
    end
    for _, child in ipairs(obj:GetChildren()) do
        storeAndSetReload(child)
    end
end

local function restoreReload(obj)
    if obj:IsA("NumberValue") and obj.Name == "ReloadTime" then
        if originalReloads[obj] then
            obj.Value = originalReloads[obj]
        end
    end
    for _, child in ipairs(obj:GetChildren()) do
        restoreReload(child)
    end
end


weaponsGroup:AddToggle('FastReload', {
    Text = 'instareload',
    Default = false
})

Toggles.FastReload:OnChanged(function(val)
    if val then
        for _, weaponFolder in ipairs(Weapons:GetChildren()) do
            if weaponFolder:IsA("Folder") then
                storeAndSetReload(weaponFolder)
            end
        end
    else
        for _, weaponFolder in ipairs(Weapons:GetChildren()) do
            if weaponFolder:IsA("Folder") then
                restoreReload(weaponFolder)
            end
        end
    end
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Weapons = ReplicatedStorage:WaitForChild("Weapons")

local function setAmmo999(obj)
    if obj:IsA("NumberValue") and string.match(obj.Name:lower(), "ammo") then
        obj.Value = 999
    end
    for _, child in ipairs(obj:GetChildren()) do
        setAmmo999(child)
    end
end

weaponsGroup:AddToggle('MaxAmmo', {
    Text = 'inf ammo',
    Default = false
})

Toggles.MaxAmmo:OnChanged(function(val)
    if val then
        for _, weaponFolder in ipairs(Weapons:GetChildren()) do
            setAmmo999(weaponFolder)
        end
    end
end)

local silgroup = tabs.combat:AddLeftGroupbox('Aimbot')

getgenv().AimbotEnabled = getgenv().AimbotEnabled or false
getgenv().AimbotTeamCheck = getgenv().AimbotTeamCheck or true
getgenv().AimbotWallCheck = getgenv().AimbotWallCheck or true
getgenv().AimbotSmoothness = getgenv().AimbotSmoothness or 0.12
getgenv().AimbotHitPart = getgenv().AimbotHitPart or "Head"
getgenv().AimbotKey = nil

silgroup:AddToggle('AimbotEnabled', { Text = 'aimbot', Default = getgenv().AimbotEnabled })
Toggles.AimbotEnabled:OnChanged(function(v)
    getgenv().AimbotEnabled = v
end)

silgroup:AddToggle('AimbotTeamCheck', { Text = 'team check', Default = getgenv().AimbotTeamCheck })
Toggles.AimbotTeamCheck:OnChanged(function(v)
    getgenv().AimbotTeamCheck = v
end)

silgroup:AddToggle('AimbotWallCheck', { Text = 'wall check', Default = getgenv().AimbotWallCheck })
Toggles.AimbotWallCheck:OnChanged(function(v)
    getgenv().AimbotWallCheck = v
end)

silgroup:AddSlider('AimbotSmoothness', {
    Text = 'smoothness',
    Min = 0,
    Max = 1,
    Rounding = 2,
    Default = getgenv().AimbotSmoothness
})
Options.AimbotSmoothness:OnChanged(function()
    getgenv().AimbotSmoothness = Options.AimbotSmoothness.Value
end)

silgroup:AddDropdown('AimbotHitPart', {
    Text = 'aim part',
    Values = { 'Head', 'HumanoidRootPart' },
    Default = 1
})
Options.AimbotHitPart:OnChanged(function()
    getgenv().AimbotHitPart = Options.AimbotHitPart.Value
end)

Toggles.AimbotEnabled:AddKeyPicker('AimbotKey', {
    Text = 'aim key',
    Default = 'None',
    Mode = 'Hold'
})

Options.AimbotKey:OnChanged(function()
    local v = Options.AimbotKey.Value
    if v == "None" then
        getgenv().AimbotKey = nil
    elseif v == "MB1" then
        getgenv().AimbotKey = Enum.UserInputType.MouseButton1
    elseif v == "MB2" then
        getgenv().AimbotKey = Enum.UserInputType.MouseButton2
    else
        getgenv().AimbotKey = Enum.KeyCode[v]
    end
end)

local function teamCheck(p)
    if not getgenv().AimbotTeamCheck then return true end
    if not lp.Team or not p.Team then return true end
    return lp.Team ~= p.Team
end

local function wallCheck(part)
    if not getgenv().AimbotWallCheck then return true end
    local origin = cam.CFrame.Position
    local dir = part.Position - origin

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = { lp.Character, cam }

    local ray = Workspace:Raycast(origin, dir, params)
    return not ray or ray.Instance:IsDescendantOf(part.Parent)
end

local function getClosestTarget()
    local mousePos = UIS:GetMouseLocation()
    local closest, dist = nil, 600

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local part = p.Character:FindFirstChild(getgenv().AimbotHitPart)

            if hum and hum.Health > 0 and part and teamCheck(p) then
                local sp, vis = cam:WorldToViewportPoint(part.Position)
                if vis and sp.Z > 0 then
                    local d = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
                    if d < dist and wallCheck(part) then
                        dist = d
                        closest = part
                    end
                end
            end
        end
    end

    return closest
end

RunService.RenderStepped:Connect(function()
    if not getgenv().AimbotEnabled then return end

    if getgenv().AimbotKey then
        if getgenv().AimbotKey.EnumType == Enum.KeyCode then
            if not UIS:IsKeyDown(getgenv().AimbotKey) then return end
        else
            if not UIS:IsMouseButtonPressed(getgenv().AimbotKey) then return end
        end
    end

    local target = getClosestTarget()
    if target then
        local cf = cam.CFrame
        cam.CFrame = cf:Lerp(
            CFrame.new(cf.Position, target.Position),
            getgenv().AimbotSmoothness
        )
    end
end)

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local parts = {
    "Head",
    "UpperTorso","LowerTorso",
    "LeftUpperArm","LeftLowerArm","LeftHand",
    "RightUpperArm","RightLowerArm","RightHand",
    "LeftUpperLeg","LeftLowerLeg","LeftFoot",
    "RightUpperLeg","RightLowerLeg","RightFoot"
}

local adornments = {}
local chamColor = Color3.fromRGB(255,0,0)
local chamTransparency = 0.5

local function clearChams()
    for _, v in pairs(adornments) do
        v:Destroy()
    end
    table.clear(adornments)
end

local function applyChams(char)
    for _, name in ipairs(parts) do
        local part = char:FindFirstChild(name)
        if part and part:IsA("BasePart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = part
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Size = part.Size
            box.Color3 = chamColor
            box.Transparency = chamTransparency
            box.Parent = part
            table.insert(adornments, box)
        end
    end
end

local function refreshChams()
    clearChams()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            applyChams(plr.Character)
        end
    end
end

local chamGroup = tabs.wallhacks:AddRightGroupbox("Chams")

local chamtoggle = chamGroup:AddToggle("ChamsEnabled", {
    Text = "player chams",
    Default = false
})

chamtoggle:AddColorPicker("ChamColor", {
    Title = "color",
    Default = chamColor,
    Transparency = chamTransparency
})

Toggles.ChamsEnabled:OnChanged(function(v)
    if v then
        refreshChams()
    else
        clearChams()
    end
end)

Options.ChamColor:OnChanged(function()
    chamColor = Options.ChamColor.Value
    chamTransparency = Options.ChamColor.Transparency
    if Toggles.ChamsEnabled.Value then
        refreshChams()
    end
end)

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if Toggles.ChamsEnabled.Value then
            task.wait(0.5)
            refreshChams()
        end
    end)
end)

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local stored = {}
local chamColor = Color3.fromRGB(255, 0, 0)
local chamTransparency = 0

local function store(inst, prop, val)
    stored[inst] = stored[inst] or {}
    if stored[inst][prop] == nil then
        stored[inst][prop] = val
    end
end

local function applyBodyCham(char)
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            store(d, "Material", d.Material)
            store(d, "Color", d.Color)
            store(d, "Transparency", d.Transparency)

            d.Material = Enum.Material.Neon
            d.Color = chamColor
            d.Transparency = chamTransparency

        elseif d:IsA("Decal") or d:IsA("Texture") or d:IsA("SurfaceAppearance") then
            store(d, "Parent", d.Parent)
            d.Parent = nil
        end
    end

    local shirt = char:FindFirstChildOfClass("Shirt")
    if shirt then
        store(shirt, "Parent", shirt.Parent)
        shirt.Parent = nil
    end

    local pants = char:FindFirstChildOfClass("Pants")
    if pants then
        store(pants, "Parent", pants.Parent)
        pants.Parent = nil
    end
end

local function restoreBodyCham()
    for inst, props in pairs(stored) do
        pcall(function()
            if props.Parent then
                inst.Parent = props.Parent
            end
            for prop, val in pairs(props) do
                if prop ~= "Parent" then
                    inst[prop] = val
                end
            end
        end)
    end
    table.clear(stored)
end

local function applyToAllPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            task.spawn(function()
                local hrp = plr.Character:WaitForChild("HumanoidRootPart", 5)
                if hrp then
                    applyBodyCham(plr.Character)
                end
            end)
        end
    end
end

local bchamst = chamGroup:AddToggle("BodyChams", {
    Text = "vischams",
    Default = false
})

bchamst:AddColorPicker("BodyChamColor", {
    Title = "color",
    Default = chamColor,
    Transparency = chamTransparency
})

Toggles.BodyChams:OnChanged(function(v)
    if v then
        applyToAllPlayers()
    else
        restoreBodyCham()
    end
end)

Options.BodyChamColor:OnChanged(function()
    chamColor = Options.BodyChamColor.Value
    chamTransparency = Options.BodyChamColor.Transparency
    if Toggles.BodyChams.Value then
        applyToAllPlayers()
    end
end)

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if Toggles.BodyChams.Value then
            task.spawn(function()
                local hrp = plr.Character:WaitForChild("HumanoidRootPart", 5)
                if hrp then
                    applyBodyCham(plr.Character)
                end
            end)
        end
    end)
end)




local mainGroup = tabs.wallhacks:AddLeftGroupbox('players esp')

local espmaint = mainGroup:AddLabel('primary')

getgenv().PlayerESP_Enabled = true

mainGroup:AddToggle('ESPTeamCheck', {
	Text = 'teamcheck',
	Default = true,
	Callback = function(val)
		getgenv().PlayerESP_TeamCheck = val
	end
})


mainGroup:AddToggle('playeresp_box', {
    Text = 'boxes',
    Default = getgenv().PlayerESP_Box,
    Callback = function(val) getgenv().PlayerESP_Box = val end
})

mainGroup:AddToggle('playeresp_name', {
    Text = 'name tags',
    Default = getgenv().PlayerESP_Name,
    Callback = function(val) getgenv().PlayerESP_Name = val end
})

local hpbart = mainGroup:AddToggle('playeresp_hpbar', {
    Text = 'hp bars',
    Default = getgenv().PlayerESP_HPBar,
    Callback = function(val) getgenv().PlayerESP_HPBar = val end
})

mainGroup:AddToggle('playeresp_hptext', {
    Text = 'hp text',
    Default = getgenv().PlayerESP_HPText,
    Callback = function(val) getgenv().PlayerESP_HPText = val end
})

mainGroup:AddToggle('playeresp_distance', {
    Text = 'distance',
    Default = getgenv().PlayerESP_Distance,
    Callback = function(val) getgenv().PlayerESP_Distance = val end
})

espmaint:AddColorPicker('playeresp_color', {
    Default = getgenv().PlayerESP_Color,
    Title = 'esp color',
    Callback = function(val) getgenv().PlayerESP_Color = val end
})

espmaint:AddColorPicker('playeresp_strokecolor', {
    Default = getgenv().PlayerESP_StrokeColor,
    Title = 'stroke color',
    Callback = function(val) getgenv().PlayerESP_StrokeColor = val end
})

hpbart:AddColorPicker('playeresp_hpcolor', {
    Default = getgenv().PlayerESP_HPColor,
    Title = 'hp color',
    Callback = function(val) getgenv().PlayerESP_HPColor = val end
})

mainGroup:AddSlider('playeresp_font', {
    Text = 'font',
    Default = getgenv().PlayerESP_Font,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Callback = function(val) getgenv().PlayerESP_Font = val end
})

local glowGroup = tabs.wallhacks:AddLeftGroupbox('box glow')

glowGroup:AddToggle('boxglow_active', {
    Text = 'enable glow',
    Default = getgenv().BoxGlowActive,
    Callback = function(val) getgenv().BoxGlowActive = val end
})

glowGroup:AddSlider('boxglow_intensity', {
    Text = 'intensity',
    Default = getgenv().BoxGlowIntensity,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(val) getgenv().BoxGlowIntensity = val end
})

glowGroup:AddSlider('boxglow_extrax', {
    Text = 'extra x',
    Default = getgenv().BoxGlowExtraX,
    Min = 0,
    Max = 300,
    Rounding = 0,
    Callback = function(val) getgenv().BoxGlowExtraX = val end
})

glowGroup:AddSlider('boxglow_extray', {
    Text = 'extra y',
    Default = getgenv().BoxGlowExtraY,
    Min = 0,
    Max = 300,
    Rounding = 0,
    Callback = function(val) getgenv().BoxGlowExtraY = val end
})

local glowcol = glowGroup:AddLabel('colors')
glowcol:AddColorPicker('boxglow_color1', {
    Default = getgenv().BoxGlowColor1,
    Title = 'color 1',
    Callback = function(val) getgenv().BoxGlowColor1 = val end
})

glowcol:AddColorPicker('boxglow_color2', {
    Default = getgenv().BoxGlowColor2,
    Title = 'color 2',
    Callback = function(val) getgenv().BoxGlowColor2 = val end
})

thememanager:SetLibrary(library)
savemanager:SetLibrary(library)
savemanager:IgnoreThemeSettings()
savemanager:SetIgnoreIndexes({ 'MenuKeybind' })
thememanager:SetFolder('petal_counterblox')
savemanager:SetFolder('petal_counterblox/configs')
savemanager:BuildConfigSection(tabs['ui settings'])
thememanager:ApplyToTab(tabs['ui settings'])
savemanager:LoadAutoloadConfig()
