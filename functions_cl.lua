local imCuffed = false
local imZipped = false
local isHardCuffed = false

lib.callback.register('B1-Police:GetItems', function()
    local items = exports.ox_inventory:GetPlayerItems()
    return items
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

RegisterNetEvent('B1-Police:FriskPlayercl', function(id)
    if id == nil then
        id = lib.getClosestPlayer(GetEntityCoords(PlayerPedId()),2,false)
        TriggerServerEvent('B1-Police:FriskPlayersv', id.playerId)
    else
        TriggerServerEvent('B1-Police:FriskPlayersv', id)
    end
end)

RegisterNetEvent('B1-Police:CuffPlayercl', function(id, item, thing)
    if id == nil then
        id = lib.getClosestPlayer(GetEntityCoords(PlayerPedId()),2,false)
        if item == 'cuffs'
            if thing == 'sc'

            else

            end
        else
            if thing == 'sc'

            else

            end
        end
    else
        if item == 'zip'
            if thing == 'sc'

            else

            end
        else
            if thing == 'sc'

            else

            end
        end
    end
end)