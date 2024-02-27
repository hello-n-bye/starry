local ids = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/ids.lua"))()

local placeid = game.PlaceId

if (placeid) == 13864661000 or (placeid) == 13864667823 then
    -- break in 2

    if (placeid) == 13864661000 then
        return (print("💫 Starry: You must be in a game to use the script!"))
    else
        return (loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/games/break-in-2.lua"))())
    end
else
    return (print("💫 Starry: Sorry, we don't support this game."))
end