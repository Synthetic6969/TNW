local player = game:service'Players'.LocalPlayer
local gmt = getrawmetatable(game)
local oldNamecall = gmt.__namecall
setreadonly(gmt, false)

local s = ""
for i = 1,10 do
    s = s..string.char(math.random(1, 200))
end
getgenv().kickString = s

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
        if v:GetRoleInGroup(6867395) ~= "Fan" then
            if getgenv().ModLog then
                player:kick(getgenv().kickString)
            else
                game:service'StarterGui':SetCore("SendNotification", {
                    Title = "Moderator Detected",
                    Text = v.Name,
                    Button1 = "what a whitehat"
                })
            end
        end
    end
    wait(.5)
end
