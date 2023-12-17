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
      print(target)
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
})

-- //ANCHOR - Global Vehicles 

-- exports.ox_target:addGlobalVehicle({
--   {
--     label = "Place in Car",
--     icon = 'fa-solid fa-hand',
--     groups = {'police','ambulance'},
--     distance = 1.5,
--     onSelect = function(data)
--       veh = data.entity
--       TriggerEvent('gl-police:putincar', veh)
--     end,
--   },
--   {
--     label = "Take out of Car",
--     icon = 'fa-solid fa-hand',
--     groups = {'police','ambulance'},
--     distance = 1.5,
--     onSelect = function(data)
--       veh = data.entity
--       TriggerEvent('gl-police:takeoutcar', veh)
--     end,
--   },
-- })

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
              print(location)
              TriggerEvent('B1-Police:FillBoard', location)
            end
        },
    }
  })
end

