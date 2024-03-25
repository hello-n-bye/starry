local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

flu:Notify({
    Title = "📢  Please Wait.",
    Content = "Starry is currently launching, give us a second to authenticate you.",
    Duration = 5
})

local succ, err = xpcall(function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/checker.lua", true))()

    print("💫 Starry Output: Loaded with 0 issues.")
end, function(err)
    if (string.find(err, "404")) or (string.find(err, "attempt to call a nil value")) then
        flu:Notify({
            Title = "💫  Starry Can't Start.",
            Content = "Please look inside your console. Use /console, or press F9 to view it.",
            Duration = 5
        })

        if (setclipboard) then
            setclipboard("https://github.com/hello-n-bye/starry")
        end
        
        warn([[
        
        
    | Hmm.. Something went wrong.

      ___                         ___           ___           ___                 
     /\__\                       /\  \         /\  \         /\  \                
    /:/ _/_         ___         /::\  \       /::\  \       /::\  \         ___   
   /:/ /\  \       /\__\       /:/\:\  \     /:/\:\__\     /:/\:\__\       /|  |  
  /:/ /::\  \     /:/  /      /:/ /::\  \   /:/ /:/  /    /:/ /:/  /      |:|  |  
 /:/_/:/\:\__\   /:/__/      /:/_/:/\:\__\ /:/_/:/__/___ /:/_/:/__/___    |:|  |  
 \:\/:/ /:/  /  /::\  \      \:\/:/  \/__/ \:\/:::::/  / \:\/:::::/  /  __|:|__|  
  \::/ /:/  /  /:/\:\  \      \::/__/       \::/~~/~~~~   \::/~~/~~~~  /::::\  \  
   \/_/:/  /   \/__\:\  \      \:\  \        \:\~~\        \:\~~\      ~~~~\:\  \ 
     /:/  /         \:\__\      \:\__\        \:\__\        \:\__\          \:\__\
     \/__/           \/__/       \/__/         \/__/         \/__/           \/__/


    | Starry 💫 is currently down for maintenance.
    | Check our official GitHub repository for updates, or join our server!
    
    | github.com/hello-n-bye/starry
    | discord.gg/bMmZHj2KVp
    
    | P.S. our GitHub repository has been copied to your clipboard.
            ]])
    else
        warn("💫 Starry Debugger: " .. err)
    end
end)
