local succ, err = pcall(function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/checker.lua", true))()

    print('loaded ' .. getgenv().version)
end)

if (err) then
    print('problem occured when loading .. is genv.version missing?')
end