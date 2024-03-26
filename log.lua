-- log the person's username and send it over to my webhook
-- for obvious reasons, the webhook is hidden!

-- for safety, and privacy reasons, you're free to look through and analyze my logging code

local logger = {}

local req = (fluxus and fluxus.request) or request

local players = game:GetService("Players")
local http = game:GetService("HttpService")

local localPlayer = players.LocalPlayer

local metadata = {
    ["username"] = localPlayer.Name,
    ["colors"] = {
        ["white"] = 0xFFFFF,
        ["green"] = 0x00FF00,
        ["blue"] = 0x1555E3,
        ["indigo"] = 0x2E2B5F,
        ["orange"] = 0xFF7F00,
        ["red"] = 0xFF0000
    }
}

local function randomize()
    local colors = metadata.colors
    local names = {}

    for name,_ in pairs(colors) do
        table.insert(names, name)
    end

    local random = names[math.random(1, #names)]
    return colors[random]
end

logger.post = function(url)
    xpcall(function()
        req({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = http:JSONEncode({
                head = "Starry Logger 🐋",
                content = "# Thank You!",
                embeds = {
                    {
                        author = {
                            name = "Get Starry for Yourself",
                            icon_url = "https://cdn.discordapp.com/attachments/1185420252633378937/1222057030295224343/8R81USk.png?ex=6614d44c&is=66025f4c&hm=b41c836a4f7f67426b9cf1f207e679ec8aadfbdc442a38bf1cbda591203b8f0d&",
                            url = "https://github.com/hello-n-bye/starry?tab=readme-ov-file#official-release-"
                        },
                        title = "Message Received ‎ 📢",
                        description = "Thank you, **" .. metadata.username .."** for using Starry!",
                        color = randomize(),
                        footer = {
                            text = "Made with 💖 by Suno"
                        }
                    }
                }
            })
        })
    end, function(err)
        warn("💫 Starry Debugger: " .. err)
    end)
end

return logger
