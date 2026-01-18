local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local exec = "unknown"
pcall(function()
    exec = identifyexecutor()
end)

exec = string.lower(tostring(exec))

if string.find(exec, "xeno") then
    lp:Kick("xeno is unsupported, use solara its FREE check #exe-suport next time")
elseif string.find(exec, "solara") then
    print("nice executor")
elseif string.find(exec, "potassium") then
    print("i love your executor sir potassium is peak")
elseif string.find(exec, "volt") then
    print("your shit boutta exitscam dawg😂😂😂😂😂😂😂😂😂😂😂😂😂😂😂")
elseif string.find(exec, "jjsploit") then
    lp:Kick("nigger jjsploit")
elseif string.find(exec, "velocity") then
    lp:Kick("Server detected exploiting")
end

getgenv().build = getgenv().build or "private user"
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

loadstring(game:HttpGet("https://raw.githubusercontent.com/petal-cymk/repotestaaaa/refs/heads/main/test.lua"))()

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frameHeight = 65
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,400,0,frameHeight)
frame.Position = UDim2.new(0.5,-200,0.5,-frameHeight/2)
frame.BackgroundColor3 = Color3.new(1,1,1)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.ZIndex = 500000
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(110,77,95))
}
grad.Rotation = 90

local function makeTextbox(pos, placeholder)
    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.48,-5,0,25)
    box.Position = pos
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.fromRGB(0,0,0)
    box.BackgroundTransparency = 0.9
    box.Font = Enum.Font.Code
    box.TextSize = 14
    box.ClearTextOnFocus = false
    box.TextStrokeTransparency = 0.7
    box.ZIndex = 5000001

    local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local t0 = TweenService:Create(box, info, {BackgroundTransparency = 0.5})
    local t1 = TweenService:Create(box, info, {BackgroundTransparency = 0.9})
    box.MouseEnter:Connect(function() t0:Play() end)
    box.MouseLeave:Connect(function() t1:Play() end)

    return box
end

local function makeButton(pos, size, text)
    local btn = Instance.new("TextButton", frame)
    btn.Size = size
    btn.Position = pos
    btn.Text = text:lower()
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    btn.BackgroundTransparency = 0.9
    btn.Font = Enum.Font.Code
    btn.TextSize = 14
    btn.Modal = true
    btn.ZIndex = 5000001

    local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local t0 = TweenService:Create(btn, info, {BackgroundTransparency = 0.5, TextTransparency = 0.5})
    local t1 = TweenService:Create(btn, info, {BackgroundTransparency = 0.9, TextTransparency = 0})
    btn.MouseEnter:Connect(function() t0:Play() end)
    btn.MouseLeave:Connect(function() t1:Play() end)

    return btn
end

local userBox = makeTextbox(UDim2.new(0,5,0,5),"username")
local passBox = makeTextbox(UDim2.new(0.52,0,0,5),"password")
local loginBtn = makeButton(UDim2.new(0,5,0,35), UDim2.new(1,-10,0,25),"login")
local pdBtn = makeButton(UDim2.new(0,5,0,35), UDim2.new(0.48,-5,0,25),"project delta")
local cbBtn = makeButton(UDim2.new(0.52,0,0,35), UDim2.new(0.48,-5,0,25),"counterblox")
local errLabel = Instance.new("TextLabel", frame)
errLabel.Size = UDim2.new(1,0,0,20)
errLabel.Position = UDim2.new(0,0,0,65)
errLabel.Text = ""
errLabel.TextColor3 = Color3.fromRGB(255,80,80)
errLabel.BackgroundTransparency = 1
errLabel.Font = Enum.Font.Code
errLabel.TextSize = 14
errLabel.ZIndex = 500001

pdBtn.Visible = false
cbBtn.Visible = false

local function updateFrameHeight()
    local targetHeight = 65
    if getgenv().loginError and getgenv().loginError ~= "" then
        targetHeight = targetHeight + 20
    end
    if getgenv().hwidValid then
        targetHeight = targetHeight + 35
    end
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0,400,0,targetHeight), Position = UDim2.new(0.5,-200,0.5,-targetHeight/2)}):Play()
end

local cachePath = "petal/assets/cache/login"
if not isfolder("petal/assets/cache") then
    makefolder("petal/assets/cache")
end

if isfile(cachePath) then
    local data = readfile(cachePath)
    if data and data ~= "username password" then
        local u,p = data:match("^(%S+)%s+(%S+)$")
        if u and p then
            userBox.Text = u
            passBox.Text = p
            getgenv().user = u
            getgenv().password = p
            getgenv().loginRequested = true
        end
    end
end

loginBtn.MouseButton1Click:Connect(function()
    if getgenv().buttonPressed then return end
    local u,p = userBox.Text, passBox.Text
    getgenv().user = u
    getgenv().password = p
    getgenv().loginRequested = true
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if getgenv().hwidValid then
            pdBtn.Visible = true
            cbBtn.Visible = true
            loginBtn.Visible = false
            userBox.Visible = false
            passBox.Visible = false
            if userBox.Text ~= "" and passBox.Text ~= "" then
                writefile(cachePath, userBox.Text.." "..passBox.Text)
            end
        end
        if getgenv().loginError then
            errLabel.Text = getgenv().loginError
        else
            errLabel.Text = ""
        end
        updateFrameHeight()
    end
end)

local function fadeOutAndLoad(url)
    if getgenv().buttonPressed then return end
    getgenv().buttonPressed = true

    local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    for _,v in pairs({errLabel,userBox,passBox,loginBtn,pdBtn,cbBtn}) do
        if v:IsA("TextLabel") or v:IsA("TextBox") or v:IsA("TextButton") then
            TweenService:Create(v, info, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        end
    end
    TweenService:Create(frame, info, {BackgroundTransparency = 1}):Play()

    task.delay(0.5, function()
        gui:Destroy()
        loadstring(game:HttpGet(url))()
    end)
end

pdBtn.MouseButton1Click:Connect(function()
    fadeOutAndLoad("https://raw.githubusercontent.com/petal-cymk/repotestaaaa/refs/heads/main/something/something/something/something/something/main.lua")
end)
cbBtn.MouseButton1Click:Connect(function()
    fadeOutAndLoad("https://raw.githubusercontent.com/petal-cymk/repotestaaaa/refs/heads/main/something/something/something/something/main.lua")
end)
