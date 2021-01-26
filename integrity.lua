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
    integrityTable.depleteHunger = function() end
end
getgenv().disableWarmth = function()
    integrityTable.depleteWarmth = function() end
end

--// Enable
getgenv().enableHunger = function()
    integrityTable.depleteHunger = oldHunger
end
getgenv().enableWarmth = function()
    integrityTable.depleteWarmth = oldWarmth
end
