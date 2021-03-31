local player = game:GetService('Players').LocalPlayer

--// Generate random kick key
local s = ""
for i = 1,10 do
    s = s..string.char(math.random(1, 200))
end
getgenv().kickString = s

--// Kick namecall
local gmt = getrawmetatable(game)
local oldNamecall = gmt.__namecall
setreadonly(gmt, false)

gmt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if string.lower(tostring(method)) == "kick" and self == player then
        if args[1] == getgenv().kickString then
            return oldNamecall(self, "Moderator Detected")
        else
            return 
        end
    end
    return oldNamecall(self, ...)
end)

--// Button callback
local bindable = Instance.new("BindableFunction")
function bindable.OnInvoke(text)
    if text == "pussy out" then
        player:Kick(getgenv().kickString)
    end
end

--// Loop
local blacklist = {}
coroutine.resume(coroutine.create(function()
    while wait(.5) do
        --// Check for new mods
        for _, v in next, game:GetService("Players"):GetChildren() do
            pcall(function()
                if v:GetRankInGroup(6867395) > 7 then
                    if getgenv().ModLog then
                        player:Kick(getgenv().kickString)
                    elseif not table.find(blacklist, v.Name) then
                        table.insert(blacklist, v.Name)
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "Moderator Detected",
                            Text = v.Name,
                            Button1 = "idc",
                            Button2 = "pussy out",
                            Callback = bindable,
                            Duration = 999999
                        })
                    end
                end
            end)
        end
        --// Check if mod left game
        for i, v in pairs(blacklist) do
            local modFound
            for _, v2 in next, game:service'Players':GetPlayers() do
                if v2.Name == v then
                    modFound = true
                end
            end
            if not modFound and player then
                table.remove(blacklist, i)
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Moderator Detected",
                    Text = v.Name,
                    Button1 = "epic",
                    Duration = 999999
                })
            end
        end
    end
end))
