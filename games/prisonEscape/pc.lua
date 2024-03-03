local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local BETA = true

if not (BETA) then
    if (getgenv().starry) then
        flu:Notify({
            Title = "💫  Starry Can't Start.",
            Content = "You can't run Starry more than once.",
            Duration = 5
        })
    
        return false, "Couldn't start. Please make sure another Starry instance isn't already running!"
    else
        getgenv().starry = true
    end
else
    flu:Notify({
        Title = "💫  Starry Launched as BETA.",
        Content = "Expect bugs, glitches or problems when having the ability to run more than one instance at a time.",
        Duration = 5
    })
end

local queueteleport = queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local queueEnabled = false

local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")
local teleport = game:GetService("TeleportService")

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local function changeTeam(new)
    local args = {
        [1] = tostring(new)
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("NewTeamerC"):FireServer(unpack(args))    
end

local presets = {
    ['walkspeed'] = 16,
    ['jumppower'] = 50,
}
w
local window = flu:CreateWindow({
    Title = "Starry 💫",
    SubTitle = "github.com/hello-n-bye/Starry",
    TabWidth = 160,
    Size = UDim2.fromOffset(625, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local tabs = {
    intro = window:AddTab({
        Title = " Main",
        Icon = ""
    }),
    teams = window:AddTab({
        Title = " Teams",
        Icon = "shield"
    })
}

flu:Notify({
    Title = "Star The Repo ⭐",
    Content = "Like our open-sourced project? Give it a star over on Github.",
    SubContent = "github.com/hello-n-bye/Starry",
    Duration = 5
})

-- intro tab

do
    tabs.intro:AddParagraph({
        Title = "Source-code",
        Content = "Find us @ github.com/hello-n-bye/Starry"
    })

    tabs.intro:AddButton({
        Title = "Rejoin",
        Description = "Join the server again.",
        Callback = function()
            if (queueEnabled) then
                queueteleport('loadstring(game:HttpGetAsync("https://t.ly/zYuL_"))("Starry Hub")')
            end

            teleport:Teleport(game.PlaceId, localPlayer)
        end
    })

    ---

    local reRun = tabs.intro:AddToggle("Re-run", {
        Title = "Run on Rejoin",
        Description = "Automatically run the script after you've rejoined.",
        Default = false
    })

    reRun:OnChanged(function(value)
        queueEnabled = value
    end)
end

-- team tab

do
    local swap = tabs.teams:AddDropdown("Join Team", {
        Title = "Join Team",
        Values = {"Neutral", "Cop", "Prisoner", "Criminal"}
        Multi = false,
    })

    swap:OnChanged(function(value)
        if (value) == "Neutral" then
            changeTeam("picking")
        elseif (value) == "Guard" then
            changeTeam("guard")
        elseif (value) == "Prisoner" then
            changeTeam("prisoner")
        elseif (value) == "Criminal" then
            changeTeam(value)
        end
    end)
end

window:SelectTab(1)