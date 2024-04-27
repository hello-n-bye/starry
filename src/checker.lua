local devices = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/src/device.lua", true))()

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
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/games/breakIn/lobby/" .. isMobile() ..".lua", true))()
    else
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/games/breakIn/" .. isMobile() ..".lua", true))()
    end
end
