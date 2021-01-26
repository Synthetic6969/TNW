local player = game:service'Players'.LocalPlayer
local statusFolder = player:WaitForChild("Status")

statusFolder.Hunger.Changed:Connect(function()
    if getgenv().infiniteHunger then
        statusFolder.Hunger.Value = 200
    end
end)
statusFolder.Warmth.Changed:Connect(function()
    if getgenv().infiniteWarmth then
        statusFolder.Warmth.Value = 5000
    end
end)
