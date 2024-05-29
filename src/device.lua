-- a LOT better than detecting with userInputService
-- this can detect emulators since the ui appears a lot bigger on there.

local endpoint = "https://httpbin.org/user-agent"
local api = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/src/api.lua", true))()

local http = game:GetService("HttpService")

local req = request or (fluxus and fluxus.request)

local function find()
    local res = req({
        Url = endpoint,
        Method = "GET"
    })

    return res.Body
end

local function parse(res)
    local agent = http:JSONDecode(res)

    if (agent) and (agent["user-agent"]) then
        return agent["user-agent"]
    else
        return "Android"
    end
end

local function platform(agent)
    if (string.find(agent, "Android")) then
        return "Android"
    elseif (string.find(agent, "iOS")) then
        return "iOS"
    elseif (string.find(agent, "Krampus")) then
        return "Windows"
    else
        if (string.find(identifyexecutor(), "Wave")) or (string.find(identifyexecutor(), "Solara")) then
            return "Windows"
        else
            return "Android"
        end
    end
end

local function main()
    local agent = find()

    if (agent) then
        local platform = parse(agent)
    
        if (platform) then
            api.log("Connected with " .. platform)
            return platform
        else
            api.warn("Failed to determine platform from user-agent. Defaulting to Mobile.")
            return "Android"
        end
    else
        api.warn("Failed to fetch user-agent information. Defaulting to Mobile.")
        return "Android"
    end
end

return main()
