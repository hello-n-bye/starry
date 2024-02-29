local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local queueteleport = queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local queueEnabled = false

local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")
local teleport = game:GetService("TeleportService")

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local currentCamera = workspace.CurrentCamera

local presets = {
    ['walkspeed'] = humanoid.WalkSpeed,
    ['jumppower'] = humanoid.JumpPower,
}

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
    player = window:AddTab({
        Title = " Player",
        Icon = "baby"
    }),
    combat = window:AddTab({
        Title = " Combat",
        Icon = "swords"
    })
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

    rootPart.CFrame = pos
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

-- player mods

do
    local users = {}

    for _,v in ipairs(players:GetPlayers()) do
        table.insert(users, v.Name)
    end

    ---

    players.PlayerAdded:Connect(function(player)
        if (player) ~= localPlayer.Name then
            table.insert(users, player.Name)
        end
    end)

    players.PlayerRemoving:Connect(function(player)
        for i,v in ipairs(users) do
            if (v) == player.Name then
                table.remove(users, i)
                break
            end
        end
    end)

    ---

    local goto = tabs.player:AddDropdown("Goto Player", {
        Title = "Goto Player",
        Values = users,
        Multi = false,
        Default = "Select One"
    })

    goto:OnChanged(function(value)
        if (value) ~= "Select One" then
            local newRoot = workspace[value].HumanoidRootPart
            
            to(newRoot.CFrame)
        end
    end)

    ---

    local spectate = tabs.player:AddDropdown("Watch Player", {
        Title = "Watch Player",
        Values = users,
        Multi = false,
        Default = "Select One"
    })

    spectate:OnChanged(function(value)
        if (value) ~= "Select One" then
            currentCamera.CameraSubject = workspace[value]
        end
    end)

    tabs.player:AddButton({
        Title = "Unwatch",
        Description = "Stop spectating, and lock your camera back on you.",
        Callback = function()
            local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()

            currentCamera.CameraSubject = newChar
        end
    })

    ---

    local speed = tabs.player:AddSlider("Walking Speed", {
        Title = "Walkspeed",
        Description = "Changes how fast you walk.",
        Default = presets.walkspeed,
        Min = 1,
        Max = 250,
        Rounding = 1,
        Callback = function(value)
            humanoid.WalkSpeed = value
        end
    })
    
    tabs.player:AddButton({
        Title = "Clear Speed",
        Description = "Changes your speed back to normal.",
        Callback = function()
            speed:SetValue(presets.walkspeed)
            humanoid.WalkSpeed = presets.walkspeed
    
            notify("Walkspeed Changed", "Congrats, you're normal again.")
        end
    })

    ---

    tabs.player:AddButton({
        Title = "Void Client Kicks",
        Description = "Make it so client-sided anti-cheats can't kick you.",
        Callback = function()
            OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
                if (string.lower(getnamecallmethod())) == "kick" then
                    return nil
                end

                return OldNamecall(...)
            end))
        end
    })
end

window:SelectTab(1)