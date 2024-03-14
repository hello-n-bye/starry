-- attempt to join my discord server

-- i was* going to do a key system, but people would probably hate me ...
-- if i decided to make another really op script.. then i'll probably add one, for now no.

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/files.lua", true))()

local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local api = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/api.lua", true))()

local http = game:GetService("HttpService")

local req = request or (fluxus and fluxus.request)
local function copy(string)
    local board = setclipboard or toclipboard

    if (board) then
        board(tostring(string))

        api.notify("🎉", "Discord Link Copied.", "Feel free to join our small community!", 5)
    else
        api.notify("❌", "Discord Link Uncopyable.", "Your executor doesn't support clipboard copying.", 5)
    end
end

copy("https://discord.gg/8wz7SDtRUj")

if (req) then
    if (isfolder("Starry")) then
        if (isfile("Starry//info.json")) then
            local res = readfile("Starry//info.json")

            if (res) == [[{"askedDiscord": false}]] then
                delfile("Starry//info.json")
                writefile("Starry//info.json", [[{"askedDiscord": true}]])
                
                api.log("Configuration profile changed to true -- all clear.")

                req({
                    Url = "http://127.0.0.1:6463/rpc?v=1",
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json", Origin = "https://discord.com"},
                    Body = http:JSONEncode({
                        cmd = "INVITE_BROWSER",
                        nonce = http:GenerateGUID(false),
                        args = {
                            code = "8wz7SDtRUj"
                        }
                    })
                })

                api.log("Prompted user-Discord join.")
            elseif (res) == [[{"askedDiscord": true}]] then
                api.log("User has already been asked to join, skipping past invitation -- all clear.")
            end
        else
            writefile("Starry//info.json", [[{"askedDiscord": true}]])
            api.log("Created new configuration profile -- all clear.")
        end
    else
        makefolder("Starry")
        api.log("Created new parent folder.")

        writefile("Starry//info.json", [[{"askedDiscord": true}]])
        api.log("Created new configuration profile -- all clear.")
    end
end
