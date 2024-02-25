local ids = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/ids.lua"))()

local placeid = game.PlaceId

local options = { dev = true }

if (options.dev) then
    print('loaded dev ui')
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/.dev/ui.lua"))()
else
    if ((placeid) == ids.pSim99) then
        print('loaded pet sim')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/games/pSim99.lua"))()
    end
end