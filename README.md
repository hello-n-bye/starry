# Official Release 🐋
```lua
local branch, owner = "main", "hello-n-bye"

local function load(url: string)
  if (type(url)) ~= "string" then
    return warn("Url must be a string to load it.")
  else
    xpcall(function()
      loadstring(game:HttpGet(url))()
    end, function(error_code)
      return warn(("Error: %s on line %s"):format(error_code, debug.traceback()))
    end)
  end
end

load(("https://raw.githubusercontent.com/%s/starry/%s/main.lua"):format(owner, branch))
```

## Supported Games
* Break In 2 ─ **160+ Server Sided features.**

## Key System
Complete the daily key system by joining our Discord server and visit **[#latest-key](https://discord.com/channels/1217389490663063583/1220620564163461171)**.
> Join our latest Discord server by clicking **[here](https://discord.gg/Y6VqydUECF)**
<br><br>![image](https://github.com/hello-n-bye/starry/assets/159689944/d4d5c7b4-27f2-4818-87f7-a89996acefed)

## Developers 🛠️
* Suno ─ Scripter & UI designer
