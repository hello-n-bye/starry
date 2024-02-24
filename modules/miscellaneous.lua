local misc = {}

misc.yield = function(seconds --[[, ms]])
    --if not (ms) and (ms) == nil then ms = 0 end

    task.wait(seconds)
end

print('loaded misc modules')

return misc