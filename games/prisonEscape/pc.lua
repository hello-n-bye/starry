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

local timestamp = tick()

local queueteleport = queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local queueEnabled = false

local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")
local teleport = game:GetService("TeleportService")

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local function changeTeam(new)
    local args = {
        [1] = tostring(new)
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("NewTeamerC"):FireServer(unpack(args))    
end

local function find(str)
    if not (str) then
        return
    end

    local found = {}

    for _,v in ipairs(players:GetPlayers()) do
        if (string.lower(v.Name):match(string.lower(str))) or (string.lower(v.DisplayName):match(string.lower(str))) then
            table.insert(found, v)
        end
    end

    if (#found > 0) then
        return found[1]
    elseif (#found < 1) then
        return nil
    end
end

local function murder(target, alled)
    local players = game:GetService("Players")

    local localPlayer = players.LocalPlayer
    local objs = {target.Name}
    
    local character = localPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local RootPart = humanoid and humanoid.RootPart
    
    local get = players:GetPlayers()
    
    local all = alled
    
    local find2 = function(name)
        name = name:lower()
    
        if (name) == "all" or (name) == "others" then
            all = true
    
            return
        elseif (name) == "random" then
            if table.find(get,localPlayer) then
                table.remove(get,table.find(get,localPlayer))
            end
    
            return get[math.random(#get)]
        elseif name ~= "random" and name ~= "all" and name ~= "others" then
            for _,x in next, get do
                if x ~= localPlayer then
                    if x.Name:lower():match("^" .. name) then
                        return x
                    elseif x.DisplayName:lower():match("^" .. name) then
                        return x
                    end
                end
            end
        else
            return
        end
    end
    
    local fling = function(noob)
        local newChar = noob.Character
        local newHum
        local newRootPart
        local newHead
    
        local Accessory
        local Handle
    
        if (newChar:FindFirstChildOfClass("Humanoid")) then
            newHum = newChar:FindFirstChildOfClass("Humanoid")
        end
    
        if (newHum) and (newHum.RootPart) then
            newRootPart = newHum.RootPart
        end
    
        if (newChar:FindFirstChild("Head")) then
            newHead = newChar.Head
        end
    
        if (newChar:FindFirstChildOfClass("Accessory")) then
            Accessory = newChar:FindFirstChildOfClass("Accessory")
        end
    
        if (Accessory) and (Accessory:FindFirstChild("Handle")) then
            Handle = Accessory.Handle
        end
    
        if (character) and (humanoid) and (RootPart) then
            if (RootPart.Velocity.Magnitude) < 50 then
                getgenv().old = RootPart.CFrame
            end
    
            if (newHead) then
                workspace.CurrentCamera.CameraSubject = newHead
            elseif not (newHead) and (Handle) then
                workspace.CurrentCamera.CameraSubject = Handle
            elseif (newHum) and (newRootPart) then
                workspace.CurrentCamera.CameraSubject = newHum
            end
    
            if not (newChar:FindFirstChildWhichIsA("BasePart")) then
                return
            end
    
            local zoom = function(BasePart, pos, angle)
                RootPart.CFrame = CFrame.new(BasePart.Position) * pos * angle
    
                character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * pos * angle)
    
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end
    
            local safe = function(BasePart)
                local time = tick()
                local angle = 0
    
                repeat
                    if RootPart and newHum then
                        if BasePart.Velocity.Magnitude < 50 then
                            angle = angle + 100
    
                            zoom(BasePart, CFrame.new(0, 1.5, 0) + newHum.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0 , 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, -1.5, 0) + newHum.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(2.25, 1.5, -2.25) + newHum.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(-2.25, -1.5, 2.25) + newHum.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, 1.5, 0) + newHum.MoveDirection,CFrame.Angles(math.rad(angle), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, -1.5, 0) + newHum.MoveDirection,CFrame.Angles(math.rad(angle), 0, 0))
                            task.wait()
                        else
                            zoom(BasePart, CFrame.new(0, 1.5, newHum.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, -1.5, -newHum.WalkSpeed), CFrame.Angles(0, 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, 1.5, newHum.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, 1.5, newRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, -1.5, -newRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, 1.5, newRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, -1.5 , 0), CFrame.Angles(math.rad(-90), 0, 0))
                            task.wait()
    
                            zoom(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                        end
                    else
                        break
                    end
                until (BasePart.Velocity.Magnitude) > 500 or (BasePart.Parent) ~= noob.Character or (noob.Parent) ~= players or not (noob.Character) == newChar or (newHum.Sit) or (humanoid.Health) <= 0 or (tick()) > time + 2
            end
    
            workspace.FallenPartsDestroyHeight = 0/0
    
            local vel = Instance.new("BodyVelocity")
            vel.Name = "Starry"
            vel.Parent = RootPart
            vel.Velocity = Vector3.new(9e8, 9e8, 9e8)
            vel.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
    
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    
            if (newRootPart) and (newHead) then
                if (newRootPart.CFrame.p - newHead.CFrame.p).Magnitude > 5 then
                    safe(newHead)
                else
                    safe(newRootPart)
                end
            elseif (newRootPart) and not (newHead) then
                safe(newRootPart)
            elseif not (newRootPart) and (newHead) then
                safe(newHead)
            elseif not (newRootPart) and not (newHead) and (Accessory) and (Handle) then
                safe(Handle)
            end
    
            vel:Destroy()
    
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = humanoid
    
            repeat
                RootPart.CFrame = getgenv().old * CFrame.new(0, .5, 0)
    
                character:SetPrimaryPartCFrame(getgenv().old * CFrame.new(0, .5, 0))
                humanoid:ChangeState("GettingUp")
    
                table.foreach(character:GetChildren(), function(_, x)
                    if x:IsA("BasePart") then
                        x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end)
    
                task.wait()
            until (RootPart.Position - getgenv().old.p).Magnitude < 25
        end
    end
    
    if objs[1] then
        for _,x in next, objs do
            find2(x)
        end
    else
        return
    end
    
    if all then
        for _,x in next, players:GetPlayers() do
            fling(x)
        end
    end
    
    for _,x in next, objs do
        if find2(x) and find(x) ~= localPlayer then
            if find2(x).UserId ~= 1414978355 then
                local TPlayer = find2(x)
                if TPlayer then
                    fling(TPlayer)
                end
            end
        end
    end
end

local function getTeam()
    local team = localPlayer.Team

    if (team) == "Inmates" then
        return ("Prisoner")
    elseif (team) == "Guards" then
        return ("Cop")
    elseif (team) == "Picking Team" then
        return ("Neutral")
    elseif (team) == "Criminals" then
        return ("Criminal")
    end
end

local presets = {
    ['walkspeed'] = 16,
    ['jumppower'] = 50,
}

local window = flu:CreateWindow({
    Title = "Starry 💫",
    SubTitle = "github.com/hello-n-bye/Starry",
    TabWidth = 160,
    Size = UDim2.fromOffset(625, 460),
    Acrylic = false,
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
    tools = window:AddTab({
        Title = " Tools",
        Icon = "shield"
    }),
    combat = window:AddTab({
        Title = " Combat",
        Icon = "swords"
    })
}

flu:Notify({
    Title = "Star The Repo ⭐",
    Content = "Like our open-sourced project? Give it a star over on Github.",
    SubContent = "github.com/hello-n-bye/Starry",
    Duration = 5
})

-- combat tab

do
    local kill = tabs.combat:AddDropdown("Kill", {
        Title = "Kill",
        Values = {"Myself", "All", "Guards", "Prisoners", "Criminals"},
        Multi = false,
        Default = "Select One"
    })

    kill:OnChanged(function(value)
        if (value) == "Myself" then
            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
            character:BreakJoints()
        elseif (value) == "All" then
            murder(find(localPlayer.Name), true)
        end
    end)

    ---

    local hate = false

    local loopKill = tabs.combat:AddToggle("Loopkill All", {
        Title = "Loopkill Everyone",
        Description = "Literally abolish the server. You know you wanna.",
        Default = false
    })

    loopKill:OnChanged(function(value)
        hate = value

        while (hate) and (task.wait()) do
            xpcall(function()
                murder(find(localPlayer.Name), true) -- Run it one time
            end, function()
                murder(find(localPlayer.Name), true) -- When it gets an error, run it again :sunglasses:
            end)
        end
    end)

    ---

    tabs.combat:AddInput("Kill User", {
        Title = "Kill Player",
        Default = "",
        Placeholder = "Someone You Dislike",
        Numeric = false,
        Finished = true,
        Callback = function(person)
            xpcall(function()
                local target = find(person)

                murder(target, false)
            end, function(err)
                warn("💫 Starry Debugger: " .. err)
            end)
        end
    })

    ---

    local hater = false
    local targetted

    local lkPlayer = tabs.combat:AddInput("Loopkill User", {
        Title = "Loopkill Player",
        Default = "",
        Placeholder = "Someone You Dislike",
        Numeric = false,
        Finished = true,
        Callback = function(person)
            targetted = find(person)
        end
    })

    local lk = tabs.combat:AddToggle("Loopkill Switch", {
        Title = "Loopkill Switch",
        Description = "Choose whether loopkilling is enabled, or disabled.",
        Default = false
    })

    lkPlayer:OnChanged(function(value)
        hater = value

        while (hater) and (task.wait()) do
            xpcall(function()
                murder(targetted, false)
            end, function()
                murder(targetted, false)
            end)
        end
    end)
end

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

-- player tab

do
    local swap = tabs.player:AddDropdown("Join Team", {
        Title = "Join Team",
        Values = {"Neutral", "Cop", "Prisoner", "Criminal"},
        Multi = false,
        Default = "Select One"
    })

    swap:OnChanged(function(value)
        if (value) == "Neutral" then
            changeTeam("picking")
        elseif (value) == "Cop" then
            changeTeam("guard")
        elseif (value) == "Prisoner" then
            changeTeam("prisoner")
        elseif (value) == "Criminal" then
            changeTeam("Criminal")
        end
    end)
end

-- tools tab

do
    local give = tabs.tools:AddDropdown("Static Tools", {
        Title = "Static Guns",
        Values = {"Ithaca 37", "Riot Shotgun", "AWP", "Alien Ray"},
        Mutli = false,
        Default = "Select One"
    })

    give:OnChanged(function(value)
        if (value) == "Ithaca 37" then
            fireclickdetector(workspace.AllGiversForEverything.ShotGunGuardGiver.ClickDetector)
        elseif (value) == "Riot Shotgun" then
            fireclickdetector(workspace.AllGiversForEverything.RiotShotGun.ClickDetector)
        elseif (value) == "Alien Ray" then
            fireclickdetector(workspace.AllGiversForEverything.AlienRayGiver.ClickDetector)
        elseif (value) == "AWP" then
            fireclickdetector(workspace.AllGiversForEverything.AWP.ClickDetector)
        end
    end)

    ---

    local utility = tabs.tools:AddDropdown("Give Utility", {
        Title = "Give Utility",
        Values = {"MedKit", "Stun Gun", "Donuts", "Baton", "Police Cap"},
        Mutli = false,
        Default = "Select One"
    })

    utility:OnChanged(function(value)
        if (value) == "MedKit" then
            fireclickdetector(workspace.AllGiversForEverything:GetChildren()[79].ClickDetector)
        elseif (value) == "Stun Gun" then
            fireclickdetector(workspace.AllGiversForEverything:GetChildren()[82].ClickDetector)
        elseif (value) == "Donuts" then
            fireclickdetector(workspace.AllGiversForEverything:GetChildren()[115].ClickDetector)
        elseif (value) == "Baton" then
            fireclickdetector(workspace.AllGiversForEverything:GetChildren()[25].ClickDetector)
        elseif (value) == "Police Cap" then
            fireclickdetector(workspace.AllGiversForEverything:GetChildren()[32].ClickDetector)
        end
    end)
end

window:SelectTab(1)

print("Loaded in " .. string.format("%.2f", tick() - timestamp) .. " seconds. ⭐")
