local fluent = loadstring(game:HttpGetAsync('https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua'))() -- love you dawid

local window = fluent:CreateWindow({
    Title = 'Starry 💫',
    SubTitle = tostring(getgenv().__version),
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = 'Dark',
    MinimizeKey = Enum.KeyCode.LeftControl -- probably won't be used at all ...!
})

local tabs = {
    main = window:AddTab({
        Title = 'Main',
        Icon = ''
    }),
}

local options = fluent.Options

tabs.main:AddButton({
    Title = 'hi world',
    Description = 'i am sad :(',
    Callback = function()
        Fluent:Notify({
            Title = 'my lovely message',
            Content = 'hello world',
            Duration = 5
        })
    end
})