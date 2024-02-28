local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local queueEnabled = false

local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")
local teleport = game:GetService("TeleportService")

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local presets = {
    ['walkspeed'] = humanoid.WalkSpeed,
}

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
    player = window:AddTab({
        Title = " Player",
        Icon = "baby"
    }),
}

function notify(head, content)
    window:Dialog({
        Title = head,
        Content = content,
        Buttons = {
            {
                Title = "Okay",
                Callback = function()
                    print("Confirmed.")
                end
            }
        }
    })
end

function clip(string)
    local board = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

    if (board) then
        board(string)
    else
        notify("Failed", "Your executor doesn't support clipboarding.")
    end
end

function to(pos)
    local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")

    return rootPart.CFrame == pos
end

local options = flu.Options

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
                queueteleport('return (loadstring(game:HttpGetAsync("https://t.ly/zYuL_"))("Starry Hub"))')
            end

            teleport:Teleport(game.PlaceId, localPlayer)
        end
    })

    local reRun = tabs.intro:AddToggle("Re-run", {
        Title = "Run on Rejoin",
        Description = "Automatically run the script after you've rejoined."
        Default = false
    })

    reRun:OnChanged(function(value)
        queueEnabled = value
    end)
end

-- player mods

do

end

window:SelectTab(1)