local api = {}

local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local proj = "💫 Starry"

api.log = function(...)
    print(proj .. " Output: " .. tostring(...))
end

api.warn = function(...)
    warn(proj .. " Debugger: " .. tostring(...))
end

api.notify = function(emoji, header, content, time)
    flu:Notify({
        Title = emoji .."  " .. header,
        Content = content,
        Duration = time
    })
end

return api
