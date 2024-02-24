local pet_simulator = {}

local functions = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/modules/miscellaneous.lua", true))()

local replicatedStorage = game:GetService("ReplicatedStorage")

local lib = require(replicatedStorage.Library)
local save = require(lib.Client.Save)

--[[

pet_simulator.mail = function(newUser)
    local modulars = save.Get()

    local miscellaneous = modulars.Inventory.Misc
    local pet = modulars.Inventory.Pet

    for _,v in ipairs(miscellaneous) do
        if (v.id) == "Magic Shard" then
            if (v._am) >= 1 then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({
                    [1] = newUser,
                    [2] = "Magic Shard",
                    [3] = "Misc",
                    [4] = _,
                    [5] = v._am or 1
                }))
            end
        end
    end

    functions.yield(2)

    for _,v in ipairs(miscellaneous) do
        if (v.id) == "Huge Poseidon Corgi" then
            if (v._am) >= 1 then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({
                    [1] = newUser,
                    [2] = "Huge Poseidon Corgi",
                    [3] = "Pet",
                    [4] = _,
                    [5] = v._am or 1
                }))
            end
        end
    end
end

]]

pet_simulator.infiniteSpeed = function(...)
    return (999999999)
end

return pet_simulator