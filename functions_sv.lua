RegisterNetEvent('B1-Police:FriskPlayersv', function(id)
    lib.callback('B1-Police:GetItems', id, function(items)
        for _,v in pairs(items) do
            if v == Config.Guns then
                TriggerClientEvent(source, 'B1-Police:Notify', 'Police', 'You feel something like a Gun', 'success')
            else
                TriggerClientEvent(source, 'B1-Police:Notify', 'Police', 'You feel nothing suspicious', 'error')
            end
        end
    end)
end)