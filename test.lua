local HttpService = game:GetService("HttpService")

local WEBHOOK = "https://discord.com/api/webhooks/1461077762130444479/T9wBoye7K5t6Tj-ay4f7j6KN0NAV7CUEHsYf4QbKDG62HZyfnYGyvk-7_oZ6IbFFpxHK"

local logins = {
    {
        user = "test1",
        password = "pass2",
        hwid = ""
    },
    {
        user = "test",
        password = "pass",
        hwid = "balls"
    }
}

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
    local raw = (h["User-Agent"] or "") .. (h["Accept-Language"] or "")

    if syn and syn.crypt and syn.crypt.hash then
        return syn.crypt.hash(raw, "sha256")
    elseif fluxus and fluxus.crypt then
        return fluxus.crypt.sha256(raw)
    elseif krnl and krnl.sha256 then
        return krnl.sha256(raw)
    else
        local hash = 0
        for i = 1, #raw do
            hash = (hash * 31 + raw:byte(i)) % 2^32
        end
        return tostring(hash)
    end
end

local hwid = getHwid()

local found = nil

for _, v in ipairs(logins) do
    if v.user == getgenv().user and v.password == getgenv().password then
        found = v
        break
    end
end

if not found then
    task.wait(math.huge)
end

if found.hwid == "" then
    request({
        Url = WEBHOOK,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({
            content = "new hwid bind\nuser: "..found.user.."\nhwid: "..hwid
        })
    })

    task.wait(math.huge)
end

if found.hwid ~= hwid then
    task.wait(math.huge)
end

local main = game:HttpGet("https://raw.githubusercontent.com/petal-cymk/repotestaaaa/refs/heads/main/something/something/something/something/something/main.lua")
loadstring(main)()
