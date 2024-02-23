local ids = loadstring(game:HttpGetAsync('https://github.com/hello-n-bye/starry/ids.lua'))()

local placeid = game.PlaceId

if (placeid == ids.pSim99) then

else
    -- universal

    loadstring(game:HttpGetAsync('https://github.com/hello-n-bye/starry/blob/master/games/universal.lua'))()
end