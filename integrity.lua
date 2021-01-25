--// Variables
local integrityTable, oldHunger, oldWarmth

--// Grab table and functions
for _, v in next, getgc(true) do
    if type(v) == "table" and rawget(v, "depleteHunger") then
        integrityTable = v
        oldHunger = v.depleteHunger
        oldWarmth = v.depleteWarmth
    end
end

--// Disable
getgenv().disableHunger = function()
    v.depleteHunger = function() end
end
getgenv().disableWarmth = function()
    v.depleteWarmth = function() end
end

--// Enable
getgenv().enableHunger = function()
    v.depleteHunger = oldHunger
end
getgenv().enableWarmth = function()
    v.depleteWarmth = oldWarmth
end
