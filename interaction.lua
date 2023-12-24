local ox_inventory = exports.ox_inventory

-- # Targets

-- //ANCHOR - Globals Ped

exports.ox_target:addGlobalPlayer({
  {
    label = "Search Person",
    icon = 'fa-solid fa-magnifying-glass',
    groups = 'police',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      TriggerEvent('B1-Police:OpenInv', target)
    end,
  },
  {
    label = "Rob Person",
    icon = 'fa-solid fa-user-secret',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      exports.ox_inventory:openInventory('player', target)
    end,
  },
  {
    label = "Frisk Person",
    icon = 'fa-solid fa-hand',
    groups = 'police',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      TriggerServerEvent('B1-Police:FriskPlayersv', target)
    end,
  },
  {
    label = "Hard Cuff Person",
    icon = 'fa-solid fa-handcuffs',
    distance = 1.5,
    items = 'cuffs',
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local thing = 'hc'
      local cuff = 'cuff'
      TriggerEvent('B1-Police:CuffPlayercl', target, thing, cuff)
    end,
  },
  {
    label = "Soft Cuff Person",
    icon = 'fa-solid fa-handcuffs',
    distance = 1.5,
    items = 'cuffs',
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local thing = nil
      local cuff = 'cuff'
      TriggerEvent('B1-Police:CuffPlayercl', target, thing, cuff)
    end,
  },
  {
    label = "Hard Ziptie Person",
    icon = 'fa-solid fa-handcuffs',
    distance = 1.5,
    items = 'ziptie',
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local thing = 'hc'
      local cuff = 'zip'
      TriggerEvent('B1-Police:CuffPlayercl', target, thing, cuff)
    end,
  },
  {
    label = "Soft Ziptie Person",
    icon = 'fa-solid fa-handcuffs',
    distance = 1.5,
    items = 'ziptie',
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local thing = nil
      local cuff = 'zip'
      TriggerEvent('B1-Police:CuffPlayercl', target, thing, cuff)
    end,
  },
  {
    label = "Uncuff Person",
    icon = 'fa-solid fa-handcuffs',
    distance = 1.5,
    items = 'handcuff_key',
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local item = 'cuffkey'
      TriggerEvent('B1-Police:UnCuff', target, item)
    end,
  },
  {
    label = "Uncuff Person",
    icon = 'fa-solid fa-user-secret',
    items = 'handmade_key',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local item = 'hmkey'
      TriggerEvent('B1-Police:UnCuff', target, item)
    end,
  },
  {
    label = "UnShackle Person",
    icon = 'fa-solid fa-user-secret',
    items = 'bolt_cutters',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local item = 'cutters'
      TriggerEvent('B1-Police:UnCuff', target, item)
    end,
  },
  {
    label = "Cut Ties",
    icon = 'fa-solid fa-scissors',
    items = 'pliers',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local item = 'pliers'
      TriggerEvent('B1-Police:UnCuff', target, item)
    end,
  },
  {
    label = "Escort Player",
    icon = 'fa-solid fa-handcuffs',
    groups = 'police',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local state = 'escort'
      TriggerEvent('B1-Police:CarryPlayerCL', target, state)
    end,
  },
  {
    label = "Drag Player",
    icon = 'fa-solid fa-truck-medical',
    groups = 'ambulance',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local state = 'drag'
      TriggerEvent('B1-Police:CarryPlayerCL', target, state)
    end,
  },
  {
    label = "Carry Player",
    icon = 'fa-solid fa-hands-holding',
    distance = 1.5,
    onSelect = function(data)
      local NetworkPlayer = NetworkGetPlayerIndexFromPed(data.entity)
      local ServerId = GetPlayerServerId(NetworkPlayer)
      local target = ServerId
      local state = 'carry'
      TriggerEvent('B1-Police:CarryPlayerCL', target, state)
    end,
  },
})

-- //ANCHOR - Global Vehicles 

exports.ox_target:addGlobalVehicle({
  {
    label = "Place in Car",
    icon = 'fa-solid fa-hand',
    groups = {'police','ambulance'},
    distance = 1.5,
    onSelect = function(data)
      veh = data.entity
      TriggerEvent('B1-Police:PutinCarCL', nil, veh)
    end,
  },
  {
    label = "Take out of Car",
    icon = 'fa-solid fa-hand',
    groups = {'police','ambulance'},
    distance = 1.5,
    onSelect = function(data)
      local dumpedTable = ESX.DumpTable(data)
      
      print(dumpedTable)
      -- veh = data.entity
      -- TriggerEvent('gl-police:takeoutcar', nil, veh)

    end,
  },
})

-- //ANCHOR - Dispatch targets

local keyboards = {
  -- MRPD
    {
        coords = vec3(448.3, -999.45, 34.9),
        radius = 0.2,
        debug = true,
    },
    {
        coords = vec3(446.05, -999.4, 34.9),
        radius = 0.2,
        debug = true,
    },
    {
        coords = vec3(444.05, -999.6, 34.9),
        radius = 0.2,
        debug = true,
    },
    {
        coords = vec3(441.55, -999.5, 34.9),
        radius = 0.2,
        debug = true,
    },
    {
        coords = vec3(440.65, -996.0, 34.85),
        radius = 0.2,
        debug = true,
    },
    {
        coords = vec3(443.95, -996.0, 34.9),
        radius = 0.2,
        debug = true,
    },
  -- Highway Patrol
    {
      coords = vec3(1545.3, 825.5, 77.5),
      radius = 0.25,
      debug = true,
    },
    {
      coords = vec3(1546.25, 827.2, 77.5),
      radius = 0.25,
      debug = true,
    },
    {
      coords = vec3(1547.3, 829.0, 77.5),
      radius = 0.25,
      debug = true,
    },
    {
      coords = vec3(1543.95, 830.95, 77.5),
      radius = 0.25,
      debug = true,
    },
    {
      coords = vec3(1542.9, 829.15, 77.5),
      radius = 0.25,
      debug = true,
    },
    {
      coords = vec3(1541.9, 827.45, 77.5),
      radius = 0.25,
      debug = true,
    },
}

for _, v in pairs(keyboards) do
    exports.ox_target:addSphereZone({
        coords = v.coords,
        radius = v.radius,
        debug = v.debug,
        groups = {
            'police',
            'dispatch'
        },
        options = {
            {
                label = "Dispatch Control",
                icon = 'fa-solid fa-headset',
                distance = 3,
                event = 'B1-Police:DispatchOpen',
            },
        }
    })
end

-- //ANCHOR - Mugshot Target

for _,v in pairs(Config.Mugshotsloc) do
  exports.ox_target:addBoxZone({
    coords = v.target.coords,
    size = v.target.size,
    rotation = v.target.rotation,
    debug = v.target.debug,
    groups = {
        v.target.groups,
    },
    options = {
        {
            icon = "fa-solid fa-camera",
            label = 'Take Mugshot',
            distance = 2,
            onSelect = function()
              local location = tostring(_)
              TriggerEvent('B1-Police:FillBoard', location)
            end
        },
    }
  })
end

for _,v in pairs(Config.Cloakroomloc) do
  exports.ox_target:addBoxZone({
    coords = v.coords,
    size = v.size,
    rotation = v.rotation,
    debug = v.debug,
    groups = v.groups,
    options = {
      {
          icon = "fa-solid fa-shirt",
          label = v.label,
          distance = 2,
          event = Config.ClothingExport
      },
      {
          icon = "fa-solid fa-box-archive",
          label = "Personal Locker",
          distance = 2,
          onSelect = function()
            ox_inventory:openInventory('stash', 'policelocker')
          end
      },
    }
  })
end

