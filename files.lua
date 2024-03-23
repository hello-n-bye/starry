-- just a simplistic file system mechanism

-- i only made this for very little purposes, but if you do end up deleting the folders ->
--      you will be asked to join the discord again!

-- so that's fun.


local cryMyselfToSleep = false

local api = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/api.lua", true))()

local path = "Starry"

if (isfolder(path)) then
    if (cryMyselfToSleep) then
        delfolder(path)

        api.log("Deleted parent folder!")

        local timed = tick()
        makefolder(path)

        api.log("Created new folder in ~" .. string.format("%.2f", tick() - timed) .. " seconds.")
    else
        api.log("Found and saved parent folder.")
    end
else
    local timed = tick()
    makefolder(path)
    api.log("Created parent folder in " .. string.format("%.2f", tick() - timed) .. " seconds.")
end

local iHateLife = path .. "//info.json"

local contents = [[{"askedDiscord": false}]]

if (isfile(iHateLife)) then
    api.log("Found info.cfg file.")
    if (string.find(readfile(iHateLife), '{"askedDiscord": ')) then
        api.log("Contents match -- all clear.")
    else
        delfile(iHateLife)
        api.log("Deleted old configuration.")

        writefile(iHateLife, contents)
        api.log("Created new configuration profile -- all clear.")

        writefile(path .. "//auth.pool", [[{"daily": false}]])
    end
else
    api.log("Configuration not found!")

    writefile(iHateLife, contents)
    writefile(path .. "//auth.pool", [[{"daily": false}]])

    api.log("Created configuration profile -- all clear.")
end
