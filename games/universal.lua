local rays = loadstring(game:HttpGet('https://sirius.menu/rayfield'))() -- love you shlexy

local window = rays:CreateWindow({
    Name = 'Starry 💫',
    LoadingTitle = 'https://github.com/hello-n-bye/starry',
    LoadingSubtitle = 'by yours truly',
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = nil
    },
    Discord = {
        Enabled = false,
        Invite = 'dshMH6Edeu',
        RememberJoins = true
    },

    -- below are useless key lines lol
    KeySystem = false,
    KeySettings = {
        Title = 'Untitled',
        Subtitle = 'Key System',
        Note = 'No method of obtaining the key is provided',
        FileName = 'Key',
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {'Hello'}
    }
})

local main = window:CreateTab('Main', 4483362458) -- header, img [id]

local playerMods = window:CreateTab('Player Mods') -- fixate tmrw after modulus update for the day