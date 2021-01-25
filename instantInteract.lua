local player = game:service'Players'.LocalPlayer
local mouse = player:GetMouse()

local eDown
game:service'UserInputService'.InputBegan:Connect(function(input, isTyping)
    if isTyping then return end
    if input.KeyCode == Enum.KeyCode.E then
        eDown = true
    end
end)
game:service'UserInputService'.InputEnded:Connect(function(input, isTyping)
    if isTyping then return end
    if input.KeyCode == Enum.KeyCode.E then
        eDown = false
    end
end)

game:service'RunService'.RenderStepped:Connect(function()
    if getgenv().FastInteract then
        --// Pick up
        if eDown and mouse.Target ~= nil then
            if mouse.Target.Parent.Parent == workspace.World.Items then
                getgenv().requestFunction("take", mouse.Target.Parent)
            elseif mouse.Target.Parent:FindFirstChild("Type") and mouse.Target.Parent.Parent.Parent.Status.Type.Value == "tree" then
                getgenv().requestFunction("interact", true, "tree", mouse.Target.Parent.Parent.Parent)
            elseif mouse.Target.Parent:FindFirstChild("Type") and mouse.Target.Parent.Parent.Parent.Status.Type.Value == "mine" then
                getgenv().requestFunction("interact", true, "mine", mouse.Target.Parent.Parent.Parent)
            elseif mouse.Target.Parent
            end
        end
    end
end)
