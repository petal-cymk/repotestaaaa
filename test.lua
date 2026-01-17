getgenv().hwidValid = false
getgenv().loginError = nil
local user = getgenv().user
local password = getgenv().password
local HttpService = game:GetService("HttpService")

local WEBHOOK = "https://discord.com/api/webhooks/1461397355738828903/D5SuLOc5GKzEdvU23qn5GM0wilHwxh8i45ngp_BdHzosvFvL5WHDF2xvEcfT659vp5gQ"

local logins = {
    { user = "fusion", password = "admin", hwid = "907414537" },
    { user = "silke",  password = "Imafemboy",  hwid = "3164645513" },
}

local function getHwid()
    local res = request({ Url = "https://httpbin.org/headers", Method = "GET" })
    if not res or not res.Body then return "hwid_fail" end
    local data = HttpService:JSONDecode(res.Body)
    local h = data.headers or {}
    local raw = (h["User-Agent"] or "") .. (h["Accept-Language"] or "") .. (h["Accept-Encoding"] or "")
    if syn and syn.crypt and syn.crypt.hash then
        return syn.crypt.hash(raw,"sha256")
    else
        local hash = 0
        for i=1,#raw do hash = (hash*31 + raw:byte(i))%4294967296 end
        return tostring(hash)
    end
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
