xpcall(function()
local player = game:GetService('Players').LocalPlayer
local gmt = getrawmetatable(game)
local oldNamecall = gmt.__namecall
setreadonly(gmt, false)

local s = ""
for i = 1,10 do
    s = s..string.char(math.random(1, 200))
end
getgenv().kickString = s

local blacklist = {}

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

while true do
    for _, v in next, game:service'Players':GetPlayers() do
        pcall(function()
        if v:GetRoleInGroup(6867395) ~= "Fan" then
            if getgenv().ModLog then
                player:Kick(getgenv().kickString)
            elseif not table.find(blackist, v.Name) then
                table.insert(blacklist, v.Name)
                game:service'StarterGui':SetCore("SendNotification", {
                    Title = "Moderator Detected",
                    Text = v.Name,
                    Button1 = "wanna stay? [alpha as fuck]"
                    Button2 = "pussy out [log]"
                    Callback = function(text)
                        if text == "pussy out [log]" then
                            player:kick(getgenv().kickString)
                        end
                    end)
                    Duration = 999999
                })
            end
        end
        end)
    end
    wait(.5)
end
end, warn)
