local api = {}

local proj = "💫 Starry"

api.log = function(...)
    print(proj .. " Output: " .. tostring(...))
end

--[[

api.warn = function(...)
    warn(proj .. " Debugger: " .. tostring(...))
end

]]

return api
