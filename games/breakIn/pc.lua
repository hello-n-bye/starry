local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local queueteleport = queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local queueEnabled = false

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")
local lighting = game:GetService("Lighting")
local teleport = game:GetService("TeleportService")
local tweenService = game:GetService("TweenService")

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local events = replicatedStorage:WaitForChild("Events")

local combatZone = game:GetService("Workspace"):FindFirstChild("EvilArea"):FindFirstChild("Rug"):FindFirstChild("PartTex")

local vending = replicatedStorage.Vending

local godded = false
local noslip = false
local farmer = false

local badGuys = workspace:FindFirstChild("BadGuys")
local oldPos_Farming = nil

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
    rootPart.CFrame = pos
end

local function tween(pos)
    tweenService:Create(rootPart, TweenInfo.new(
        0.5,
        Enum.EasingStyle.Sine
    ), {
        CFrame = pos
    }):Play()
end

local function get()
    local character = workspace[localPlayer.Name]
    local backpack = localPlayer.Backpack

    local lollipop = (backpack:FindFirstChild("Lollipop")) or (character:FindFirstChild("Lollipop"))
    local drink = (backpack:FindFirstChild("Bottle")) or (character:FindFirstChild("Bottle"))

    local bat = (backpack:FindFirstChild("Bat")) or (character:FindFirstChild("Bat"))
    local medkit = (backpack:FindFirstChild("MedKit")) or (character:FindFirstChild("MedKit"))

    local phone = (backpack:FindFirstChild("Phone")) or (character:FindFirstChild("Phone"))
    local book = (backpack:FindFirstChild("Book")) or (character:FindFirstChild("Book"))

    if (lollipop) then
        return "The Hyper"
    elseif (drink) then
        return "The Sporty"
    elseif (bat) then
        return "The Protector"
    elseif (medkit) then
        return "The Medic"
    elseif (phone) then
        return "The Hacker"
    elseif (book) then
        return "The Nerd"
    end
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
    combat = window:AddTab({
        Title = " Combat",
        Icon = "sword"
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
        Content = "Thanks to imanewma__n for some features."
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
    --[[

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

    ]]

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

-- combat

do
    local autofarm = tabs.combat:AddToggle("Auto farm", {
        Title = "Auto Farm",
        Description = "Automatically kill bad guys!",
        Default = false
    })

    autofarm:OnChanged(function(value)
        farmer = value

        if (value) then
            if not (oldPos_Farming) then
                oldPos_Farming = rootPart.CFrame
            end

            tween(CFrame.new(-259.504608, 60.9477654, -745.243408, -0.999818861, 7.66576136e-08, 0.0190321952, 7.65230581e-08, 1, -7.79803688e-09, -0.0190321952, -6.34022257e-09, -0.999818861))

            task.wait(0.8)
            
            while (farmer) do
                if (get() == "The Nerd") or (get() == "The Hyper") or (get() == "The Sporty") then
                    tween(combatZone.CFrame + Vector3.new(0, 2.4, 0))
                else
                    tween(combatZone.CFrame + Vector3.new(0, 3.78, 0))
                end

                if (badGuys) then
                    for _,v in ipairs(badGuys:GetChildren()) do
                        local newRoot = v:FindFirstChild("HumanoidRootPart")
                        if (newRoot) then
                            if (get() == "The Nerd") or (get() == "The Hyper") or (get() == "The Sporty") then
                                newRoot.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 5, 0))
                            else
                                newRoot.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 6, 0))
                            end
                        end
                    end
                end
                task.wait()
            end
        else
            if (oldPos_Farming) == nil then
                print("Starry whaled approchaing false error! 🐋")
            else
                task.wait(0.5)

                tween(oldPos_Farming)
                oldPos_Farming = nil
            end
        end
    end)
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
    tabs.money:AddButton({
        Title = "Pickup Floor Money",
        Description = "Grab all of the money left on the ground.",
        Callback = function()
            local old = rootPart.CFrame

            for _,v in ipairs(workspace:GetChildren()) do
                if (v.Name) == "Money3" then
                    to(v.CFrame + Vector3.new(0, 5, 0))
                    task.wait(0.15)
                end
            end

            to(old)

            for _,v in ipairs(workspace:GetChildren()) do
                if (v.Name) == "Money3" then
                    v:Destroy()
                end
            end
        end
    })
end

-- world tab

do
    local tps = tabs.world:AddDropdown("Map TPs", {
        Title = "Map Teleports",
        Values = {"Base", "Middle Room", "Combat", "Evil Enterance", "Gym", "Vault", "Kitchen", "Attic", "Shop", "Bridge", "Spawn", "Electrical", "Rainbow Pizza", "Boss Zone", "Boss Rock", "Main Stage", "Lantern"},
        Multi = false,
        Default = "Select One",
    })

    tps:OnChanged(function(value)
        if (value) == "Base" then
            tween(CFrame.new(-208.547775, 30.4590473, -790.797852, -0.00346331322, 4.98604491e-09, 0.99999398, 1.30425786e-08, 1, -4.94090413e-09, -0.99999398, 1.30253888e-08, -0.00346331322))
        elseif (value) == "Combat" then
            tween(CFrame.new(-261.34845, 62.7139359, -724.488159, -1.79693988e-13, -3.2983916e-08, 1, -1.07291555e-07, 1, 3.2983916e-08, -1, -1.07291555e-07, -1.83232878e-13))
        elseif (value) == "Gym" then
            tween(CFrame.new(-256.629486, 63.4500465, -839.432983, 0.999921203, -2.7656041e-08, -0.0125548635, 2.82457258e-08, 1, 4.67913708e-08, 0.0125548635, -4.71423043e-08, 0.999921203))
        elseif (value) == "Vault" then
            tween(CFrame.new(-291.475739, 30.4500484, -790.533081, 0.00482816575, -4.86728702e-08, 0.999988317, -6.35414139e-08, 1, 4.89802296e-08, -0.999988317, -6.37771578e-08, 0.00482816575))
        elseif (value) == "Kitchen" then
            tween(CFrame.new(-255.886139, 30.4500484, -721.825317, 0.00906592328, 6.37471231e-08, -0.999958932, -4.54148967e-08, 1, 6.33379997e-08, 0.999958932, 4.48388136e-08, 0.00906592328))
        elseif (value) == "Shop" then
            tween(CFrame.new(-248.251205, 30.4500484, -842.678345, 0.999852598, 4.45619897e-08, 0.017169375, -4.45284272e-08, 1, -2.3370581e-09, -0.017169375, 1.57218838e-09, 0.999852598))
        elseif (value) == "Bridge" then
            tween(CFrame.new(-231.054459, 95.4499969, -790.746521, 0.00668484438, 3.52284785e-10, 0.999977648, 1.01747538e-07, 1, -1.03247433e-09, -0.999977648, 1.01752164e-07, 0.00668484438))
        elseif (value) == "Attic" then
            tween(CFrame.new(-287.437775, 95.4500275, -780.781433, 0.740976393, 2.15010032e-09, 0.671531022, -3.9196304e-09, 1, 1.12318466e-09, -0.671531022, -3.46440676e-09, 0.740976393))
        elseif (value) == "Spawn" then
            tween(CFrame.new(74.5977631, 29.4499969, -524.733887, 1, 2.49527812e-08, 4.49900161e-14, -2.49527812e-08, 1, 1.61761289e-08, -4.45863744e-14, -1.61761289e-08, 1))
        elseif (value) == "Electrical" then
            tween(CFrame.new(-124.204483, 29.25, -787.395874, -0.672930658, 1.02147091e-08, -0.739705622, 1.61808469e-08, 1, -9.11009435e-10, 0.739705622, -1.25821096e-08, -0.672930658))
        elseif (value) == "Middle Room" then
            tween(CFrame.new(-260.818848, 30.5996704, -784.877991, -0.0198783204, 4.94843881e-08, -0.999802411, 8.56550955e-08, 1, 4.77911541e-08, 0.999802411, -8.46881605e-08, -0.0198783204))
        elseif (value) == "Evil Enterance" then
            tween(CFrame.new(-1353.15796, -346.246887, -810.455688, 0.0348753519, -5.79011861e-08, 0.999391675, 8.21193638e-08, 1, 5.50707462e-08, -0.999391675, 8.01487943e-08, 0.0348753519))
        elseif (value) == "Rainbow Pizza" then
            tween(CFrame.new(-1502.05579, -368.046814, -885.071106, 0.0242382511, 4.45842723e-08, 0.999706209, -4.52039473e-09, 1, -4.4487777e-08, -0.999706209, -3.44076079e-09, 0.0242382511))
        elseif (value) == "Boss Zone" then
            tween(CFrame.new(-1563.1604, -368.711945, -991.387329, 0.999939799, -1.11001053e-09, 0.0109716114, 7.12828407e-10, 1, 3.62048098e-08, -0.0109716114, -3.61948089e-08, 0.999939799))
        elseif (value) == "Boss Rock" then
            tween(CFrame.new(-1496.57507, -325.1586, -1065.0708, 0.0181015152, -6.20831955e-08, 0.999836147, -3.8816065e-08, 1, 6.27961114e-08, -0.999836147, -3.99464106e-08, 0.0181015152))
        elseif (value) == "Main Stage" then
            tween(CFrame.new(-1563.35999, -366.546814, -1135.27747, 0.992206514, 7.79071243e-08, -0.124604166, -8.7027729e-08, 1, -6.77534047e-08, 0.124604166, 7.8069391e-08, 0.992206514))
        elseif (value) == "Lantern" then
            tween(CFrame.new(-1485.51794, -281.012756, -1270.55884, -0.859563828, 3.25664118e-08, -0.511028409, -2.34444109e-08, 1, 1.03161341e-07, 0.511028409, 1.00654518e-07, -0.859563828))
        end
    end)

    ---

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