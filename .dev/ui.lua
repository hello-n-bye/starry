local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local functions = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/modules/miscellaneous.lua", true))()

local queue = (fluxus and fluxus.queueteleport) or queue_on_teleport
local queueEnabled = true

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local events = replicatedStorage:WaitForChild("events")

local vending = replicatedStorage.Vending

local function role(tag)
    if replicatedStorage:FindFirstChild("RemoteEvents"):FindFirstChild("OutsideRole") ~= nil  then
        local event = replicatedStorage:FindFirstChild("RemoteEvents"):FindFirstChild("OutsideRole")

        event:FireServer(tostring(tag))
    end
end

local function train(method)
    events:WaitForChild("RainbowWhatStat"):FireServer(method)
end

local function give(item)
    if (item) == "Armor" then
        events:WaitForChild("Vending"):FireServer(3, "Armor2", "Armor", tostring(localPlayer), 1)
    else
        events:WaitForChild("GiveTool"):FireServer(tostring(item:gsub(" ", "")))
    end
end

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
    utils = window:AddTab({
        Title = " Utilities",
        Icon = "settings",
    }),
    stats = window:AddTab({
        Title = " Buffs",
        Icon = ""
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
    return rootPart.CFrame = pos
end

local Options = flu.Options

flu:Notify({
    Title = "Star The Repo ⭐",
    Content = "Like our open-sourced project? Give it a star over on Github.",
    SubContent = "github.com/hello-n-bye/Starry",
    Duration = 5
})

-- main tab

do
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
            if (queueEnabled) then
                queue('loadstring(game:HttpGet("https://raw.githubusercontent.com/hello-n-bye/starry/master/main.lua"))()')
            end
    
            game:GetService("TeleportService"):Teleport(game.PlaceId, localPlayer)
        end
    })
    
    local launch = tabs.intro:AddToggle("Auto Launch", {
        Title = "Launch on Rejoin",
        Default = true
    })
    
    launch:OnChanged(function(value)
        queueEnabled = value
    end)
end

-- player mods

do
    local custom = tabs.player:AddInput("Custom Role", {
        Title = "Custom Role",
        Default = "",
        Placeholder = "Starry 💫",
        Numeric = false,
        Finished = true,
        Callback = function(value)
            role(value)
        end
    })

    local idle = tabs.player:AddToggle("Anti AFK", {
        Title = "Anti-Idle",
        Default = true
    })

    idle:OnChanged(function(value)
        if (value) then
            localPlayer.Idled:connect(function()
                virtualUser:CaptureController()
                virtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)

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
end

-- utils

do
    local npcs = tabs.utils:AddButton("Capture NPCs", {
        Title = "Capture NPCs",
        Description = "Grab every NPC and claim them as yours.",
        Callback = function()
            local function doggy()
                for _,v in pairs(localPlayer.PlayerGui.Assets.Note.Note.Note:GetChildren()) do
                    if (v.Name:match("Circle")) and (v.Visible == true) then

                        give(tostring(v.Name:gsub("Circle", "")))

                        task.wait(0.1)
                        localPlayer.Backpack:WaitForChild(tostring(v.Name:gsub("Circle", ""))).Parent = character

                        to(CFrame.new(-257.56839, 29.4499969, -910.452637, -0.238445505, 7.71292363e-09, 0.971155882, 1.2913591e-10, 1, -7.91029819e-09, -0.971155882, -1.76076387e-09, -0.238445505))
                        task.wait(0.5)

                        events:WaitForChild("CatFed"):FireServer(tostring(v.Name:gsub("Circle", "")))
                    end
                end

                task.wait(2)

                for _ = 1, 3 do
                    TeleportTo(CFrame.new(-203.533081, 30.4500484, -790.901428, -0.0148558766, 8.85941187e-09, -0.999889672, 2.65695732e-08, 1, 8.46563175e-09, 0.999889672, -2.64408779e-08, -0.0148558766) + Vector3.new(0, 5, 0))
                    task.wait(.1)
                end
            end
    
            local function agent()
                give("Louise")

                task.wait(.1)
                localPlayer.Backpack:WaitForChild("Louise").Parent = character

                events:WaitForChild("LouiseGive"):FireServer(2)
            end	
    
            local function uncle()
                give("Key")

                task.wait(.1)
                localPlayer.Backpack:WaitForChild("Key").Parent = character

                wait(.5)
                events.KeyEvent:FireServer()
            end
            
            uncle()

            task.wait(3)
            doggy()

            task.wait(3); agent()
        end
    })

    local tools = tabs.utils:AddDropdown("Give Tools", {
        Title = "Give Tools",
        Values = {},
        Multi = false,
        Default = "Select One"
    })

    for _,v in ipairs(vending.Weapons:GetDescendants()) do
        if (v.ClassName == "Model") then
            table.insert(v.Name, tools.Values)
        end
    end

    tools:OnChanged(function(value)
		local args = {
            [1] = 3,
            [2] = value,
            [3] = "Weapons",
            [4] = localPlayer.Name,
            [6] = 0
        }

        events:WaitForChild("Vending"):FireServer(unpack(args))
    end)

    local items = tabs.utils:AddDropdown("Give Items", {
        Title = "Give Items",
        Values = {"Gold Pizza"},
        Mutli = false,
        Default = "Select One"
    })

    items:OnChanged(function(value)
        give(value)
    end)

    local armor = tabs.utils:AddButton("Give Armor", {
        Title = "Equip Armor",
        Description = "Suit up by equipping some armor.",
        Callback = function()
            events:WaitForChild("Vending"):FireServer(3, "Armor2", "Armor", tostring(localPlayer), 1)
        end
    })

    local pizzas = tabs.utils:AddToggle("Infinite Golden Pizza", {
        Title = "Infinite Golden Pizza",
        Default = false
    })

    pizzas:OnChanged(function()
        while (pizzas.Value) do
            task.wait()

            give("Gold Pizza")
        end
    end)
end


window:SelectTab(1)