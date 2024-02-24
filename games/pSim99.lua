local functions = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/modules/miscellaneous.lua", true))()
local __game = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/modules/petSim.lua", true))()

local states = { farming = true, __zones = true }

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")

local lib = require(replicatedStorage.Library)

local getNearestBreakable = getsenv(players.LocalPlayer.PlayerScripts.Scripts.GUIs["Auto Tapper"]).GetNearestBreakable

local network = lib.Network
local balancing = lib.Balancing

local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRP = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")

lib.PlayerPet.CalculateSpeedMultiplier = __game.infiniteSpeed()

coroutine.wrap(function()
    while (states.farming) do
        functions.yield()
    
        local zone, info = lib["ZoneCmds"].GetMaxOwnedZone()
        local zoning, nexts = lib["ZoneCmds"].GetNextZone()
    
        if (states.__zones) then
            if (zoning) and (nexts) then
                if (balancing.CalcGatePrice(nexts)) <= (lib["CurrencyCmds"].Get("Coins")) then
                    network.Invoke("Zones_RequestPurchase", nexts.ZoneName)
                end
            end
        end
    
        if (lib["MapCmds"].GetCurrentZone()) ~= (info._id) or not (lib["MapCmds"].IsInDottedBox()) then
            if (info.ZoneFolder:FindFirstChild("INTERACT")) then
                local max, breakZone
    
                for _,v in ipairs(info.ZoneFolder.INTERACT.BREAK_ZONES:GetChildren()) do
                    if not (max) then
                        max = v.Size.X * v.Size.Y * v.Size.Z
                    end if not (breakZone) then
                        breakZone = v
                    end
    
                    if (max) < (v.Size.X * v.Size.Y * v.Size.Z) then
                        breakZone = v
                    end
                end
    
                humanoidRP.CFrame = breakZone.CFrame * CFrame.new(0, 10, 0)
            else
                humanoidRP.CFrame = info.ZoneFolder.PERSISTENT.Teleport.CFrame
            end
        end
    end
end)()

coroutine.wrap(function()
    while (functions.yield()) do
        local breakable = getNearestBreakable()

        if (breakable) then
            Network.Fire("Breakables_PlayerDealDamage", breakable.Name)
        end
    end
end)()

print('loaded pet sim hax')