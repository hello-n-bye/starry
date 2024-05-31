local devices = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/src/device.lua", true))()
local flu = loadstring(game:HttpGetAsync("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local placeid = game.PlaceId

local function isMobile()
    if (devices) == "Windows" or (string.find(devices, "Krampus")) then
        return "pc"
    else
        if (string.find(identifyexecutor(), "Solara")) or (string.find(identifyexecutor(), "Wave")) or (string.find(identifyexecutor(), "incognito")) then
            return "pc"
        else
            return "mobile"
        end
    end
end

local function removeLoadingInterface()
    if game.CoreGui:FindFirstChild("Starry Loading") then
        game.CoreGui["Starry Loading"]:Destroy()
    else
        return
    end

    print("💫 Starry Output: Destroyed loading interface.")
end

if (placeid) == 13864661000 or (placeid) == 13864667823 then
    if (placeid) == 13864661000 then
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/games/breakIn/lobby/" .. isMobile() ..".lua", true))()
        removeLoadingInterface()
    else
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/games/breakIn/" .. isMobile() ..".lua", true))()
        removeLoadingInterface()
    end
elseif (placeid) == 3582763398 or (placeid) == 1962086868 then
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/games/ToH/" .. isMobile() ..".lua", true))()
    removeLoadingInterface()
else
    flu:Notify({
        Title = "❌  Join a Supported Game.",
        Content = "Please join either Break In 2 or Tower of Hell.",
        Duration = 5
    })
end
