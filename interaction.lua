local ox_inventory = exports.ox_inventory

-- # Targets
-- Globals
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
})

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