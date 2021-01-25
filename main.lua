xpcall(function()
    local player = game:service'Players'.LocalPlayer

    --// Anti exploit bypass
    xpcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Synthetic6969/TNW/main/antiExploitBypass.lua", true))()
    end, function() player:kick("Failed to load anti exploit bypass") end)

    --// Set up GUI
    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Synthetic6969/TNW/main/guiLibrary.lua", true))():new()
    local settingsWindow = library:CreateWindow({
        text = "Settings"
    })
    local playerWindow = library:CreateWindow({
        text = "Local Player"
    })
    local utilityWindow = library:CreateWindow({
        text = "Utility"
    })
    local credits = library:CreateWindow({
        text = "Credits"
    })
    
    --// Credits
    credits:AddLabel("Credits\nSynthetic#6969: Scripting\nwally: UI Library\nic3w0lf22: ESP")
    
    --// Settings
    local settings
    if isfile("SynGui.tnw") then
        settings = game:service'HttpService':JSONDecode(readfile("SynGui.tnw"))
        getgenv().ModLog = settings.ModLog
        getgenv().HideName = settings.HideName
        getgenv().SafeFarm = settings.SafeFarm
    else
        settings = {
            ModLog = true;
            HideName = true;
            SafeFarm = true;
            LongRange = {
                {"generalStore1", "Marksman rifle", 1};
                {"illegalSupplies", "Long pistol", 1};
                {"militiaSupplies", "Sabre", 1};
                {"generalStore1", "Bullet", 10};
                {"militiaSupplies", "Flintlock ball", 10};
                {"militiaSupplies", "Bandage", 20};
            };
            MidRange = {
                {"illegalSupplies", "Two-barrel musket", 1};
                {"militiaSupplies", "Dual pistol", 1};
                {"militiaSupplies", "Sabre", 1};
                {"militiaSupplies", "Flintlock ball", 20};
                {"militiaSupplies", "Bandage", 20};
            };
            CloseRange = {
                {"militiaSupplies", "Blunderbuss", 1};
                {"illegalSupplies", "Denix pistol", 1};
                {"illegalSupplies", "War axe", 1};
                {"militiaSupplies", "Flintlock ball", 50};
                {"militiaSupplies", "Bandage", 20};
            };
        }
        writefile("SynGui.tnw", game:service'HttpService':JSONEncode(settings))
    end
    
    function updateSettings()
        settings.ModLog = getgenv().ModLog
        settings.HideName = getgenv().HideName
        settings.SafeFarm = getgenv().SafeFarm
        writefile("SynGui.tnw", game:service'HttpService':JSONEncode(settings))
    end
    
    settingsWindow:AddToggle("Mod Logger", function(toggled)
        getgenv().ModLog = toggled
        updateSettings()
    end)
    xpcall(function()
        coroutine.resume(coroutine.create(function()
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

coroutine.resume(coroutine.create(function()
    while wait(.5) do
    for _, v in next, game:GetService("Players"):GetChildren() do
        pcall(function()
        if v:GetRoleInGroup(6867395) ~= "Fan" then
            if getgenv().ModLog then
                player:Kick(getgenv().kickString)
            elseif not table.find(blackist, v.Name) then
                table.insert(blacklist, v.Name)
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Moderator Detected",
                    Text = v.Name,
                    Button1 = "wanna stay? [alpha as fuck]"
                    Button2 = "pussy out [log]"
                    Callback = function(text)
                        if text == "pussy out [log]" then
                            player:Kick(getgenv().kickString)
                        end
                    end)
                    Duration = 999999
                })
            end
        end
        end)
    end
end
end))
            end, warn)
        end))
    end, warn)
    settingsWindow:AddToggle("Hide Name", function(toggled)
        getgenv().HideName = toggled
        if toggled then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Synthetic6969/TNW/main/hideName.lua", true))()
            updateSettings()
        else
            errorNotification("Rejoin to fix your name.")
        end
    end)
    settingsWindow:AddToggle("Safe Farm", function(toggled)
        getgenv().SafeFarm = toggled
        updateSettings()
    end)
    
    --// Local Player
    playerWindow:AddLabel("WalkSpeed")
    playerWindow:AddBox("16", function(object, focus)
        if focus then
            getgenv().WalkSpeed = tonumber(object.Text)
        end
    end)
    
    playerWindow:AddLabel("JumpPower")
    playerWindow:AddBox("50", function(object, focus)
        if focus then
            getgenv().JumpPower = tonumber(object.Text)
        end
    end)
    
    playerWindow:AddLabel("Teleports")
    tpDropdown = playerWindow:AddDropdown({"James Bay", "Native Camp", "Eastern Tower", "Illegal Vendor", "HBC Fort", "Mercenary Fort", "Northern Camp"}, function(selected)
        if selected == "James Bay" then
            getgenv().TeleportLocation = Vector3.new(-669.846, 54.967, -801.009)
        elseif selected == "Native Camp" then
            getgenv().TeleportLocation = Vector3.new(1856.388, 54.12, 739.615)
        elseif selected == "Eastern Tower" then
            getgenv().TeleportLocation = Vector3.new(555.173, 61.719, 566.956)
        elseif selected == "Illegal Vendor" then
            getgenv().TeleportLocation = workspace.World.Operables.Main.illegalSupplies.Triggers.Trigger.Part.Position
        elseif selected == "HBC Fort" then
            getgenv().TeleportLocation = Vector3.new(-51.126, 75.182, 214.773)
        elseif selected == "Mercenary Fort" then
            getgenv().TeleportLocation = Vector3.new(1200.046, 79.57, -463.039)
        elseif selected == "Northern Camp" then
            getgenv().TeleportLocation = Vector3.new(275.666, 78.412, -508.636)
        end
    end)
    teleportButton = playerWindow:AddButton("Teleport", function()
        local t,e = pcall(function()
            player.Character.HumanoidRootPart.CFrame = CFrame.new(getgenv().TeleportLocation)
        end)
        if not t then errorNotification("Character not found.") end
    end)
    local espEnabled
    playerWindow:AddButton("ESP", function()
        if espEnabled then return end
        espEnabled = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua", true))()
    end)
    playerWindow:AddToggle("Instant Interact", function(toggled)
        getgenv().InstantInteract = toggled
    end)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Synthetic6969/TNW/main/instantInteract.lua", true))()

    --// Utility
    utilityWindow:AddLabel("Autofarms")
    utilityWindow:AddDropdown({"Wood", "Ores", "Hunting"}, function(selected)
        getgenv().FarmType = selected
    end)
    utilityWindow:AddToggle("Autofarm", function(toggled)
        
    end)
    utilityWindow:AddLabel("")
    utilityWindow:AddDropdown({"Close Range", "Mid Range", "Long Range"}, function(selected)
        if selected == "Close Range" then
            getgenv().itemsToBuy = settings.CloseRange
        elseif selected == "Mid Range" then
            getgenv().itemsToBuy = settings.MidRange
        elseif selected == "Long Range" then
            getgenv().itemsToBuy = settings.LongRange
        end
    end)
    utilityWindow:AddButton("Buy Set", function()
        if getgenv().itemsToBuy ~= nil then
            xpcall(function()
                for _, v in next, getgenv().itemsToBuy do
                    getgenv().requestFunction("purchaseItem", v[1], v[2], v[3])
                end
            end, warn)
        else
            errorNotification("You did not select a set!")
        end
    end)
    utilityWindow:AddLabel("")
    utilityWindow:AddBox("Item name", function(object, focus)
        if focus then
            getgenv().itemToBuy = object.Text
        end
    end)
    utilityWindow:AddBox("Amount to buy", function(object, focus)
        if focus then
            getgenv().buyAmount = tonumber(object.Text)
        end
    end)
    utilityWindow:AddDropdown({"HBC", "General Store", "Illegal Vendor"}, function(selected)
        if selected == "HBC" then
            getgenv().shop = "militiaSupplies"
        elseif selected == "General Store" then
            getgenv().shop = "generalStore1"
        elseif selected == "Illegal Vendor" then
            getgenv().shop = "illegalSupplies"
        end
    end)
    utilityWindow:AddButton("Buy", function()
        if getgenv().buyAmount ~= nil or getgenv().shop ~= nil or getgenv().itemToBuy ~= nil then
            warn(getgenv().shop)
            warn(getgenv().itemToBuy)
            warn(getgenv().buyAmount)
            getgenv().requestFunction("purchaseItem", getgenv().shop, getgenv().itemToBuy, getgenv().buyAmount)
        else
            errorNotification("You did not select an item to buy.")
        end
    end)
    utilityWindow:AddLabel("")
    utilityWindow:AddBox("Item to sell", function(object, focus)
        if focus then
            warn(object.Text)
            getgenv().itemToSell = object.Text
        end
    end)
    utilityWindow:AddBox("Amount to sell", function(object, focus)
        if focus then
            warn(object.Text)
            getgenv().sellAmount = tonumber(object.Text)
        end
    end)
    utilityWindow:AddButton("Sell", function()
        if getgenv().itemToSell or getgenv().sellAmount then
            getgenv().requestFunction("sellItem", "generalStore1", getgenv().itemToSell, getgenv().sellAmount)
        else
            errorNotification("You did not select an item to sell.")
        end
    end)
    
    --// Misc
    function errorNotification(msg)
        game:service'StarterGui':SetCore("SendNotification", {
            Title = "Error";
            Text = msg;
            Duration = 5;
        })
    end
    
    --[[local gmt = getrawmetatable(game)
    local oldIndex = gmt.__index
    setreadonly(gmt, false)
    
    gmt.__index = newcclosure(function(self, key)
        if type(self) == "Instance" and self:IsA("Humanoid") and player.Character and self == player.Character:FindFirstChild("Humanoid") and tostring(key) == "WalkSpeed" then
            return oldWalkSpeed
        elseif type(self) == "Instance" and self:IsA("Humanoid") and player.Character and self == player.Character:FindFirstChild("Humanoid") and tostring(key) == "JumpPower" then
            return oldJumpPower
        end
        return oldIndex(self, key)
    end)
    
    local oldWalkSpeed = 16
    local oldJumpPower = 50
    game:service'RunService'.Heartbeat:Connect(function()
        pcall(function()
            player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed or oldWalkSpeed
            player.Character.Humanoid.JumpPower = getgenv().JumpPower or oldJumpPower
        end)
    end)]]
    
    game:service'UserInputService'.InputBegan:Connect(function(input, isTyping)
        if isTyping then return end
        if input.KeyCode == Enum.KeyCode.F5 then
            game.CoreGui.UILibrary.Enabled = not game.CoreGui.UILibrary.Enabled
        end
    end)
end, warn)
