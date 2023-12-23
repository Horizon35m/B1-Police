-- //ANCHOR - Camera Menu

RegisterNetEvent('B1-Police:CameraOpen', function()
    options = {}
    for _, v in pairs(Config.SecurityCams) do
        table.insert(options, {
            title = v.location,
            icon = "fa-solid fa-camera",
            onSelect = function()
                HandleCameraEvent(_)
            end,
        })
    end
    lib.registerContext({
        id = 'CCTV_menu',
        title = 'Cameras',
        menu = 'dispatch_main_menu',
        options = options
    })
    lib.showContext('CCTV_menu')
end)

RegisterNetEvent('B1-Police:PDCameraOpen', function()
  options = {}
  for _, v in pairs(Config.SecurityCams) do
      table.insert(options, {
          title = v.location,
          icon = "fa-solid fa-camera",
          onSelect = function()
              HandleCameraEvent(_)
          end,
      })
  end
  lib.registerContext({
      id = 'CCTV_menu',
      title = 'Cameras',
      menu = 'pd_action_menu',
      options = options
  })
  lib.showContext('CCTV_menu')
end)

-- //ANCHOR - Dispatch Menus

RegisterNetEvent('B1-Police:DispatchOpen', function()
    lib.registerContext({
        id = 'dispatch_main_menu',
        title = 'Cameras',
        options = {
          {
            title = 'CCTV Cameras',
            description = 'Cameras from around the City!',
            event = 'B1-Police:CameraOpen',
            icon = 'fa-solid fa-camera'
          },
          {
            title = 'EMS Dispatch',
            description = 'Dispatch for EMS!',
            menu = 'EMS_dispatch_menu',
            icon = 'fa-solid fa-user-doctor'
          },
          {
            title = 'Police Dispatch',
            description = 'Dispatch for Police!',
            menu = 'police_dispatch_menu',
            icon = 'fa-solid fa-user-shield'
          },
        --   {
        --     title = 'Body Cameras',
        --     description = 'Bodyworn Cameras!',
        --     menu = 'BC_menu',
        --     icon = 'fa-solid fa-camera'
        --   },
        }
    })
    lib.registerContext({
        id = 'EMS_dispatch_menu',
        title = 'EMS',
        menu = 'dispatch_main_menu',
        options = {
          {
            title = 'View Active',
            description = 'View all Active units!',
            event = 'B1-Police:ActiveMainMenu',
            icon = 'fa-solid fa-users',
            args = 'ambulance'
          },
          {
            title = 'Mass actions',
            description = 'Actions for all available Units',
            event = 'B1-Police:MassMenu',
            icon = 'fa-solid fa-users-rectangle',
            args = 'ambulance'
          },
        }
    })
    lib.registerContext({
        id = 'police_dispatch_menu',
        title = 'police',
        menu = 'dispatch_main_menu',
        options = {
          {
            title = 'View Active',
            description = 'View all Active units!',
            event = 'B1-Police:ActiveMainMenu',
            icon = 'fa-solid fa-users',
            args = 'police'
          },
          {
            title = 'Mass actions',
            description = 'Actions for all available Units',
            event = 'B1-Police:MassMenu',
            icon = 'fa-solid fa-users-rectangle',
            args = 'police'
          },
        }
    })
    lib.showContext('dispatch_main_menu')
end)

RegisterNetEvent('B1-Police:ActiveMainMenu', function(job)
  ESX.TriggerServerCallback('B1-Police:DispatchGetActive', function(cb, Job)
    options = {}
    for i=1, #cb, 1 do
      table.insert(options, {
        title = cb[i].name,
        icon = "fa-solid fa-person",
        event = 'gl-police:dispatchActivePolice',
        description = 'Callsign: '.. cb[i].callsign ..  ' , ' ..  Job[job].grades[tostring(cb[i].grade)].label,
        onSelect = function()
            TriggerEvent('B1-Police:ActiveMenu', cb[i].id, cb[i].name, job)
        end,
      })
    end
    lib.registerContext({
        id = 'active_main_menu',
        title = 'Active Dispatch',
        menu = 'dispatch_main_menu',
        options = options
    })
    lib.showContext('active_main_menu')
  end, job)
end)

RegisterNetEvent('B1-Police:ActiveMenu', function(id, name, job)
  lib.registerContext({
      id = 'active_menu',
      title = name,
      menu = 'dispatch_main_menu',
      options = {
        {
          title = 'Send Message',
          description = 'Send a Message to Unit',
          icon = 'fa-solid fa-person-chalkboard',
          onSelect = function()
              TriggerEvent('B1-Police:MSGMenu', job, id, 'single')
          end,
        },
        {
          title = 'Send Waypoint',
          description = 'Send a Waypoint to Unit',
          icon = 'fa-solid fa-user-xmark',
          onSelect = function()
              TriggerEvent('B1-Police:SendWaypointCL', id, 'single')
          end,
        },
        {
          title = 'Panic Button',
          description = 'Triggers Panic Button',
          icon = 'fa-solid fa-user-injured',
          onSelect = function()
              TriggerEvent('B1-Police:MSGMenu', job, id, 'single')
          end,
        },
      }
  })
  lib.showContext('active_menu')
end)

RegisterNetEvent('B1-Police:MSGMenu', function(job, id, thing)
  if thing == 'single' then
    lib.registerContext({
      id = 'MSG_menu',
      title = 'Dispatch',
      menu = 'dispatch_main_menu',
      options = {
        {
          title = 'Recall to Station',
          description = 'Messages the unit back to the station!',
          icon = 'fa-solid fa-person-shelter',
          onSelect = function()
            TriggerServerEvent('B1-Police:NotifySV', id, job, 'Please return to the Station!', 'info')
          end,
        },
        {
          title = 'Join radio channel',
          description = 'Messages the unit to join specified channel!',
          icon = 'fa-solid fa-walkie-talkie',
          onSelect = function()
            local input = lib.inputDialog('Dispatch', {
              {type = 'number', label = 'Radio Channel', icon = 'hashtag'}       
            })
            if input then
              TriggerServerEvent('B1-Police:NotifySV', id, job, 'Please join channel '..input[1]..' !', 'info')
            else
              TriggerEvent('B1-Police:Notify', 'Dispatch', 'No channel entered', 'error')
            end
          end,
        },
      }
    })
  elseif thing == 'mass' then
    lib.registerContext({
      id = 'MSG_menu',
      title = 'Dispatch',
      menu = 'dispatch_main_menu',
      options = {
        {
          title = 'Recall to Station',
          description = 'Messages the unit back to the station!',
          icon = 'fa-solid fa-person-shelter',
          onSelect = function()
            ESX.TriggerServerCallback('B1-Police:DispatchGetMass', function(cb)
              for _, v in pairs(cb) do
                TriggerServerEvent('B1-Police:NotifySV', v.id, job, 'Please return to the Station!', 'info')
              end
            end, job)
          end,
        },
        {
          title = 'Join radio channel',
          description = 'Messages the unit to join specified channel!',
          icon = 'fa-solid fa-walkie-talkie',
          onSelect = function()
            local input = lib.inputDialog('Dispatch', {
              {type = 'number', label = 'Radio Channel', icon = 'hashtag'}       
            })
            if input then
              ESX.TriggerServerCallback('B1-Police:DispatchGetMass', function(cb)
                for _, v in pairs(cb) do
                  TriggerServerEvent('B1-Police:NotifySV', v.id, job, 'Please join channel '..input[1]..' !', 'info')
                end
              end, job)
            else
              TriggerEvent('B1-Police:Notify', 'Dispatch', 'No channel entered', 'error')
            end
          end,
        },
        {
          title = 'Security Condition',
          description = 'Messages all the units about Security Condition!',
          icon = 'fa-solid fa-person-military-rifle',
          onSelect = function()
            local input = lib.inputDialog('Dispatch', {
              {type = 'input', label = 'State of emergency!'}       
            })
            if input then
              ESX.TriggerServerCallback('B1-Police:DispatchGetMass', function(cb)
                for _, v in pairs(cb) do
                  TriggerServerEvent('B1-Police:NotifySV', v.id, job, 'State of Emergency is '..input[1]..' !', 'info')
                end
              end, job)
            else
              TriggerEvent('B1-Police:Notify', 'Dispatch', 'No text entered', 'error')
            end
          end,
        },
      }
    })
  else
    TriggerEvent('B1-Police:Notify', 'Dispatch', 'No thing entered', 'error')
  end
  lib.showContext('MSG_menu')
end)


RegisterNetEvent('B1-Police:MassMenu', function(job)
  lib.registerContext({
    id = 'mass_main_menu',
    title = 'Dispatch',
    menu = 'dispatch_main_menu',
    options = {
      {
        title = 'Send Message',
        description = 'Send a Message to all Units',
        icon = 'fa-solid fa-person-chalkboard',
        onSelect = function()
            TriggerEvent('B1-Police:MSGMenu', job, nil, 'mass')
        end,
      },
      {
        title = 'Send Waypoint',
        description = 'Send a Waypoint to all Units',
        icon = 'fa-solid fa-user-xmark',
        onSelect = function()
            TriggerEvent('B1-Police:SendWaypointCL', id, job, 'mass')
        end,
      },
    }
  })
  lib.registerContext({
    id = 'mass_msg_menu',
    title = 'Dispatch',
    menu = 'dispatch_main_menu',
    options = {
      {
        title = 'Recall to Station',
        description = 'Messages all the units to teturn to the station!',
        icon = 'fa-solid fa-person-shelter',
        onSelect = function()
            TriggerEvent('B1-Police:MSGMenu', job, nil, 'mass')
        end,
      },
      {
        title = 'Join radio channel',
        description = 'Messages all the units to join specified channel!',
        icon = 'fa-solid fa-walkie-talkie',
        onSelect = function()
            TriggerEvent('B1-Police:MSGMenu', job, nil, 'mass')
        end,
      },
    }
  })
  lib.showContext('mass_main_menu')
end)

-- //ANCHOR - Job Menu

RegisterNetEvent('B1-Police:JobMenu', function()
  lib.registerContext({
    id = 'pd_action_menu',
    title = 'Police',
    options = {
      {
        title = 'Soft Cuff',
        description = 'Soft Cuffs nearest player!',
        icon = 'fa-solid fa-handcuffs',
        onSelect = function()
          TriggerClientEvent('B1-Police:CuffPlayercl', nil, nil, 'cuff')
        end,
      },
      {
        title = 'Hard Cuff',
        description = 'Hard Cuffs nearest player!',
        icon = 'fa-solid fa-handcuffs',
        onSelect = function()
          TriggerClientEvent('B1-Police:CuffPlayercl', nil, 'hc', 'cuff')
        end,
      },
      {
        title = 'Frisk',
        description = 'Messages all the units to teturn to the station!',
        icon = 'fa-solid fa-magnifying-glass',
        onSelect = function()
            TriggerEvent('B1-Police:FriskPlayercl')
        end,
      },
      {
        title = 'Escort',
        description = 'Escorts nearest player!',
        icon = 'fa-solid fa-hands',
        onSelect = function()
          local state = 'escort'
          TriggerEvent('B1-Police:CarryPlayerCL', nil, state)
        end,
      },
      {
        title = 'Drag',
        description = 'Drags nearest player!',
        icon = 'fa-solid fa-truck-medical',
        onSelect = function()
          local state = 'drag'
          TriggerEvent('B1-Police:CarryPlayerCL', nil, state)
        end,
      },
      {
        title = 'Cameras',
        description = 'Cameras from around the City!',
        event = 'B1-Police:PDCameraOpen',
        icon = 'fa-solid fa-camera',
      },
    }
  })
  lib.showContext('pd_action_menu')
end)

