local HttpService = game:GetService("HttpService")

local WEBHOOK = "https://discord.com/api/webhooks/1461077762130444479/T9wBoye7K5t6Tj-ay4f7j6KN0NAV7CUEHsYf4QbKDG62HZyfnYGyvk-7_oZ6IbFFpxHK"

local printstatus = 0
local function printstate()
    print(printstatus)
    printstatus = printstatus + 1
end
-- ab
printstate()
local logins = {
    { user = "fusion", password = "admin", hwid = "907414536" },
    { user = "USER_REPLACE_THIS_SILKE",  password = "PASSWORD_KEEP_IT_RANDOM",  hwid = "" } -- REPLACE THE HWID WITH ANYTHING
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
        print("hwid fail")
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
    print("login auth error")
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
