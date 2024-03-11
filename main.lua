local succ, err = xpcall(function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/checker.lua", true))()

    print("Loaded, with 0 problems. ⭐")
end, function(err)
    warn("Starry Issued @ " .. err)
end)
