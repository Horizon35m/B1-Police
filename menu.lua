
-- //ANCHOR - Radials
lib.addRadialItem({
    {
        id = 'police',
        label = 'Police',
        icon = 'shield-halved',
        menu = 'police_menu'
    },
})
lib.registerRadial({
    id = 'police_menu',
    items = {
        {
            label = 'Cameras',
            icon = 'fa-solid fa-camera',
            onSelect = function()
                TriggerEvent('B1-Police:CameraOpen')
            end
        },
        {
            label = 'Dispatch',
            icon = 'fa-solid fa-camera',
            onSelect = function()
                TriggerEvent('B1-Police:DispatchOpen')
            end
        },
    }
})

-- //ANCHOR - Camera Menu

RegisterNetEvent('B1-Police:CameraOpen', function()
    lib.registerContext({
        id = 'cam_main_menu',
        title = 'Cameras',
        options = {
          {
            title = 'CCTV Cameras',
            description = 'Cameras from around the City!',
            menu = 'CCTV_menu',
            icon = 'fa-solid fa-camera'
          },
        --   {
        --     title = 'Body Cameras',
        --     description = 'Bodyworn Cameras!',
        --     menu = 'BC_menu',
        --     icon = 'fa-solid fa-camera'
        --   },
        }
    })
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
        title = 'CCTV Cameras',
        options = options
    })
    lib.showContext('cam_main_menu')
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
            menu = 'CCTV_menu',
            icon = 'fa-solid fa-camera-cctv'
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
            icon = 'fa-solid fa-user-sheild'
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
        options = {
          {
            title = 'View Active',
            description = 'View all Active units!',
            menu = 'EMS_active_menu',
            icon = 'fa-solid fa-users'
          },
          {
            title = 'Mass actions',
            description = 'Actions for all available Units',
            menu = 'EMS_mass_menu',
            icon = 'fa-solid fa-users-rectangle'
          },
        }
    })
    lib.registerContext({
        id = 'police_dispatch_menu',
        title = 'police',
        options = {
          {
            title = 'View Active',
            description = 'View all Active units!',
            menu = 'police_active_menu',
            icon = 'fa-solid fa-users'
          },
          {
            title = 'Mass actions',
            description = 'Actions for all available Units',
            menu = 'police_mass_menu',
            icon = 'fa-solid fa-users-rectangle'
          },
        }
    })
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
        title = 'CCTV Cameras',
        options = options
    })
    
    lib.showContext('dispatch_main_menu')
end)

