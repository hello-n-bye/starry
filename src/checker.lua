local devices = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/device.lua", true))()

local placeid = game.PlaceId

local function isMobile()
    if (devices) == "PC" then
        return "pc"
    else
        return "mobile"
    end
end

if (placeid) == 13864661000 or (placeid) == 13864667823 then
    if (placeid) == 13864661000 then
        return (print("💫 Starry: You must be in a game to use the script!"))
    else
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/games/breakIn/" .. isMobile() ..".lua", true))()
    end
else
    print("💫 Starry: Game not found, loaded universal.")

    return loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/games/uni/" .. isMobile() ..".lua", true))()
end
