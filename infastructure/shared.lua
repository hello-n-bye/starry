petSim = do
    local placeid = game.PlaceId

    if (placeid) == 8737899170 then
        print('loading genv')
        getgenv().farming = true
    end
end

getgenv().version = "1.0"

print('loaded globals')