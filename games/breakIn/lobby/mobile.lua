local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local queueteleport = queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local queueEnabled = false

local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")
local replicatedStorage = game:GetService("ReplicatedStorage")
local teleport = game:GetService("TeleportService")

local localPlayer = players.LocalPlayer

local window = flu:CreateWindow({
    Title = "Starry 💫",
    SubTitle = "github.com/hello-n-bye/Starry",
    TabWidth = 160,
    Size = UDim2.fromOffset(625, 460 / 1.5),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local tabs = {
    intro = window:AddTab({
        Title = " Main",
        Icon = ""
    }),
    game = window:AddTab({
        Title = " Game",
        Icon = "curly-braces"
    }),
    lobby = window:AddTab({
        Title = " Lobby",
        Icon = "egg"
    })
}

local options = flu.Options

flu:Notify({
    Title = "Star The Repo ⭐",
    Content = "Like our open-sourced project? Give it a star over on Github.",
    SubContent = "github.com/hello-n-bye/Starry",
    Duration = 5
})

flu:Notify({
    Title = "Loaded For Lobby 🚀",
    Content = "Exploits for the lobby of Break In. Join a game to get the full experience.",
    Duration = 8
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

    local reRun = tabs.intro:AddToggle("Re-run", {
        Title = "Run on Rejoin",
        Description = "Automatically run the script after you've rejoined.",
        Default = false
    })

    reRun:OnChanged(function(value)
        queueEnabled = value
    end)
end

-- lobby tab

do
    tabs.lobby:AddButton({
        Title = "Hacker",
        Description = "Gives you the Hacker role, when playing.",
        Callback = function()
            replicatedStorage.RemoteEvents:FindFirstChild("OutsideRole"):FireServer("Phone")
        end
    })

    tabs.lobby:AddButton({
        Title = "Nerd",
        Description = "Unlock your inner nerd, and literally be a dork.",
        Callback = function()
            replicatedStorage.RemoteEvents:FindFirstChild("OutsideRole"):FireServer("Book")
        end
    })
end

-- game tab

do
    tabs.game:AddButton({
        Title = "Load in",
        Description = "Get into a bus, then wait to be brought into game.",
        Callback = function()
            local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()

            for i = 1, 5 do
                newChar.HumanoidRootPart.CFrame = CFrame.new(88.375, 3.50000048, 109.249992, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            end

            task.wait(0.1)
            for i = 1, 5 do
                newChar.HumanoidRootPart.CFrame = CFrame.new(88.375, 3.50000048, 148.25, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            end
        end
    })
end

window:SelectTab(1)