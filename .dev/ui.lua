local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local push = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local players = game.Players

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local presets = {
    ['walkspeed'] = humanoid.WalkSpeed, -- by default, Roblox has this @ 16
    ['jumppower'] = humanoid.JumpPower, -- by default, Roblox has this @ 50
}

local window = flu:CreateWindow({
    Title = "Starry 💫",
    SubTitle = "github.com/hello-n-bye/Starry",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local tabs = {
    intro = window:AddTab({
        Title = " Main",
        Icon = ""
    }),
    general = window:AddTab({
        Title = " Pets",
        Icon = "bone"
    }),
    farming = window:AddTab({
        Title = " Farming",
        Icon = "carrot"
    }),
    trading = window:AddTab({
        Title = " Trading",
        Icon = "paperclip"
    }),
    player = window:AddTab({
        Title = " Player",
        Icon = "baby"
    }),
    minigames = window:AddTab({
        Title = " Minigames",
        Icon = "gamepad"
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

local Options = flu.Options

flu:Notify({
    Title = "Star The Repo ⭐",
    Content = "Like our open-sourced project? Give it a star over on Github.",
    SubContent = "github.com/hello-n-bye/Starry",
    Duration = 5
})

-- main tab

tabs.intro:AddParagraph({
    Title = "Source-code",
    Content = "Find us @ github.com/hello-n-bye/Starry"
})

tabs.intro:AddButton({
    Title = "Join Community",
    Description = "Be apart my community for my main project.",
    Callback = function()
        if (clip) then
            clip("https://discord.gg/dshMH6Edeu")
            notify("Modulus", "Copied invite to your clipboard")
        else
            notify("Modulus", "discord.gg/dshMH6Edeu")
        end
    end
})

tabs.intro:AddButton({
    Title = "Rejoin",
    Description = "Join the server you are in again.",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, localPlayer)
    end
})

-- player mods

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

local resetSpeed = tabs.player:AddButton({
    Title = "Clear Speed",
    Description = "Changes your speed back to normal.",
    Callback = function()
        speed:SetValue(presets.walkspeed)
        humanoid.WalkSpeed = presets.walkspeed

        notify("Walkspeed Changed", "Congrats, you're normal again.")
    end
})

local jumppower = tabs.player:AddSlider("Jumping Power", {
    Title = "Jump-power",
    Description = "Changes how high you can jump.",
    Default = presets.jumppower,
    Min = 1,
    Max = 781.25,
    Rounding = 1,
    Callback = function(value)
        humanoid.JumpPower = value
    end
})

local resetPower = tabs.player:AddButton({
    Title = "Clear Jump-power",
    Description = "Changes your jumping power back to normal.",
    Callback = function()
        jumppower:SetValue(presets.jumppower)
        humanoid.JumpPower = presets.jumppower
        
        notify("Jump-power Changed", "Congrats, you're normal again.")
    end
})

local listed = {}
for _,v in ipairs(players:GetPlayers()) do
    table.insert(listed, v.Name)
end

local gotoPlayer = tabs.player:AddDropdown("Player TP", {
    Title = "Goto Player",
    Values = listed,
    Multi = false,
    Default = "Select One"
})

gotoPlayer:OnChanged(function(player)
    local newChar = players[player].Character or players[player].CharacterAdded:Wait()
    rootPart.CFrame = newChar.HumanoidRootPart.CFrame + Vector3.new(10, 5, 0)
end)

window:SelectTab(1)