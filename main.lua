local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

flu:Notify({
    Title = "📢  Please Wait.",
    Content = "Starry is currently launching, give us a second to authenticate you.",
    Duration = 5
})

local succ, err = xpcall(function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/src/checker.lua", true))()

    print("💫 Starry Output: Loaded with 0 issues.")
end, function(err)
    if (string.find(err, "404")) or (string.find(err, "attempt to call a nil value")) then
        if (string.find(identifyexecutor(), "incognito")) then -- Hoping this will solve our problems..?
            task.wait(1) do
                loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/main/src/checker.lua", true))()
            end
        else
            flu:Notify({
                Title = "💫  Starry Can't Start.",
                Content = "The script is currently down, please try again later.",
                Duration = 5
            })
        end
    end
end)
