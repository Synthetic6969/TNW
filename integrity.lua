local integrityTable, oldHunger, oldWarmth

for _, v in next, getgc(true) do
    if type(v) == "table" and rawget(v, "setHunger") and rawget(v, "setWarmth") then
        integrityTable = v
        oldHunger = v.setHunger
        oldWarmth = v.setWarmth
    end
end

getgenv().enableInfiniteHunger = function()
    v.setHunger = newcclosure(function(plr)
        oldHunger(plr, 200)
    end)
end
getgenv().enableInfiniteWarmth = function()
    v.setWarmth = newcclosure(function(plr)
        oldWarmth(plr, 5000)
    end)
end

getgenv().disableInfiniteHunger = function()
    v.setHunger = oldHunger
end
getgenv().disableInfiniteWarmth = function()
    v.setWarmth = oldWarmth
end
