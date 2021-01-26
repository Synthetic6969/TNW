local integrityTable, oldHunger, oldWarmth

for _, v in next, getgc(true) do
    if type(v) == "table" and rawget(v, "setHunger") and rawget(v, "setWarmth") then
        integrityTable = v
        oldHunger = v.setHunger
        oldWarmth = v.setWarmth
    end
end

getgenv().enableInfiniteHunger = function()
    integrityTable.setHunger = newcclosure(function(plr)
        oldHunger(plr, 200)
    end)
end
getgenv().enableInfiniteWarmth = function()
    integrityTable.setWarmth = newcclosure(function(plr)
        oldWarmth(plr, 5000)
    end)
end

getgenv().disableInfiniteHunger = function()
    integrityTable.setHunger = oldHunger
end
getgenv().disableInfiniteWarmth = function()
    integrityTable.setWarmth = oldWarmth
end
