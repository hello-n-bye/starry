local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local queueteleport = queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local queueEnabled = false

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")
local lighting = game:GetService("Lighting")
local teleport = game:GetService("TeleportService")

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local events = replicatedStorage:WaitForChild("Events")

local vending = replicatedStorage.Vending

local godded = false
local noslip = false

local backpack = localPlayer.Backpack

if not (lighting:FindFirstChild("STARRY_REMOTE_STORAGE")) then
    local newFolder = Instance.new("Folder", lighting) do
        newFolder.Name = "STARRY_REMOTE_STORAGE"
    end
end

local contain = lighting:FindFirstChild("STARRY_REMOTE_STORAGE")

local function train(method)
    events:WaitForChild("RainbowWhatStat"):FireServer(method)
end

local function heal(player)

end

local function give(item)
    if (item) == "Armor" then
        events:WaitForChild("Vending"):FireServer(3, "Armor2", "Armor", tostring(localPlayer), 1)
    else
        events:WaitForChild("GiveTool"):FireServer(tostring(item:gsub(" ", "")))
    end
end

local function to(pos)
    return rootPart.CFrame == pos
end

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
    world = window:AddTab({
        Title = " World",
        Icon = "globe"
    }),
    player = window:AddTab({
        Title = " Player",
        Icon = "baby"
    }),
    utils = window:AddTab({
        Title = " Utilities",
        Icon = "settings"
    }),
    stats = window:AddTab({
        Title = " Buffs",
        Icon = "shield"
    }),
    anims = window:AddTab({
        Title = " Animations",
        Icon = "cloud-lightning"
    }),
    money = window:AddTab({
        Title = " Money",
        Icon = "wallet"
    }),
    fun = window:AddTab({
        Title = " Fun",
        Icon = "banana"
    }),
}

local function notify(head, content)
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

local options = flu.Options

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

    tabs.intro:AddParagraph({
        Title = "Contributor",
        Content = "Thanks to imanewma__n for 4 features."
    })

    ---

    tabs.intro:AddButton({
        Title = "Suicide",
        Description = "K*ll yourself in-game, prompting the respawn screen.",
        Callback = function()
            local args = {
                [1] = -999,
                [3] = false
            }
            
            events:WaitForChild("Energy"):FireServer(unpack(args))   
        end
    })
    
    tabs.intro:AddButton({
        Title = "Send to Lobby",
        Description = "Literally just go back to the lobby.",
        Callback = function()
            if (queueEnabled) then
                queueteleport('loadstring(game:HttpGetAsync("https://t.ly/zYuL_"))("Starry Hub")')
            end

            teleport:Teleport(13864661000, localPlayer)
        end
    })

    ---

    local reRun = tabs.intro:AddToggle("Re-run", {
        Title = "Run on Teleport",
        Description = "Automatically run the script after you've joined.",
        Default = false
    })

    reRun:OnChanged(function(value)
        queueEnabled = value
    end)
end

-- player tab

do
    tabs.player:AddButton({
        Title = "Heal",
        Description = "Bring yourself back to full health.",
        Callback = function()
            heal(localPlayer.Name)
        end
    })

    ---

    local godmode = tabs.player:AddToggle("Godmode", {
        Title = "Godmode",
        Description = "Scuffed godmode, fixing soon.",
        Default = false
    })

    godmode:OnChanged(function(value)
        godded = value

        while (godded) do
            task.wait()

            heal(localPlayer.Name)
        end
    end)

    ---

    local noslip = tabs.player:AddToggle("No Slip", {
        Title = "No Slip",
        Description = "Make you immune to slipping on ice.",
        Default = false
    })

    noslip:OnChanged(function(value)
        noslip = value

        local remote = replicatedStorage:WaitForChild("Events"):FindFirstChild("IceSlip")

        if (noslip) then
            remote.Parent = contain
        elseif not (remote) and not (noslip) then
            local newRemote = contain:FindFirstChild("IceSlip")

            if (newRemote) then
                newRemote.Parent = replicatedStorage.Events
            end
        end
    end)

    ---

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
end

-- utils

do
    tabs.utils:AddButton({
        Title = "Capture NPCs",
        Description = "Harvest the NPCs and take them back to their prison.",
        Callback = function()
            notify("Fetching NPCs...", "This process takes about 6 seconds.")

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
                    to(CFrame.new(-203.533081, 30.4500484, -790.901428, -0.0148558766, 8.85941187e-09, -0.999889672, 2.65695732e-08, 1, 8.46563175e-09, 0.999889672, -2.64408779e-08, -0.0148558766) + Vector3.new(0, 5, 0))
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
                replicatedStorage:WaitForChild("Events").KeyEvent:FireServer()
            end
            
            uncle()

            task.wait(3)
            doggy()

            task.wait(3); agent()
        end
    })

    ---

    local looool = {}

    for _,v in ipairs(vending.Weapons:GetDescendants()) do
        if (v:IsA("Model")) then
            table.insert(looool, v.Name)
        end
    end

    local weapons = tabs.utils:AddDropdown("Give Weapons", {
        Title = "Give Weapons",
        Values = looool,
        Mutli = false,
        Default = "Select One"
    })

    weapons:OnChanged(function(value)
        local arg = {
            [1] = 3,
            [2] = value,
            [3] = "Weapons",
            [4] = localPlayer.Name,
            [6] = 0
        }

        events:WaitForChild("Vending"):FireServer(unpack(arg))
    end)

    ---

    local items = tabs.utils:AddDropdown("Give Items", {
        Title = "Give Items",
        Values = {"Gold Pizza"},
        Mutli = false,
        Default = "Select One"
    })

    items:OnChanged(function(value)
        give(value)
    end)

    ---

    local foodies = {}
    local beverages = {}

    for _,v in ipairs(vending.Food:GetDescendants()) do
        if (v:IsA("Model")) then
            table.insert(foodies, v.Name)
        end
    end
    
    for _,v in ipairs(vending.Drinks:GetDescendants()) do
        if (v:IsA("Model")) then
            table.insert(beverages, v.Name)
        end
    end

    ---

    local drinks = tabs.utils:AddDropdown("Give Drinks", {
        Title = "Give Drinks",
        Values = beverages,
        Multi = false,
        Default = "Select One"
    })
    
    drinks:OnChanged(function(value)
        events.Vending:FireServer(3, value, "Drinks", localPlayer.Name, 0) -- 0 = Free
    end)
    
    local foods = tabs.utils:AddDropdown("Give Food", {
        Title = "Give Food",
        Values = foodies,
        Multi = false,
        Default = "Select One"
    })
    
    foods:OnChanged(function(value)
        events.Vending:FireServer(3, value, "Food", localPlayer.Name, 0) -- 0 = Free
    end)

    ---

    local armor = tabs.utils:AddButton({
        Title = "Equip Armor",
        Description = "Suit up by equipping some armor.",
        Callback = function()
            events:WaitForChild("Vending"):FireServer(3, "Armor2", "Armor", tostring(localPlayer), 1)
        end
    })

    ---

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

-- stats tab

do
    tabs.stats:AddButton({
        Title = "Max Speed",
        Description = "Gain the maximum amount of speed buffs.",
        Callback = function()
            local i = 0

            while task.wait(1) do
                i = i + 1
        
                if (i) ~= 5 then
                    train("Speed")
                end
            end
        end
    })

    tabs.stats:AddButton({
        Title = "+1 Speed",
        Description = "Gain a new speed buff.",
        Callback = function()
            train("Speed")
        end
    })

    tabs.stats:AddButton({
        Title = "Max Strength",
        Description = "Automatically gain the maximum amount of strength buffs.",
        Callback = function()
            local i = 0

            while task.wait(1) do
                i = i + 1
        
                if (i) ~= 5 then
                    train("Strength")
                end
            end
        end
    })

    tabs.stats:AddButton({
        Title = "+1 Strength",
        Description = "Grant yourself the next tier of strength.",
        Callback = function()
            train("Strength")
        end
    })
end

-- anims tab

do
    local spoofwalk = tabs.anims:AddToggle("Spoof Walking Animation", {
        Title = "Outside Walk Spoof",
        Default = false
    })

    spoofwalk:OnChanged(function(value)
        events.SetWalkAnim:FireServer(value)
    end)

    ---

    --[[

    tabs.anims:AddButton({
        Title = "Skip Cutscene",
        Callback = function()

        end
    })

    ]]
end

-- money tab

do
    --[[

    tabs.money:AddButton({
        Title = "Pickup Floor Money",
        Description = "Grab all of the money left on the ground.",
        Callback = function()

        end
    })

    ]]
end

-- world tab

do
    --[[

    tabs.world:AddButton({
        Title = "Tear Pages",
        Description = "Tear the pages off, leading to instructions of the dog.",
        Callback = function()

        end
    })

    tabs.world:AddButton({
        Title = "Solve Timeline",
        Description = "Automatically complete the timeline in chronological order.",
        Callback = function()

        end
    })

    ]]
end

-- fun tab

do
    tabs.fun:AddButton({
        Title = "Squash",
        Description = "Get squished like a pancake, lose energy.",
        Callback = function()
            events.MakePancake:FireServer()
        end
    })

    tabs.fun:AddButton({
        Title = "Slip on Ice",
        Callback = function()
            if (contain:FindFirstChild("IceSlip")) then
                contain:WaitForChild("IceSlip"):FireServer(Vector3.new(-184.6158447265625, 42.0324821472168, -777.117431640625))
            else
                events:WaitForChild("IceSlip"):FireServer(Vector3.new(-184.6158447265625, 42.0324821472168, -777.117431640625))
            end
        end
    })
end

window:SelectTab(1)

print("Loaded ⭐")