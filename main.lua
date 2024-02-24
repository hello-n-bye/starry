local succ, err = xpcall(function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/checker.lua", true))()

    print('loaded ' .. getgenv().script)
end, function()
    warn('there is an error when loading')
end)