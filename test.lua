getgenv().hwidValid = false
getgenv().loginError = nil
local user = getgenv().user
local password = getgenv().password
local HttpService = game:GetService("HttpService")

local WEBHOOK = "https://discord.com/api/webhooks/1461397355738828903/D5SuLOc5GKzEdvU23qn5GM0wilHwxh8i45ngp_BdHzosvFvL5WHDF2xvEcfT659vp5gQ"

local logins = {
    { user = "fusion", password = "admin", hwid = "" },
    { user = "silke",  password = "Imafemboy",  hwid = "" },
}

-- i cant be asked to get a real hwid, so yes, you get easily hookable one, yay
local function getHwid()
    local clientid = "unknown"
    local executor = "unknown"

    if gethwid then
        clientid = tostring(gethwid())
    elseif game.GetService then
        local ok, id = pcall(function()
            return game:GetService("RbxAnalyticsService"):GetClientId()
        end)
        if ok and id then
            clientid = tostring(id)
        end
    end

    if identifyexecutor then
        executor = tostring(identifyexecutor())
    end

    local raw = clientid .. "|" .. executor

    local hash = 0
    for i = 1, #raw do
        hash = (hash * 31 + raw:byte(i)) % 4294967296
    end

    return tostring(hash)
end



task.spawn(function()
    while true do
        task.wait(0.1)
        if getgenv().loginRequested then
            getgenv().loginRequested = false
            user = getgenv().user
            password = getgenv().password
            if not user or not password or user=="" or password=="" then
                getgenv().loginError = "enter username/password"
            else
                local found
                for _,v in ipairs(logins) do
                    if v.user==user and v.password==password then
                        found = v
                        break
                    end
                end
                if not found then
                    getgenv().loginError = "invalid login"
                else
                    local hwid = getHwid()
                    if found.hwid ~= hwid then
                        if found.hwid == "" then
                            request({
                                Url = WEBHOOK,
                                Method = "POST",
                                Headers = {["Content-Type"]="application/json"},
                                Body = HttpService:JSONEncode({
                                    content = "new hwid bind\nuser: "..found.user.."\nhwid: ```"..hwid.."```"
                                })
                            })
                        else
                            getgenv().loginError = "hwid mismatch, open ticket"
                            continue
                        end
                    end
                    getgenv().hwidValid = true
                    getgenv().loginError = nil
                end
            end
        end
    end
end)
