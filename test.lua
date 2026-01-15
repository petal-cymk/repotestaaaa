local HttpService = game:GetService("HttpService")

local WEBHOOK = "https://discord.com/api/webhooks/1461397355738828903/D5SuLOc5GKzEdvU23qn5GM0wilHwxh8i45ngp_BdHzosvFvL5WHDF2xvEcfT659vp5gQ"

local printstatus = 0
local function printstate()
    print(printstatus)
    printstatus = printstatus + 1
end
-- a
printstate()
local logins = {
    { user = "fusion", password = "admin", hwid = "" },
    { user = "silke",  password = "Imafemboy",  hwid = "" },
}

local function hardStop()
    while true do task.wait(1) end
end

local function getHwid()
    local res = request({
        Url = "https://httpbin.org/headers",
        Method = "GET"
    })

    if not res or not res.Body then
        return "hwid_fail"
    end

    local data = HttpService:JSONDecode(res.Body)
    local h = data.headers or {}

    local raw =
        (h["User-Agent"] or "") ..
        (h["Accept-Language"] or "") ..
        (h["Accept-Encoding"] or "")

    if syn and syn.crypt and syn.crypt.hash then
        return syn.crypt.hash(raw, "sha256")
    else
        local hash = 0
        for i = 1, #raw do
            hash = (hash * 31 + raw:byte(i)) % 4294967296
        end
        return tostring(hash)
    end
end
printstate()
local user = getgenv().user
local password = getgenv().password

if not user or not password then
    hardStop()
end
printstate()
local hwid = getHwid()
local found
printstate()
for _, v in ipairs(logins) do
    if v.user == user and v.password == password then
        found = v
        break
    end
end

if not found then
    hardStop()
end
printstate()
found.hwid = found.hwid or ""
printstate()
if found.hwid == "" then
    task.spawn(function()
        request({
            Url = WEBHOOK,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({
                content =
                    "new hwid bind\n" ..
                    "user: " .. found.user .. "\n" ..
                    "hwid: ```" .. hwid .. "```" 
            })
        })
    end)

elseif found.hwid ~= hwid then
    print("hwid invalid, open a ticket")
    hardStop()
end
printstate()
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/petal-cymk/repotestaaaa/refs/heads/main/something/something/something/something/something/main.lua"
))()
