local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local push = (http and http.request) or http_request or (fluxus and fluxus.request) or request
local queue = (fluxus and fluxus.queueteleport) or queue_on_teleport

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
        queue('loadstring(game:HttpGet("https://raw.githubusercontent.com/hello-n-bye/starry/master/main.lua"))()')
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
local function getPlayersList()
    for _,v in ipairs(players:GetPlayers()) do
        if (v.Name) ~= (localPlayer.Name) then
            table.insert(listed, v.Name)
        end
    end
end

getPlayersList()

local gotoPlayer = tabs.player:AddDropdown("Player TP", {
    Title = "Goto Player",
    Values = listed,
    Multi = false,
    Default = "Select One"
})

local spectate = tabs.player:AddDropdown("Spectate", {
    Title = "Spectate Player",
    Values = listed,
    Multi = false,
    Default = "Select One"
})

players.PlayerAdded:Connect(function(player)
    table.insert(listed, player.Name)
    gotoPlayer:SetValues(listed)
end)

players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(listed) do
        if (name) == (player.Name) then
            table.remove(listed, i)
            break
        end
    end
    gotoPlayer:SetValues(listed)
end)

gotoPlayer:OnChanged(function(player)
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")
    local succ, err = xpcall(function()
        local newChar = players[player].Character or players[player].CharacterAdded:Wait()
        rootPart.CFrame = newChar.HumanoidRootPart.CFrame
    end, function(error)
        notify("Couldn't Teleport", tostring(error))
    end)
end)

spectate:OnChanged(function(player)
    local camera = workspace.CurrentCamera
    local succ, err = xpcall(function()
        local newChar = players[player].Character or players[player].CharacterAdded:Wait()
        camera.CameraSubject = newChar
    end, function(error)
        notify("Couldn't Spectate", tostring(error))
    end)
end)

local unspectate = tabs.player:AddButton({
    Title = "Unspectate",
    Description = "Lock your camera back on yourself.",
    Callback = function()
        local camera = workspace.CurrentCamera
        local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local succ, err = xpcall(function()
            camera.CameraSubject = newChar
        end, function(error)
            notify("Couldn't Stop Spectating", tostring(error))
        end)
    end
})

local fly = tabs.player:AddToggle("Fly", {
    Title = "Flying",
    Default = false
})

fly:OnChanged(function(value)
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

    local signal1
    local signal2

    local firedOriginally = false

    if (value) then
        firedOriginally = true

        local controlModule = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "VelocityHandler"
        bodyVelocity.Parent = localPlayer.Character.HumanoidRootPart
        bodyVelocity.MaxForce = Vector3.new(0,0,0)
        bodyVelocity.Velocity = Vector3.new(0,0,0)
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Name = "GyroHandler"
        bodyGyro.Parent = localPlayer.Character.HumanoidRootPart
        bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bodyGyro.P = 1000
        bodyGyro.D = 50
        
        signal1 = localPlayer.CharacterAdded:Connect(function(newChar)
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Name = "VelocityHandler"
            bodyVelocity.Parent = newChar:WaitForChild("Humanoid").RootPart
            bodyVelocity.MaxForce = Vector3.new(0,0,0)
            bodyVelocity.Velocity = Vector3.new(0,0,0)
        
            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.Name = "GyroHandler"
            bodyGyro.Parent = newChar:WaitForChild("Humanoid").HumanoidRootPart
            bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
            bodyGyro.P = 1000
            bodyGyro.D = 50
        end)
        
        local camera = game.Workspace.CurrentCamera
        
        signal2 = game:GetService("RunService").RenderStepped:Connect(function()
            if (localPlayer.Character) and (localPlayer.Character:FindFirstChildOfClass("Humanoid")) and (localPlayer.Character.Humanoid.RootPart) and (localPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler")) and (localPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler")) then
        
                localPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
                localPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
                localPlayer.Character.Humanoid.PlatformStand = true
        
                localPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = camera.CoordinateFrame
                localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
                
                
                local direction = controlModule:GetMoveVector()	
                
                if (direction.X) > 0 then
                    localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * speed)
                end
                
                if (direction.X) < 0 then
                    localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * speed)
                end
                
                if (direction.Z) > 0 then
                    localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * speed)
                end
                
                if (direction.Z) < 0 then
                    localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = localPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * speed)
                end
            end
        end)
    else
        if (firedOriginally) then
            game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
            game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    
            signal1:Disconnect()
            signal2:Disconnect()
        else
            print("You have to enable the fly first to disable it once, goofball.")
        end
    end
end)

window:SelectTab(1)