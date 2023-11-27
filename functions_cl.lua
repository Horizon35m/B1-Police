local imCuffed = false
local imZipped = false
local isHardCuffed = false

lib.callback.register('B1-Police:GetItems', function()
    local guns
    for _,v in pairs(Config.Guns) do
        local count = exports.ox_inventory:Search('count', v)
        if count > 0 then
            print("^3DEBUG: ^0Checked for weapon. Returned (true).")
            guns = true
            return guns
        end
    end

    print("^3DEBUG: ^0Checked for weapon. Returned (false).")
    guns = false
    return guns
end)

lib.callback.register('B1-Police:GetCuff', function()
    local stats
    if imCuffed == true then
        stats = 'cuffed'
    elseif imZipped == true then
        stats = 'zipped' 
    else
        stats = nil
    end
    return stats
end)

lib.callback.register('B1-Police:GetCuffType', function()
    local stats
    if isHardCuffed == true then
        stats = 'hard'
    else
        stats = nil
    end
    return stats
end)

RegisterNetEvent('B1-Police:Notify', function(header, desc, thing)
    if Config.Notify == 'ox' then
        lib.notify({
            title = header,
            description = desc,
            type = thing
        })
    else

    end
end)

RegisterNetEvent('B1-Police:FriskPlayercl', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        id = GetPlayerServerId(closestPlayer)
        TriggerServerEvent('B1-Police:FriskPlayersv', id)
    else
        TriggerEvent('B1-Police:Notify', 'Police', 'Nobody nearby!', 'error')
    end
end)



RegisterNetEvent('B1-Police:CuffPlayercl', function(id, thing)
    local count = exports.ox_inventory:Search('count', 'cuffs')
    if count > 0 then
        if id == nil then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                id = GetPlayerServerId(closestPlayer)
                TriggerServerEvent('B1-Police:ZipPlayersv', id, thing)
            end
        else
            TriggerServerEvent('B1-Police:CuffPlayersv', id, thing)
        end
    else
        TriggerEvent('B1-Police:Notify', 'Police', 'You Dont have Cuffs!', 'error')
    end
end)

RegisterNetEvent('B1-Police:ZipPlayercl', function(id, thing)
    local count = exports.ox_inventory:Search('count', 'ziptie')
    if count > 0 then
        if thing == 'hc' and count < 2 then
            if id == nil then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    id = GetPlayerServerId(closestPlayer)
                    TriggerServerEvent('B1-Police:ZipPlayersv', id, thing)
                end
            else
                TriggerServerEvent('B1-Police:ZipPlayersv', id, thing)
            end
        else
            if id == nil then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    id = GetPlayerServerId(closestPlayer)
                    TriggerServerEvent('B1-Police:ZipPlayersv', id, thing)
                end
            else
                TriggerServerEvent('B1-Police:ZipPlayersv', id, thing)
            end
        end
    else
        TriggerEvent('B1-Police:Notify', 'Police', 'You Dont have Zipties!', 'error')
    end
end)
