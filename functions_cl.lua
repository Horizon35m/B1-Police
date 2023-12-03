local imCuffed = false
local imZipped = false
local isHardCuffed = false

local myCount = 0

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

function LoadDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function gettingArrested(cuffs, id)
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
	Wait(250)
	if myCount < 4 then
        local success = lib.skillCheck({'hard'}, {'e'})
        if success then
            Wait(500)
            ClearPedTasks(PlayerPedId())
            myCount = myCount + 1
            isHandcuffed = false
   		else
            myCount = 0
            Cuffed(cuffs, id)
   		end
   	else
        Wait(3000)
        myCount = 0
        Cuffed(cuffs, id)
   	end
end


function Cuffed(cuffs, id)
    if hardCuffed and cuffs == 'zip' then
        TriggerServerEvent('B1-Police:RemoveItem', id, 'Zipties', 2)
    elseif not hardCuffed and cuffs == 'zip' then
        TriggerServerEvent('B1-Police:RemoveItem', id, 'Zipties', 1)
    elseif hardCuffed and cuffs == 'cuff' then
        TriggerServerEvent('B1-Police:RemoveItem', id, 'Cuffs', 2)
    elseif not hardCuffed and cuffs == 'cuff' then
        TriggerServerEvent('B1-Police:RemoveItem', id, 'Cuffs', 1)
    end
    local coords = GetEntityCoords(PlayerPedId())
    while not HasModelLoaded('hei_prop_zip_tie_positioned') and HasModelLoaded('p_cs_cuffs_02_s') do Wait(0) end
    if hardCuffed then 
        if cuffs == 'zip' then
            object = CreateObject(RequestModel('hei_prop_zip_tie_positioned'),coords,true,false)
            AttachEntityToEntity(cuffObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        elseif cuffs == 'cuff' then
            object = CreateObject(RequestModel('p_cs_cuffs_02_s'),coords,true,false)
            AttachEntityToEntity(cuffObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        else
            TriggerEvent('B1-Police:Notify', 'Police', 'You should not see this lol', 'error')
        end
    else
        if cuffs == 'zip' then
            object = CreateObject(RequestModel('hei_prop_zip_tie_positioned'),coords,true,false)
            AttachEntityToEntity(cuffObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        elseif cuffs == 'cuff' then
            object = CreateObject(RequestModel('p_cs_cuffs_02_s'),coords,true,false)
            AttachEntityToEntity(cuffObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        else
            TriggerEvent('B1-Police:Notify', 'Police', 'You should not see this lol', 'error')
        end
    end
    LocalPlayer.state:set('invBusy', true, false)
    CreateThread(function()
        while isHandcuffed do
            Wait(0)
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 288, true) -- Phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 73, true) -- Clearing animation
			DisableControlAction(2, 199, true) -- Pause screen
			DisableControlAction(0, 59, true) -- Steering in vehicle
			DisableControlAction(2, 36, true) -- Stealth
			DisableControlAction(0, 47, true)  -- Weapon
			DisableControlAction(0, 257, true) -- Melee
			DisableControlAction(0, 140, true) -- Melee
			DisableControlAction(0, 264, true) -- Melee
			DisableControlAction(0, 141, true) -- Melee
			DisableControlAction(0, 142, true) -- Melee
			DisableControlAction(0, 143, true) -- Melee
            if hardCuffed then
                DisableControlAction(0, 32, true) -- W
                DisableControlAction(0, 34, true) -- A
                DisableControlAction(0, 31, true) -- S 
                DisableControlAction(0, 30, true) -- D 
                if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) ~= 1 then
                    if isDead == true then

                    else
                        if Config.EmoteResource == 'native' then
                            TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                        end
                    end
                end
            else
                if IsEntityPlayingAnim(PlayerPedId(), 'anim@move_m@prisoner_cuffed', 'idle', 3) ~= 1 then
                    if isDead == true then
                        ClearPedSecondaryTask(PlayerPedId())
                    else
                        if Config.EmoteResource == 'native' then
                            LoadDict('anim@move_m@prisoner_cuffed')
                            TaskPlayAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                        end
                    end
                end
            end
        end
    end)
end

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
    local cuffs = 'cuff'
    local count = exports.ox_inventory:Search('count', 'cuffs')
    if thing == 'hc' then
        if count > 1 then
            if id == nil then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    id = GetPlayerServerId(closestPlayer)
                    heading = GetEntityHeading(GetPlayerPed(-1))
                    loc = GetEntityForwardVector(PlayerPedId())
                    Coords = GetEntityCoords(GetPlayerPed(-1))
                    TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                end
            else
                heading = GetEntityHeading(GetPlayerPed(-1))
                loc = GetEntityForwardVector(PlayerPedId())
                Coords = GetEntityCoords(GetPlayerPed(-1))
                TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
            end
        else
            TriggerEvent('B1-Police:Notify', 'Police', 'You Dont have enough Cuffs!', 'error')
        end
    else
        if count > 0 then
            if id == nil then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    id = GetPlayerServerId(closestPlayer)
                    heading = GetEntityHeading(GetPlayerPed(-1))
                    loc = GetEntityForwardVector(PlayerPedId())
                    Coords = GetEntityCoords(GetPlayerPed(-1))
                    TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                end
            else
                heading = GetEntityHeading(GetPlayerPed(-1))
                loc = GetEntityForwardVector(PlayerPedId())
                Coords = GetEntityCoords(GetPlayerPed(-1))
                TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
            end
        else
            TriggerEvent('B1-Police:Notify', 'Police', 'You Dont have Cuffs!', 'error')
        end
    end
end)

RegisterNetEvent('B1-Police:ZipPlayercl', function(id, thing)
    local cuffs = 'zip'
    local count = exports.ox_inventory:Search('count', 'ziptie')
    if count > 0 then
        if thing == 'hc' and count < 2 then
            if id == nil then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    id = GetPlayerServerId(closestPlayer)
                    heading = GetEntityHeading(GetPlayerPed(-1))
                    loc = GetEntityForwardVector(PlayerPedId())
                    Coords = GetEntityCoords(GetPlayerPed(-1))
                    TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                end
            else
                heading = GetEntityHeading(GetPlayerPed(-1))
                loc = GetEntityForwardVector(PlayerPedId())
                Coords = GetEntityCoords(GetPlayerPed(-1))
                TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
            end
        else
            if id == nil then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    id = GetPlayerServerId(closestPlayer)
                    heading = GetEntityHeading(GetPlayerPed(-1))
                    loc = GetEntityForwardVector(PlayerPedId())
                    Coords = GetEntityCoords(GetPlayerPed(-1))
                    TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                end
            else
                heading = GetEntityHeading(GetPlayerPed(-1))
                loc = GetEntityForwardVector(PlayerPedId())
                Coords = GetEntityCoords(GetPlayerPed(-1))
                TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
            end
        end
    else
        TriggerEvent('B1-Police:Notify', 'Police', 'You Dont have Zipties!', 'error')
    end
end)

RegisterNetEvent('B1-Police:GetArrested', function(copid, copped, thing)
    if isCuffed == true then
        isHardCuffed
        ClearPedTasks(PlayerPedId())

    LoadDict()
    GetArrested()

end)