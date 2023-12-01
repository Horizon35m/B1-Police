lib.addCommand('frisk', {
    help = 'Frisk nearest player',
    params = {},
    -- restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent('B1-Police:FriskPlayercl', source)
end)

RegisterNetEvent('B1-Police:RemoveItem', function(id, item, count)
    exports.ox_inventory:RemoveItem(id, item, count)
end)

RegisterNetEvent('B1-Police:FriskPlayersv', function(id, heading, loc, Coords)
	local _source = source
    if Config.EmoteResource == 'scully' then
        local CopEmoteData = {
            Label = 'Type 3',
            Command = 'type3',
            Animation = 'hack_loop',
            Dictionary = 'mp_prison_break',
            Options = {
                Flags = {
                    Loop = false,
                    move = false
                }
            }
        }
        
        local CrimEmoteData = {
            Label = 'Put your handsup',
            Command = 'handsup',
            Animation = 'handsup_base',
            Dictionary = 'missminuteman_1ig_2',
            Options = {
                Flags = {
                    Loop = false,
                    move = false
                }
            }
        }
        TriggerClientEvent('scully_emotemenu:play', _source, CopEmoteData)
        TriggerClientEvent('scully_emotemenu:play', id, CrimEmoteData)
    else
    end
    lib.callback('B1-Police:GetItems', id, function(guns)
        if guns == true then
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'You feel something like a Gun', 'success')
        else
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'You feel nothing suspicious', 'error')
        end
    end)
end)

RegisterNetEvent('B1-Police:CuffPlayersv', function(id, heading, loc, Coords, thing)
	local _source = source 
	local playerPed = GetPlayerPed(target)
	local arrestped = GetPlayerPed(source)
	local x, y, z   = table.unpack(Coords + loc * 1.0)
	SetEntityCoords(playerPed, x, y, z)
	SetEntityHeading(playerPed, heading)
    lib.callback('B1-Police:GetCuff', id, function(stats)
        if stats == 'cuffed' then
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are already Cuffed', 'error')
        elseif stats == 'zipped' then
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are already Zipped', 'error')
        else
            TriggerClientEvent('B1-Police:ArrestPlayer', _source, id, arrestped, thing)
            TriggerClientEvent('B1-Police:GetArrested', id, _source, arrestped, thing)
        end
    end)
end)




