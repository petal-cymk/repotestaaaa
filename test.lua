local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,400,0,120)
frame.Position = UDim2.new(0.5,-200,0.35,0)
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

local function makeButton(pos, text)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.48,-5,0,25)
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
    local t0 = TweenService:Create(btn, info, {BackgroundTransparency = 0.5})
    local t1 = TweenService:Create(btn, info, {BackgroundTransparency = 0.9})
    btn.MouseEnter:Connect(function() t0:Play() end)
    btn.MouseLeave:Connect(function() t1:Play() end)

    return btn
end

local userBox = makeTextbox(UDim2.new(0,5,0,5),"username")
local passBox = makeTextbox(UDim2.new(0.52,0,0,5),"password")
local loginBtn = makeButton(UDim2.new(0,5,0,40),"login")
local pdBtn = makeButton(UDim2.new(0,5,0,70),"project delta")
local cbBtn = makeButton(UDim2.new(0.52,0,0,70),"counterbloxx")
local errLabel = Instance.new("TextLabel", frame)
errLabel.Size = UDim2.new(1,0,0,20)
errLabel.Position = UDim2.new(0,0,0,100)
errLabel.Text = ""
errLabel.TextColor3 = Color3.fromRGB(255,80,80)
errLabel.BackgroundTransparency = 1
errLabel.Font = Enum.Font.Code
errLabel.TextSize = 14
errLabel.ZIndex = 500001

pdBtn.Visible = false
cbBtn.Visible = false

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

-- login button
loginBtn.MouseButton1Click:Connect(function()
    local u = userBox.Text
    local p = passBox.Text
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
        end
        if getgenv().loginError then
            errLabel.Text = getgenv().loginError
        else
            errLabel.Text = ""
        end
    end
end)

pdBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/petal-cymk/repotestaaaa/refs/heads/main/something/something/something/something/something/main.lua"))()
    gui:Destroy()
end)

cbBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/petal-cymk/repotestaaaa/refs/heads/main/something/something/something/something/main.lua"))()
    gui:Destroy()
end)
