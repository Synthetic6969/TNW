local players = game:service'Players'
local player = players.LocalPlayer

--// Pick up all
local oldPos = player.Character.HumanoidRootPart.CFrame

local teleporting = true
local tpConnection

tpConnection = game:service'RunService'.RenderStepped:Connect(function()
    if teleporting then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        wait()
    else
        tpConnection:Disconnect()
    end
end)

function PickUpAll()
    for _, v in next, workspace.World.Items:GetChildren() do
        xpcall(function()
            local mainPart
            if v:FindFirstChild("Main") then
                mainPart = v.Main
            elseif v:FindFirstChild("MeshPart") then
                mainPart = v.MeshPart
            end
            local shouldWait
            if (player.Character.HumanoidRootPart.Position - mainPart.Position).Magnitude > 10 then
                shouldWait = true
            end
            player.Character.HumanoidRootPart.CFrame = CFrame.new(mainPart.Position) * CFrame.new(0, -4, 0)
            if shouldWait then wait(.125) end
            coroutine.resume(coroutine.create(function()
                getgenv().requestFunction("take", v)
            end))
        end, warn)
    end

    player.Character.HumanoidRootPart.CFrame = oldPos
end
--// Loot all chests
function LootAllChests()
    oldPos = player.Character.HumanoidRootPart.CFrame

    for _, v in next, workspace.World.Operables.Main:GetChildren() do
        if v.Name == "Chest" then
            xpcall(function()
                if (player.Character.HumanoidRootPart.Position - v.Main.Position).Magnitude > 10 then
                    wait(.1)
                end
                player.Character.HumanoidRootPart.CFrame = CFrame.new(v.Main.Position) * CFrame.new(0, -4, 0)
                wait(.2)
                for _, v2 in next, v.Status.Items:GetChildren() do
                    getgenv().requestFunction("takeStorage", v2.Name, v)
                end
            end, warn)
        end
    end
end)

for _, v in next, workspace.World.Operables.Deployables:GetChildren() do
    if v.Name == "Chest" then
        xpcall(function()
            if (player.Character.HumanoidRootPart.Position - v.Main.Position).Magnitude > 10 then
                wait(.1)
            end
            player.Character.HumanoidRootPart.CFrame = CFrame.new(v.Main.Position) * CFrame.new(0, -4, 0)
            wait(.2)
            for _, v2 in next, v.Status.Items:GetChildren() do
                getgenv().requestFunction("takeStorage", v2.Name, v)
            end
        end, warn)
    end
end

teleporting = false
player.Character.HumanoidRootPart.CFrame = oldPos

--// Mining
spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        s, e = pcall(function()
            if getgenv().MineAuto then
                oldPos = player.Character.HumanoidRootPart.CFrame

                for _, v in next, workspace.World.Operables.Resources:GetChildren() do
                    if v.Status.Type.Value == "mine" then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(v.Main.Position, v.Main.Position) * CFrame.new(0, -3, 0)
                        wait(.2)
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
                        spawn(function()
                            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
                            getgenv().requestFunction("interact", true, "mine", v)
                        end)
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
                        wait(.2)
                    end
                end

                wait(1.5)

                for _, v in next, workspace.World.Items:GetChildren() do
                    xpcall(function()
                        local mainPart
                        if v:FindFirstChild("Main") then
                            mainPart = v.Main
                        elseif v:FindFirstChild("MeshPart") then
                            mainPart = v.MeshPart
                        end
                        local shouldWait
                        if (player.Character.HumanoidRootPart.Position - mainPart.Position).Magnitude > 10 then
                            shouldWait = true
                        end
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(mainPart.Position) * CFrame.new(0, 3, 0)
                        if shouldWait then wait(.15) end
                        coroutine.resume(coroutine.create(function()
                            getgenv().requestFunction("take", v)
                        end))
                    end, warn)
                end

                player.Character.HumanoidRootPart.CFrame = oldPos

                for _, v in next, player.Status.Items:GetChildren() do
                    if v.Name == "Iron ore" then
                        getgenv().requestFunction("craft", "Iron ingot")
                    elseif v.Name == "Gold ore" then
                        getgenv().requestFunction("craft", "Gold ingot")
                    end
                end

                for _, v in next, player.Status.Items:GetChildren() do
                    if v.Name == "Iron ingot" then
                        getgenv().requestFunction("craft", "Reinforced wall")
                    end
                end

                wait(2)
                getgenv().requestFunction(
                    "sellItem",
                    "generalStore1",
                    "Reinforced wall",
                    1000
                )
                getgenv().requestFunction(
                    "sellItem",
                    "generalStore1",
                    "Stone",
                    1000
                )
                getgenv().requestFunction(
                    "sellItem",
                    "generalStore1",
                    "Sulphur",
                    1000
                )
                getgenv().requestFunction(
                    "sellItem",
                    "generalStore1",
                    "Gold ingot",
                    1000
                )
                getgenv().requestFunction(
                    "sellItem",
                    "generalStore1",
                    "Iron ingot",
                    1000
                )
              end 
           end   
        end)
    end)
end) 
