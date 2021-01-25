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

local bindable = Instance.new("BindableFunction")
function bindable.OnInvoke(text)
    if text == "pussy out [log]" then
        player:Kick(getgenv().kickString)
    end
end

coroutine.resume(coroutine.create(function()
    while wait(.5) do
        for _, v in next, game:GetService("Players"):GetChildren() do
            pcall(function()
                if v:GetRoleInGroup(6867395) ~= "Fan" then
                    if getgenv().ModLog then
                        player:Kick(getgenv().kickString)
                    elseif not table.find(blacklist, v.Name) then
                        table.insert(blacklist, v.Name)
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "Moderator Detected",
                            Text = v.Name,
                            Button1 = "wanna stay? [alpha as fuck]",
                            Button2 = "pussy out [log]",
                            Callback = bindable,
                            Duration = 999999
                        })
                    end
                end
            end)
        end
    end
end))
