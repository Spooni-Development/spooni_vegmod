Citizen.CreateThread(function()
    for _, v in pairs(Config.VegMods) do
        local vegFlag =  v.veg.flag
        local vegType = v.veg.type
        Citizen.InvokeNative(0xFA50F79257745E74, v.coords[1], v.coords[2], v.coords[3], v.radius, vegType, vegFlag, 0);
    end
end)