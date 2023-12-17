-- //ANCHOR - Mugshots Callbacks

ESX.RegisterServerCallback('B1-Police:GetWebhook', function(src,cb)
    cb(Config.Mugshotoptions.ScreenShotHook)
end)

-- //ANCHOR - Commands

lib.addCommand('cam', {
    help = 'Opens Camera Menu',
    params = {},
    -- restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent('B1-Police:CameraOpen', source)
end)

lib.addCommand('frisk', {
    help = 'Frisk nearest player',
    params = {},
    -- restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent('B1-Police:FriskPlayercl', source)
end)

lib.addCommand('cuff', {
    help = 'Frisk nearest player',
    params = {
        {
            name = 'cuff',
            type = 'string',
            help = 'Type of Cuff.',
            optional = true,
        },
    },
    -- restricted = 'group.admin'
}, function(source, args, raw)
    local id = nil
    local cuff = 'cuff'
    TriggerClientEvent('B1-Police:CuffPlayercl', source, id, args.cuff, cuff)
end)

lib.addCommand('ziptie', {
    help = 'Frisk nearest player',
    params = {
        {
            name = 'cuff',
            type = 'string',
            help = 'Type of Cuff.',
            optional = true,
        },
    },
    -- restricted = 'group.admin'
}, function(source, args, raw)
    local id = nil
    local cuff = 'zip'
    TriggerClientEvent('B1-Police:CuffPlayercl', source, id, args.cuff, cuff)
end)

-- //ANCHOR - Notify Net

RegisterNetEvent('B1-Police:NotifySV', function(id, header, desc, thing)
    TriggerClientEvent('B1-Police:Notify', id, header, desc, thing)
end)

-- //ANCHOR - Item Functions

RegisterNetEvent('B1-Police:RemoveItem', function(id, item, count)
    if id == nil then
        id = source
    end
    exports.ox_inventory:RemoveItem(id, item, count)
end)

RegisterNetEvent('B1-Police:AddItem', function(id, item, count)
    if id == nil then
        id = source
    end
    exports.ox_inventory:AddItem(id, item, count)
end)

-- //ANCHOR - Frisk Logic SV

RegisterNetEvent('B1-Police:FriskPlayersv', function(id, heading, loc, Coords)
	local _source = source
    TriggerClientEvent('B1-Police:Notify', id, 'Police', 'You are being Frisked!', 'error')
    lib.callback('B1-Police:GetItems', id, function(guns)
        if guns == true then
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'You feel something like a Gun', 'success')
        else
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'You feel nothing suspicious', 'error')
        end
    end)
end)

-- //ANCHOR - Cuff Logic SV

RegisterNetEvent('B1-Police:CuffPlayersv', function(id, heading, loc, Coords, thing, cuffs)
    local stuff = 'capture'
	local _source = source 
	local playerPed = GetPlayerPed(id)
	-- local arrestped = GetPlayerPed(source)
    lib.callback('B1-Police:GetCuff', id, function(stats)
        if stats == 'cuffed' then
            if thing == 'hc' then
                lib.callback('B1-Police:GetCuffType', id, function(stats)
                    if stats == 'hard' then
                        TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are already Hardcuffed', 'error')
                    else
                        local x, y, z   = table.unpack(Coords + loc * 1.0)
                        SetEntityCoords(playerPed, x, y, z)
                        SetEntityHeading(playerPed, heading)   
                        TriggerClientEvent('B1-Police:ArrestPlayer', _source, stuff)
                        TriggerClientEvent('B1-Police:GetArrested', id, _source, thing, cuffs)
                    end
                end)
            else
                TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are already Cuffed', 'error')
            end
        elseif stats == 'zipped' then
            if thing == 'hc' then
                lib.callback('B1-Police:GetCuffType', id, function(stats)
                    if stats == 'hard' then
                        TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are already Hardzipped', 'error')
                    else
                        local x, y, z   = table.unpack(Coords + loc * 1.0)
                        SetEntityCoords(playerPed, x, y, z)
                        SetEntityHeading(playerPed, heading)   
                        TriggerClientEvent('B1-Police:ArrestPlayer', _source, stuff)
                        TriggerClientEvent('B1-Police:GetArrested', id, _source, thing, cuffs)
                    end
                end)
            else
                TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are already Cuffed', 'error')
            end
        else
            local x, y, z   = table.unpack(Coords + loc * 1.0)
            SetEntityCoords(playerPed, x, y, z)
            SetEntityHeading(playerPed, heading)   
            TriggerClientEvent('B1-Police:ArrestPlayer', _source, stuff)
            TriggerClientEvent('B1-Police:GetArrested', id, _source, thing, cuffs)
        end
    end)
end)


RegisterNetEvent('B1-Police:UnCuffsv', function(id, thing, heading, loc, Coords)
    local stuff = 'release'
	local _source = source 
	local playerPed = GetPlayerPed(id)
	-- local arrestped = GetPlayerPed(source)
    lib.callback('B1-Police:GetCuff', id, function(stats)
        if stats == 'cuffed' then
            if thing == 'key' then
                local x, y, z   = table.unpack(Coords + loc * 1.0)
                cuffs = 'cuff'
                SetEntityCoords(playerPed, x, y, z)
                SetEntityHeading(playerPed, heading)   
                TriggerClientEvent('B1-Police:ArrestPlayer', _source, stuff)
                TriggerClientEvent('B1-Police:GetArrested', id, _source, nil, cuffs)
            elseif thing == 'cutters' then
                cuffs = 'cuff'
                lib.callback('B1-Police:GetCuffType', id, function(stats)
                    if stats == 'hard' then
                        local x, y, z   = table.unpack(Coords + loc * 1.0)
                        SetEntityCoords(playerPed, x, y, z)
                        SetEntityHeading(playerPed, heading)
                        TriggerClientEvent('B1-Police:ArrestPlayer', _source, stuff)
                        TriggerClientEvent('B1-Police:GetUnShackled', id, cuffs)
                    else
                        TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are not Shackled!', 'error')
                    end
                end)
            elseif thing == 'pliers' then
                TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are not Tied', 'error')
            end
        elseif stats == 'zipped' then
            if thing == 'key' then
                TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are not Cuffed', 'error')
            elseif thing == 'cutters' then
                TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are not Cuffed', 'error')
            elseif thing == 'pliers' then
                local x, y, z   = table.unpack(Coords + loc * 1.0)
                cuffs = 'zip'
                SetEntityCoords(playerPed, x, y, z)
                SetEntityHeading(playerPed, heading)   
                TriggerClientEvent('B1-Police:ArrestPlayer', _source, stuff)
                TriggerClientEvent('B1-Police:GetArrested', id, _source, nil, cuffs)
            end
        else
            TriggerClientEvent('B1-Police:Notify', _source, 'Police', 'They are not Bound!', 'error')
        end
    end)
end)

-- //ANCHOR - MugShot Logic

RegisterNetEvent("B1-Police:TakeMugshotSV", function(location, suspect, policeNotes)
    print(location..'SV')
    print(suspect..'SV')
    print(policeNotes..'SV')
    if suspect == nil then
        TriggerClientEvent('B1-Police:Notify', source, 'Police', 'Nobody selected!', 'error')
    else
        TriggerClientEvent('B1-Police:TakeMugshotCL', suspect, source, location, policeNotes)
    end
end)

RegisterNetEvent("B1-Police:MugLog", function(officer, MugShot, policeNotes)
    print('mug')
    local Suspect = ESX.GetPlayerFromId(source)
    local Police =  ESX.GetPlayerFromId(officer)
    local suspectName = Suspect.variables.firstName .. ' ' .. Suspect.variables.lastName
    local suspectDOB = Suspect.variables.dateofbirth
    local policeName = Police.variables.firstName .. ' ' .. Police.variables.lastName 
    local embedData = {
        {
            ['title'] = Config.Mugshotoptions.LogTitle,
            ['color'] = 16761035,
            ['footer'] = {
                ['text'] = os.date( "!%a %b %d, %H:%M", os.time() + 6 * 60 * 60 ),
            },
            ['fields'] = {
                {['name'] = "Suspect:", ['value'] = "```" .. suspectName .. "```", ['inline'] = false},
                {['name'] = "Date Of Birth:", ['value'] = "```" .. suspectDOB .. "```", ['inline'] = false},
                {['name'] = "Officer:", ['value'] = "```" .. policeName .. "```", ['inline'] = false},
                {['name'] = "Officer Notes:", ['value'] = "```" .. policeNotes .. "```", ['inline'] = false},
            },
            ['image'] = {
                ['url'] = MugShot,
            },
            ['author'] = {
                ['name'] = Config.Mugshotoptions.LogName,
                ['icon_url'] = Config.Mugshotoptions.LogIcon,
            },
        }
    }
    PerformHttpRequest(Config.Mugshotoptions.MugShotHook, function() end, 'POST', json.encode({ username = Config.Mugshotoptions.LogName, embeds = embedData}), { ['Content-Type'] = 'application/json' })
end)


RegisterCommand('testdatasv', function(source)
    local PlayerData = ESX.GetPlayerFromId(source)
    local dumpedTable = ESX.DumpTable(PlayerData)
    print(dumpedTable)
end)

