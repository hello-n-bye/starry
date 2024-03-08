local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local BETA = false

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
local replicatedStorage = game:GetService("ReplicatedStorage")
local teleport = game:GetService("TeleportService")

local events = replicatedStorage:FindFirstChild("RemoteEvents")

local localPlayer = players.LocalPlayer

local outfit = false

local function role(name)
    if (name) == "Book" or (name) == "Phone" then
        local outside = events:FindFirstChild("OutsideRole")

        if (name) == "Book" then
            outside:FireServer(name, true, outfit)
        else
            outside:FireServer(name, false, outfit)
        end
    else
        local creation = events:FindFirstChild("MakeRole")

        if (name) == "MedKit" or (name) == "Bat" then
            creation:FireServer(name, false, outfit)
        else
            creation:FireServer(name, true, outfit)
        end
    end
end

local function chat(message)
    replicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
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
    game = window:AddTab({
        Title = " Game",
        Icon = "curly-braces"
    }),
    roles = window:AddTab({
        Title = " Roles",
        Icon = "egg"
    }),
    troll = window:AddTab({
        Title = " Trolling",
        Icon = "skull"
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
    Content = "Join a game to get the full experience, and use more powerful cheats.",
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

    ---

    local reRun = tabs.intro:AddToggle("Re-run", {
        Title = "Run on Rejoin",
        Description = "Automatically run the script after you've rejoined.",
        Default = false
    })

    reRun:OnChanged(function(value)
        queueEnabled = value
    end)

    ---

    tabs.intro:AddParagraph({
        Title = "30+ Features",
        Content = "As of March 2nd, we've hit a milestone of 30+ working features."
    })
end

-- lobby tab

do
    tabs.roles:AddButton({
        Title = "Hacker",
        Description = "Gives you the Hacker role, when playing.",
        Callback = function()
            role("Phone")
        end
    })

    tabs.roles:AddButton({
        Title = "Nerd",
        Description = "Unlock your inner nerd, and literally be a dork.",
        Callback = function()
            role("Book")
        end
    })

    ---

    local free = tabs.roles:AddDropdown("Free Roles", {
        Title = "Change Free Role",
        Values = {"MedKit", "Bottle", "Lollipop", "Bat"},
        Multi = false,
        Default = "Select One"
    })

    free:OnChanged(function(value)
        if (value) ~= "Select One" then
            role(value)
        end
    end)

    ---

    local change = tabs.roles:AddToggle("Change Outfits", {
        Title = "Change Outfits",
        Default = false
    })

    change:OnChanged(function(value)
        outfit = value
    end)
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

    tabs.game:AddButton({
        Title = "Instant Load",
        Description = "Boot into your own private server instantly.",
        Callback = function()
            teleport:Teleport(13864667823, localPlayer)
        end
    })

    tabs.game:AddButton({
        Title = "Join Break In 1",
        Description = "Experience the first game!",
        Callback = function()
            -- firetouchinterest(rootPart, portal, 1)

            teleport:Teleport(3851622790, localPlayer)
        end
    })
end

-- troll tab

do
    local panic = false

    local spasm = tabs.troll:AddToggle("Spasm", {
        Title = "Spasm",
        Description = "Aggressively change your player size on the server.",
        Default = false
    })

    spasm:OnChanged(function(value)
        panic = value

        local inverse = false

        if (get()) == "The Medic" or (get()) == "The Protector" or (get()) == "The Hacker" then
            inverse = true
        end

        while (panic) do
            task.wait()

            if (inverse) then
                role("Lollipop")

                task.wait()
                role("Bat")
            else
                role("Bat")

                task.wait()
                role("Lollipop")
            end
        end
    end)

    ---

    tabs.troll:AddButton({
        Title = "Crash Server",
        Description = "Instantly crash the server using remote vulnerabilities.",
        Callback = function()
            chat("hi i'm " .. localPlayer.DisplayName .. " and i like big oily sweaty boys 😊😊😳😩")
        end
    })
end

window:SelectTab(1)

print("Loaded in " .. string.format("%.2f", tick() - timestamp) .. " seconds. ⭐")
