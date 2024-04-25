local devices = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/device.lua", true))()

-- Change this data if you're using a fork.
local githubData = {
    ["branch"] = "master",
    ["owner"] = "hello-n-bye"
}

local placeid = game.PlaceId

local function isMobile()
    if (devices) == "Windows" or (string.find(devices, "Krampus")) then
        return "pc"
    else
        return "mobile"
    end
end

if (placeid) == 13864661000 or (placeid) == 13864667823 then
    if (placeid) == 13864661000 then
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/" .. githubData.owner .. "/starry/" .. githubData.branch .. "/games/breakIn/lobby/" .. isMobile() ..".lua", true))()
    else
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/" .. githubData.owner .. "/starry/" .. githubData.branch .. "/games/breakIn/" .. isMobile() ..".lua", true))()
    end
elseif (placeid) == 738339342 then
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/" .. githubData.owner .. "/starry/" .. githubData.branch .. "/games/floodEscape" .. isMobile() .. ".lua", true))()
end
