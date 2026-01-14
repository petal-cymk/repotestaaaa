local HttpService = game:GetService("HttpService")

local WEBHOOK = "YOUR_DISCORD_WEBHOOK_URL"

local logins = {
    {
        user = "test1",
        password = "pass2",
        hwid = ""
    },
    {
        user = "test",
        password = "pass",
        hwid = "deadbeef"
    }
}

local function getHwid()
    local res = http_request({
        Url = "https://httpbin.org/headers",
        Method = "GET"
    })

    local data = HttpService:JSONDecode(res.Body)
    local h = data.headers
    local raw = (h["User-Agent"] or "") .. (h["Accept-Language"] or "")
    return syn.crypt.hash(raw, "sha256")
end

local hwid = getHwid()

local found

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
    http_request({
        Url = "https://discord.com/api/webhooks/1461077762130444479/T9wBoye7K5t6Tj-ay4f7j6KN0NAV7CUEHsYf4QbKDG62HZyfnYGyvk-7_oZ6IbFFpxHK",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
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
