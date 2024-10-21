local VegZones = {}

local function Debug(...)
    if Config.DevMode then
        print(...)
    end
end

local function AddVegModifierSphere(...)
	return Citizen.InvokeNative(0xFA50F79257745E74,...)
end

local function RemoveVegModifierSphere(veg_modifier_sphere,p1)
	return Citizen.InvokeNative(0x9CF1836C03FB67A2,Citizen.PointerValueIntInitialized(veg_modifier_sphere), p1)
end

local function CreateZone(...)
    local zones = {...}

    for _, zone in ipairs(zones) do
        table.insert(Config.VegZones, zone)
    end
end

exports('CreateZone', CreateZone)

if #Config.VegZones > 0 then
    Citizen.CreateThread(function()
        while true do
            local pedCoords = GetEntityCoords(PlayerPedId())
            local activeZones = {}

            for k, v in pairs(Config.VegZones) do
                local dist = #(pedCoords - v.coords)

                if dist <= v.distance then
                    if not VegZones[k] then
                        VegZones[k] = AddVegModifierSphere(v.coords[1], v.coords[2], v.coords[3], v.radius, v.vegmod.flag, v.vegmod.type, 0)
                    end
                    activeZones[k] = true
                end
            end

            for k, v in pairs(VegZones) do
                if not activeZones[k] then
                    Debug(VegZones[k])
                    Debug(Citizen.PointerValueIntInitialized(VegZones[k]))
                    RemoveVegModifierSphere(VegZones[k], 0)
                    VegZones[k] = nil
                end
            end

            Citizen.Wait(1000)
        end
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end

    for k, v in pairs(VegZones) do
        Debug('All vegetation modifiers have been removed')
        RemoveVegModifierSphere(VegZones[k], 0)
    end
end)
