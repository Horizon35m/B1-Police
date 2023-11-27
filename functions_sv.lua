lib.addCommand('frisk', {
    help = 'Frisk nearest player',
    params = {},
    -- restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent('B1-Police:FriskPlayercl', source)
end)

RegisterNetEvent('B1-Police:FriskPlayersv', function(id)
	local _source = source
    local EmoteData = {
        Label = 'Leaning With Phone',
        Command = 'leanphone',
        Animation = 'idle_b',
        Dictionary = 'amb@world_human_stand_fire@male@idle_a',
        Options = {
            Flags = {
                Loop = false,
                move = false
            }
        }
    }
    
    TriggerClientEvent('scully_emotemenu:play', _source, EmoteData)

    lib.callback('B1-Police:GetItems', id, function(guns)
        if guns == true then
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'You feel something like a Gun', 'success')
        else
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'You feel nothing suspicious', 'error')
        end
    end)
end)




