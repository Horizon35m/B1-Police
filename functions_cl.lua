
-- Camera Logic Variables
local cameraActive = false
local currentCameraIndex = 0
local currentCameraIndexIndex = 0
local createdCamera = 0
local inCam = false

-- Mugshots Logic Variables
local InMugshot = false

-- Cuff Logic variables
local imCuffed = false
local imZipped = false
local isHardCuffed = false

-- Cuff Count
local myCount = 0

-- Carry Logic Variables
local IsEscorting = false
local IsCarrying = false
local IsDragging = false
local InAnim = false
local IsAttached = false

-- //ANCHOR - Client Callbacks

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

-- //ANCHOR - Load func

function LoadModel(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(0)
    end
end

function LoadScale(scalef)
	local handle = RequestScaleformMovie(scalef)
    while not HasScaleformMovieLoaded(handle) do
        Wait(0)
    end
	return handle
end

function CreateRenderModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
	return handle
end

-- //ANCHOR - Animation Logic func CL

function LoadDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

-- //ANCHOR - Getting Arrested Logic Func CL

function gettingArrested(id, thing, cuffs)
    SetCurrentPedWeapon(PlayerPedId(-1), GetHashKey('WEAPON_UNARMED'), true)
	Wait(250)
	LoadDict('mp_arrest_paired')
	TaskPlayAnim(playerPed, 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	if myCount < Config.MaxCuffBreaks then
        local success = lib.skillCheck({'hard'}, {'e'})
        if success then
            Wait(500)
            ClearPedTasks(PlayerPedId(-1))
            myCount = myCount + 1
   		else
            myCount = 0
            if cuffs == 'zip' then
                imZipped = true
                if thing == 'hc' then
                    isHardCuffed = true
                    TriggerServerEvent('B1-Police:RemoveItem', id, 'ziptie', 2)
                else
                    TriggerServerEvent('B1-Police:RemoveItem', id, 'ziptie', 1)
                end
                Cuffed(cuffs)
            elseif cuffs == 'cuff' then
                imCuffed = true
                if thing == 'hc' then
                    isHardCuffed = true
                    TriggerServerEvent('B1-Police:RemoveItem', id, 'Cuffs', 2)
                else
                    TriggerServerEvent('B1-Police:RemoveItem', id, 'Cuffs', 1)
                end
                Cuffed(cuffs)
            end
   		end
   	else
        Wait(3000)
        myCount = 0
        if cuffs == 'zip' then
            imZipped = true
            if thing == 'hc' then
                isHardCuffed = true
                TriggerServerEvent('B1-Police:RemoveItem', id, 'Zipties', 2)
                Cuffed(cuffs)
            else
                TriggerServerEvent('B1-Police:RemoveItem', id, 'Zipties', 1)
                Cuffed(cuffs)
            end
        elseif cuffs == 'cuff' then
            imCuffed = true
            if thing == 'hc' then
                isHardCuffed = true
                TriggerServerEvent('B1-Police:RemoveItem', id, 'Cuffs', 2)
                Cuffed(cuffs)
            else
                TriggerServerEvent('B1-Police:RemoveItem', id, 'Cuffs', 1)
                Cuffed(cuffs)
            end
        end
   	end
end

function Cuffed(cuffs)
    local coords = GetEntityCoords(PlayerPedId(-1))
    LoadModel('p_cs_cuffs_02_s')
    LoadModel('ba_prop_battle_cuffs')
    if isHardCuffed then
        if cuffs == 'zip' then
            object = CreateObject('ba_prop_battle_cuffs',coords,true,false)
            AttachEntityToEntity(object, PlayerPedId(-1), GetPedBoneIndex(PlayerPedId(-1), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        elseif cuffs == 'cuff' then
            object = CreateObject('p_cs_cuffs_02_s',coords,true,false)
            AttachEntityToEntity(object, PlayerPedId(-1), GetPedBoneIndex(PlayerPedId(-1), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        else
            TriggerEvent('B1-Police:Notify', 'Police', 'You should not see this lol', 'error')
        end
    else
        if cuffs == 'zip' then
            object = CreateObject('ba_prop_battle_cuffs',coords,true,false)
            AttachEntityToEntity(object, PlayerPedId(-1), GetPedBoneIndex(PlayerPedId(-1), 60309), -0.058, 0.005, 0.090, 290.0, 95.0, 120.0, true, false, false, false, 0, true)
        elseif cuffs == 'cuff' then
            object = CreateObject('p_cs_cuffs_02_s',coords,true,false)
            AttachEntityToEntity(object, PlayerPedId(-1), GetPedBoneIndex(PlayerPedId(-1), 60309), -0.058, 0.005, 0.090, 290.0, 95.0, 120.0, true, false, false, false, 0, true)
        else
            TriggerEvent('B1-Police:Notify', 'Police', 'You should not see this lol', 'error')
        end
    end
    LocalPlayer.state:set('invBusy', true, false)
    CreateThread(function()
        while imCuffed or imZipped do
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
            if isHardCuffed then
                DisableControlAction(0, 32, true) -- W
                DisableControlAction(0, 34, true) -- A
                DisableControlAction(0, 31, true) -- S 
                DisableControlAction(0, 30, true) -- D 
                if IsEntityPlayingAnim(PlayerPedId(-1), 'mp_arresting', 'idle', 3) ~= 1 then
                    if isDead == true then

                    else
                        if Config.EmoteResource == 'native' then
                            LoadDict('anim@move_m@prisoner_cuffed')
                            TaskPlayAnim(PlayerPedId(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                        end
                    end
                end
            else
                if IsEntityPlayingAnim(PlayerPedId(-1), 'anim@move_m@prisoner_cuffed', 'idle', 3) ~= 1 then
                    if isDead == true then
                        ClearPedSecondaryTask(PlayerPedId(-1))
                    else
                        LoadDict('anim@move_m@prisoner_cuffed')
                        TaskPlayAnim(PlayerPedId(-1), 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                        -- if Config.EmoteResource == 'native' then
                        --     LoadDict('anim@move_m@prisoner_cuffed')
                        --     TaskPlayAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                        -- end
                    end
                end
            end
        end
    end)
end

-- //ANCHOR - Camera Logic Func

function HandleCameraEvent(cameraId)
    print(cameraId)
    local cameras = Config.SecurityCams[cameraId]
    if cameras == nil then
        print('no camera')
        return
    end
    DoScreenFadeOut(250)
    while not IsScreenFadedOut() do Wait(0) end
    local firstCamx = Config.SecurityCams[cameraId].cameras[1].coords.x
    local firstCamy = Config.SecurityCams[cameraId].cameras[1].coords.y
    local firstCamz = Config.SecurityCams[cameraId].cameras[1].coords.z
    local firstCamr = Config.SecurityCams[cameraId].cameras[1].rotation
    SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
    ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)
    currentCameraIndex = cameraId
    currentCameraIndexIndex = 1
    DoScreenFadeIn(250)
	local PlayerPed = PlayerPedId()
	if cameraId == 0 then
        FreezeEntityPosition(PlayerPed, false)
        ClearPedTasks(PlayerPedId(-1))
    else
        FreezeEntityPosition(PlayerPed, true)
        TaskStartScenarioInPlace(PlayerPedId(-1), 'WORLD_HUMAN_STAND_MOBILE')
    end
end

function ChangeSecurityCamera(x, y, z, rotation)
    if createdCamera ~= 0 then DestroyCam(createdCamera, 0) createdCamera = 0 end
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, x, y, z)
    SetCamRot(cam, rotation.x, rotation.y, rotation.z, 2)
    RenderScriptCams(1, 0, 0, 1, 1)
    Wait(250)
    createdCamera = cam
end

function CloseSecurityCamera()
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
end

function InstructionButton(ControlButton) N_0xe83a3e3557a56640(ControlButton) end

function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function CreateInstuctionScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do Wait(0) end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    InstructionButton(GetControlInstructionalButton(1, 175, true))
    InstructionButtonMessage("Next Camera")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage("Close Camera")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    InstructionButton(GetControlInstructionalButton(1, 174, true))
    InstructionButtonMessage("Previous Camera")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

-- //ANCHOR - Camera Logic Thread 

CreateThread(function()
    while true do
        if createdCamera ~= 0 then
            local instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(2.0)
            -- CLOSE CAMERAS
            if IsControlJustPressed(1, 177) then
                DoScreenFadeOut(250)
                while not IsScreenFadedOut() do Wait(0) end
                CloseSecurityCamera()
                SendNUIMessage({ type = "disablecam", })
                DoScreenFadeIn(250)
				local PlayerPed = PlayerPedId()
				FreezeEntityPosition(PlayerPed, false)
                ClearPedTasks(PlayerPedId(-1))
            end
            -- GO BACK CAMERA
            if IsControlJustPressed(1, 174) then
                local newCamIndex

                if currentCameraIndexIndex == 1 then
                    newCamIndex = #Config.SecurityCams[currentCameraIndex].cameras 
                else
                    newCamIndex = currentCameraIndexIndex - 1
                end

                local newCamx = Config.SecurityCams[currentCameraIndex].cameras[newCamIndex].coords.x
                local newCamy = Config.SecurityCams[currentCameraIndex].cameras[newCamIndex].coords.y
                local newCamz = Config.SecurityCams[currentCameraIndex].cameras[newCamIndex].coords.z
                local newCamr = Config.SecurityCams[currentCameraIndex].cameras[newCamIndex].rotation
                SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)
                ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
                currentCameraIndexIndex = newCamIndex
            end
            -- GO FORWARD CAMERA
            if IsControlJustPressed(1, 175) then
                local newCamIndex
                print(currentCameraIndexIndex)
                if currentCameraIndexIndex == #Config.SecurityCams[currentCameraIndex].cameras then
                    newCamIndex = 1
                else
                    newCamIndex = currentCameraIndexIndex + 1
                end

                local newCamx = Config.SecurityCams[currentCameraIndex].cameras[newCamIndex].coords.x
                local newCamy = Config.SecurityCams[currentCameraIndex].cameras[newCamIndex].coords.y
                local newCamz = Config.SecurityCams[currentCameraIndex].cameras[newCamIndex].coords.z
                local newCamr = Config.SecurityCams[currentCameraIndex].cameras[newCamIndex].rotation
                SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)
                ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
                currentCameraIndexIndex = newCamIndex
            end
        end
        Wait(0)
    end
end)

-- //ANCHOR - Carry Logic func

function BeingEscorted()
    CreateThread(function()
        while IsAttached do
            Wait(0)
            local speed = GetEntitySpeed(PlayerPedId())
            if speed > 1 then
                if IsEntityPlayingAnim(PlayerPedId(), 'move_m@generic_variations@walk', 'walk_b', 3) ~= 1 then
                    TaskPlayAnim(PlayerPedId(), 'move_m@generic_variations@walk','walk_b' ,8.0, -8, -1, 0, 0, false, false, false)
                end
            end
        end
    end)
end

-- //ANCHOR - Notify Logic Net

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

-- //ANCHOR - Frisk Logic Net CL

RegisterNetEvent('B1-Police:FriskPlayercl', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        id = GetPlayerServerId(closestPlayer)
        TriggerServerEvent('B1-Police:FriskPlayersv', id)
    else
        TriggerEvent('B1-Police:Notify', 'Police', 'Nobody nearby!', 'error')
    end
end)

-- //ANCHOR - Cuff Logic Net CL

RegisterNetEvent('B1-Police:CuffPlayercl', function(id, thing, cuffs)
    if cuffs == 'cuff' then
        local count = exports.ox_inventory:Search('count', 'cuffs')
        if thing == 'hc' then
            if count > 1 then
                if id == nil then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        id = GetPlayerServerId(closestPlayer)
                        heading = GetEntityHeading(PlayerPedId())
                        loc = GetEntityForwardVector(PlayerPedId(-1))
                        Coords = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                    end
                else
                    heading = GetEntityHeading(PlayerPedId())
                    loc = GetEntityForwardVector(PlayerPedId(-1))
                    Coords = GetEntityCoords(PlayerPedId())
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
                        heading = GetEntityHeading(PlayerPedId())
                        loc = GetEntityForwardVector(PlayerPedId(-1))
                        Coords = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                    end
                else
                    heading = GetEntityHeading(PlayerPedId())
                    loc = GetEntityForwardVector(PlayerPedId(-1))
                    Coords = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                end
            else
                TriggerEvent('B1-Police:Notify', 'Police', 'You Dont have Cuffs!', 'error')
            end
        end
    elseif cuffs == 'zip' then
        local count = exports.ox_inventory:Search('count', 'ziptie')
        if count > 0 then
            if thing == 'hc' and count < 2 then
                if id == nil then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        id = GetPlayerServerId(closestPlayer)
                        heading = GetEntityHeading(PlayerPedId(-1))
                        loc = GetEntityForwardVector(PlayerPedId(-1))
                        Coords = GetEntityCoords(PlayerPedId(-1))
                        TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                    end
                else
                    heading = GetEntityHeading(PlayerPedId(-1))
                    loc = GetEntityForwardVector(PlayerPedId(-1))
                    Coords = GetEntityCoords(PlayerPedId(-1))
                    TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                end
            else
                if id == nil then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        id = GetPlayerServerId(closestPlayer)
                        heading = GetEntityHeading(PlayerPedId(-1))
                        loc = GetEntityForwardVector(PlayerPedId(-1))
                        Coords = GetEntityCoords(PlayerPedId(-1))
                        TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                    end
                else
                    heading = GetEntityHeading(PlayerPedId(-1))
                    loc = GetEntityForwardVector(PlayerPedId(-1))
                    Coords = GetEntityCoords(PlayerPedId(-1))
                    TriggerServerEvent('B1-Police:CuffPlayersv', id, heading, loc, Coords, thing, cuffs)
                end
            end
        else
            TriggerEvent('B1-Police:Notify', 'Police', 'You Dont have Zipties!', 'error')
        end
    else
        TriggerEvent('B1-Police:Notify', 'Police', 'You Should not see this!', 'error')
    end
end)

RegisterNetEvent('B1-Police:UnCuff', function(id, thing)
    if id == nil then
        TriggerEvent('B1-Police:Notify', 'Police', 'You Should not see this!', 'error')
    else
        if thing == 'cuffkey' then
            heading = GetEntityHeading(PlayerPedId(-1))
            loc = GetEntityForwardVector(PlayerPedId(-1))
            Coords = GetEntityCoords(PlayerPedId(-1))
            thing = 'key'
            TriggerServerEvent('B1-Police:UnCuffsv', id, thing, heading, loc, Coords)
        elseif thing == 'hmkey' then
            local success = lib.skillCheck({'hard'}, {'e'})
            if success then
                heading = GetEntityHeading(PlayerPedId(-1))
                loc = GetEntityForwardVector(PlayerPedId(-1))
                Coords = GetEntityCoords(PlayerPedId(-1))
                thing = 'key'
                TriggerServerEvent('B1-Police:UnCuffsv', id, thing, heading, loc, Coords)
            else
                TriggerEvent('B1-Police:Notify', 'Police', 'Finger game bad!', 'error')
            end
        elseif thing == 'cutters' then
            local success = lib.skillCheck({'medium'}, {'e'})
            if success then
                heading = GetEntityHeading(PlayerPedId(-1))
                loc = GetEntityForwardVector(PlayerPedId(-1))
                Coords = GetEntityCoords(PlayerPedId(-1))
                TriggerServerEvent('B1-Police:UnCuffsv', id, thing, heading, loc, Coords)
            else
                TriggerEvent('B1-Police:Notify', 'Police', 'Finger game bad!', 'error')
            end
        elseif thing == 'pliers' then
            heading = GetEntityHeading(PlayerPedId(-1))
            loc = GetEntityForwardVector(PlayerPedId(-1))
            Coords = GetEntityCoords(PlayerPedId(-1))
            TriggerServerEvent('B1-Police:UnCuffsv', id, thing, heading, loc, Coords)
        end
    end
end)

RegisterNetEvent('B1-Police:GetUnShackled', function(cuffs)
    ClearPedTasks(PlayerPedId(-1))
    ClearPedSecondaryTask(PlayerPedId(-1))
    DeleteEntity(object)
    isHardCuffed = false
    Cuffed(cuffs)
end)

-- //ANCHOR - Arresting Logic Net CL

RegisterNetEvent('B1-Police:ArrestPlayer', function(stuff)
    if stuff == 'release' then
        LoadDict('mp_arresting')
        TaskPlayAnim(PlayerPedId(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
        Wait(5500)
        ClearPedTasks(PlayerPedId(-1))
    else
	    LoadDict('mp_arrest_paired')
	    TaskPlayAnim(PlayerPedId(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
    end
end)

RegisterNetEvent('B1-Police:GetArrested', function(copid, thing, cuffs)
    if imCuffed then
        if isHardCuffed then
            isHardCuffed = false
            TriggerServerEvent('B1-Police:AddItem', copid, 'cuffs', 2)
        else
            TriggerServerEvent('B1-Police:AddItem', copid, 'cuffs', 1)
        end
        imCuffed = false
		LoadDict('mp_arresting')
		TaskPlayAnim(PlayerPedId(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
		Wait(2000)
        Wait(100)
		ClearPedTasks(PlayerPedId(-1))
        ClearPedSecondaryTask(PlayerPedId(-1))
        DeleteEntity(object)
        LocalPlayer.state:set('invBusy', false, false)
    elseif imZipped then
        if isHardCuffed then
            isHardCuffed = false
        end
        imZipped = false
		LoadDict('mp_arresting')
		TaskPlayAnim(PlayerPedId(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
		Wait(2000)
        Wait(100)
		ClearPedTasks(PlayerPedId(-1))
        ClearPedSecondaryTask(PlayerPedId(-1))
        DeleteEntity(object)
        LocalPlayer.state:set('invBusy', false, false)
    else
        gettingArrested(copid, thing, cuffs)
    end
end)

-- //ANCHOR - Mugshot Logic
RegisterNetEvent("B1-Police:FillBoard", function(location)
    local input = lib.inputDialog('MugShot', {
        {type = 'number', label = 'Citizen ID', description = 'The Server ID of the person being arrested.', icon = 'hashtag'},
        {type = 'textarea', label = 'Mugshot Notes', description = 'Any notes for the mugshot.', placeholder = 'Has a Big scar on his left check.'}

    })
    if not input then return end
    print(json.encode(input), input[1], input[2])
    TriggerServerEvent('B1-Police:TakeMugshotSV', location, input[1], input[2])
end)

RegisterNetEvent("B1-Police:TakeMugshotCL", function(officer, location, policeNotes)
	local PlayerPed = PlayerPedId()
	local SuspectCoods = GetEntityCoords(PlayerPed)
    local mug = Config.Mugshotsloc[location].mugshot.pos
    local distance = Vdist(mug.x, mug.y, mug.z, SuspectCoods.x, SuspectCoods.y, SuspectCoods.z)
    if distance < 3 then
        InMugshot = true
        local PlayerData = ESX.GetPlayerData()
        local Name = PlayerData.firstName.. " ".. PlayerData.lastName
        local Sex = PlayerData.sex
        local DOB = PlayerData.dateofbirth    
        local ScaleformBoard = LoadScale("mugshot_board_01")
        local RenderHandle = CreateRenderModel("ID_Text", "prop_police_id_text")
        CreateThread(function()
            while RenderHandle do
                HideHudAndRadarThisFrame()
                SetTextRenderId(RenderHandle)
                Set_2dLayer(4)
                SetScriptGfxDrawBehindPausemenu(1)
                DrawScaleformMovie(ScaleformBoard, 0.405, 0.37, 0.81, 0.74, 255, 255, 255, 255, 0)
                SetScriptGfxDrawBehindPausemenu(0)
                SetTextRenderId(GetDefaultScriptRendertargetRenderId())
                SetScriptGfxDrawBehindPausemenu(1)
                SetScriptGfxDrawBehindPausemenu(0)
                Wait(0)
            end
        end)
        Wait(250)
        BeginScaleformMovieMethod(ScaleformBoard, 'SET_BOARD')
        PushScaleformMovieMethodParameterString(Config.Mugshotsloc[location].BoardHeader)
        PushScaleformMovieMethodParameterString(Name)
        PushScaleformMovieMethodParameterString(DOB)
        PushScaleformMovieMethodParameterString(Sex)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(math.random(000, 999))
        PushScaleformMovieFunctionParameterInt(116)
        EndScaleformMovieMethod()
        local MugCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(MugCam, Config.Mugshotsloc[location].camera.pos)
        SetCamRot(MugCam, Config.Mugshotsloc[location].camera.rotation.x, Config.Mugshotsloc[location].camera.rotation.y, Config.Mugshotsloc[location].camera.rotation.z, 2)
        RenderScriptCams(1, 0, 0, 1, 1)
        Wait(250)
        CreateThread(function()
            FreezeEntityPosition(PlayerPed, true)
            SetPauseMenuActive(false)
            while InMugshot do
                DisableAllControlActions(0)
                EnableControlAction(0, 249, true)
                EnableControlAction(0, 46, true)
                Wait(0)
            end
        end)
        SetEntityCoords(PlayerPed, mug.x, mug.y, mug.z)
        SetEntityHeading(PlayerPed, Config.Mugshotsloc[location].mugshot.rotation)
        LoadModel("prop_police_id_board")
        LoadModel("prop_police_id_text")
        local Board = CreateObject("prop_police_id_board", SuspectCoods, true, true, false)
        local BoardOverlay = CreateObject("prop_police_id_text", SuspectCoods, true, true, false)
        AttachEntityToEntity(BoardOverlay, Board, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        SetModelAsNoLongerNeeded("prop_police_id_board")
        SetModelAsNoLongerNeeded("prop_police_id_text")
        SetCurrentPedWeapon(PlayerPed, "weapon_unarmed", 1)
        ClearPedWetness(PlayerPed)
        ClearPedBloodDamage(PlayerPed)
        AttachEntityToEntity(Board, PlayerPed, GetPedBoneIndex(PlayerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)	
        LoadDict("mp_character_creation@lineup@male_a")
        TaskPlayAnim(PlayerPed, "mp_character_creation@lineup@male_a", "loop_raised", 8.0, 8.0, -1, 49, 0, false, false, false)
        Wait(1000)

        ESX.TriggerServerCallback('B1-Police:GetWebhook', function(cb)
            if cb then
                exports['screenshot-basic']:requestScreenshotUpload(tostring(cb), 'files[]', {encoding = 'jpg'}, function(data)
                    local Response = json.decode(data)
                    local imageURL = Response.attachments[1].url
                    TriggerServerEvent('B1-Police:MugLog', officer, imageURL, policeNotes)
                end)
            end
        end)
        Wait(5000)
        DestroyCam(MugCam, 0)
        RenderScriptCams(0, 0, 1, 1, 1)
        SetFocusEntity(PlayerPed)
        ClearPedTasksImmediately(PlayerPed)
        FreezeEntityPosition(PlayerPed, false)
        DeleteObject(Board)
        DeleteObject(BoardOverlay)
        RenderHandle = nil
        InMugshot = false
    else
        TriggerServerEvent('B1-Police:NotifySV', officer, 'Police', 'They are not in the MugShot room!', 'error')
    end
end)

-- //ANCHOR - Put in Car Logic

RegisterNetEvent('B1-Police:PutinCarCL', function(id, veh)
    if id == nil then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            Coords = GetEntityCoords(PlayerPedId())
            local id = GetPlayerServerId(closestPlayer)
            TriggerServerEvent('B1-Police:PutinCarSV', id, veh)
        else
            TriggerEvent('B1-Police:Notify', "Police", "Nobody in range.", "error")
        end
    else
        TriggerServerEvent('B1-Police:PutinCarSV', id, veh)
    end
end)

RegisterNetEvent('B1-Police:GetinCar', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local vehicle, vehicleCoords = lib.getClosestVehicle(playerCoords, 3, false)
    if not vehicle then
        lib.notify({
            title = 'Seats',
            description = 'No free seats!',
            type = 'error'
        })
    end
    local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
    for i = maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle, i) then
            freeSeat = i
            break
        end
    end
    if freeSeat then
        TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
        player.isDragged = false
    end
end)

RegisterNetEvent('B1-Police:TakeoutCar', function()
    local coords = GetEntityCoords(PlayerPedId())
    local target = lib.getClosestPlayer(coords, 3, false)
    if not target then return end
    local targetServerId = GetPlayerServerId(target)
    TriggerServerEvent('B1-Police:PutoutVehicleSV', targetServerId)
end)

RegisterNetEvent('B1-Police:PutoutVehicleCl', function()
    local playerPed = cache.ped
    local playerVehicle = cache.vehicle
    if not playerVehicle then return end
    TaskLeaveVehicle(playerPed, playerVehicle, 0)
end)

-- //ANCHOR - Escort & Carry Logic

RegisterNetEvent('B1-Police:CarryPlayerCL', function(id, state)
    if IsCarrying or IsEscorting or IsDragging then
        TriggerEvent('B1-Police:Notify', "General", "Already Carrying someone.", "error")
    else
        if id == nil then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                Coords = GetEntityCoords(PlayerPedId())
                local id = GetPlayerServerId(closestPlayer)
            else
                TriggerEvent('B1-Police:Notify', "Police", "Nobody in range.", "error")
            end
        else
            TriggerServerEvent('B1-Police:AttachPlayer', id, state)
        end
    end
end)

RegisterNetEvent('B1-Police:DoAnim', function(id, state)
    if InAnim then
        ClearPedTasks(PlayerPedId())
        IsEscorting = false
        IsCarrying = false
        IsDragging = false
        InAnim = false
    elseif state == 'escort' then
        IsEscorting = true
        InAnim = true
        LoadAnimDict('amb@world_human_drinking@coffee@male@base')
        if IsEntityPlayingAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base', 3) ~= 1 then
            TaskPlayAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base' ,8.0, -8, -1, 51, 0, false, false, false)
        end
    elseif state == 'carry' then
        IsCarrying = true
        InAnim = true
        LoadAnimDict('missfinale_c2mcs_1')
        TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
    elseif state == 'drag' then
        IsDragging = true
        InAnim = true
    end
end)

RegisterNetEvent('B1-Police:GetCarried', function(state, sourcePed)
    if IsAttached then
        IsAttached = false
        DetachEntity(PlayerPedId())
        ClearPedTasks(PlayerPedId())
    else
        if state == 'escort' then
            ClearPedTasks(PlayerPedId())
            IsAttached = true
            LoadAnimDict('mp_arresting')
            LoadAnimDict('move_m@generic_variations@walk')
            TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
            AttachEntityToEntity(PlayerPedId(), sourcePed, 1816,0.25, 0.49, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            amBeingEscorted()
        elseif state == 'carry' then
            ClearPedTasks(PlayerPedId())
            IsAttached = true
            LoadAnimDict('nm')
            TaskPlayAnim(PlayerPedId(), 'nm', 'firemans_carry', 8.0, -8.0, 100000, 33, 0, false, false, false)
            AttachEntityToEntity(PlayerPedId(), sourcePed, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 180, false, false, false, false, 2, false)
        elseif state == 'drag' then
            ClearPedTasks(PlayerPedId())
            IsAttached = true
            AttachEntityToEntity(PlayerPedId(), ped, 1816,0.25, 0.49, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        end
    end
end)

-- //ANCHOR - Robbing and Searching Logic

RegisterNetEvent('B1-Police:OpenInv', function(id)
    local PlayerData = ESX.GetPlayerData()
    if PlayerData.job == Config.PDJobs then
        exports.ox_inventory:openInventory('player', id)
    else
        TriggerServerEvent('B1-Police:Freeze', id, true)
        if lib.progressCircle({
            duration = 10000,
            position = 'bottom',
            useWhileDead = false,
            disable = {
                car = true,
                move = true,
                combat = true,
            },
            anim = {
                dict = 'random@countryside_gang_fight',
                clip = 'biker_02_stickup_loop'
            },
        }) then 
            exports.ox_inventory:openInventory('player', id)
            TriggerServerEvent('B1-Police:Freeze', id, false)
        end
    end
end)

-- //ANCHOR - Debug CL

RegisterCommand('test', function()
    if imCuffed == true then
        print('cuff is true')
    else
        print('cuff is false')
    end
    if imZipped == true then
        print('zip is true')
    else
        print('zip is false')
    end
    if isHardCuffed == true then
        print('cuff type is hard')
    else
        print('cuff type is soft')
    end
    print(myCount)
end)

RegisterCommand('delprop', function()
    local prop = GetEntityAttachedTo(PlayerPedId())
    DeleteObject(prop)
end)

RegisterCommand('testdata', function()
    local PlayerData = ESX.GetPlayerData()
    local dumpedTable = ESX.DumpTable(PlayerData)
    print(dumpedTable)
end)

RegisterCommand('loc', function()
    local loc = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    print(loc..heading)
end)