local userInputService = game:GetService("UserInputService")

if (userInputService.TouchEnabled) and not (userInputService.MouseEnabled) then
    return "Mobile"
else
    return "PC"
end