local ids = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/hello-n-bye/starry/master/ids.lua'))()

local placeid = game.PlaceId

if ((placeid) == ids.pSim99) then

else
    -- universal

    loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/hello-n-bye/starry/master/games/universal.lua'))()
end