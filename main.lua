local succ, err = xpcall(function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/checker.lua", true))()

    print('loaded fully')
end, function(code)
    warn('code execution failure: ' .. code)
end)