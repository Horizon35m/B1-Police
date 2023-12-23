Config = {}

Config.EmoteResource = 'native' -- native, this is where you set you animation resource ONLY SUPPORTS NATIVE ATM

Config.Notify = 'ox' -- Notify method ox for ox_lib TODO ADD MORE

Config.ClothingExport = "illenium-appearance:client:openClothingShopMenu"

Config.EnableMenu = true -- Enables PD action menu

Config.PDJobs = { -- The jobs that have access to PD functions
    'police',
}

Config.CallsignGroups = { -- The groups that have access to callsign functions
    'police',
    'ambulance'
}


Config.MaxCuffBreaks = 4

Config.TackleCopTime = 1500 -- Time Tackler is on the ground.

Config.TackleCrimTime = 5000 --Time Tackled Person is on the ground.

Config.TackleCarriedTime = 3000 --Time Carried person is on the ground.

Config.TackleKeybind = 74 -- https://docs.fivem.net/docs/game-references/controls/#controls for id

Config.Cloakroomloc = {
    LSHP = {
        label = 'Cloakroom',
        coords = vec3(1537.3, 809.15, 77.65),
        size = vec3(3.2, 0.6, 1.95),
        rotation = 330.25,
        groups = {
            'police'
        },
        debug = true,
    },
}

Config.SecurityCams = {
    {
        location = "Pacific Bank", 
        cameras = {
            {coords = vector3(257.45, 210.07, 109.08), rotation = {x = -25.0, y = 0.0, z = 28.05}},
            {coords = vector3(269.66, 223.67, 113.23), rotation = {x = -30.0, y = 0.0, z = 111.29}},
            {coords = vector3(241.64, 233.83, 111.48), rotation = {x = -35.0, y = 0.0, z = 120.46}},
            {coords = vector3(232.86, 221.46, 107.83), rotation = {x = -25.0, y = 0.0, z = -140.91}},
        },
    },
    {
        location = "Grove St. Gas", 
        cameras = {
            {coords = vector3(-53.1433, -1746.714, 31.546), rotation = {x = -35.0, y = 0.0, z = -168.9182}},
        },
    },    
}

Config.Mugshotoptions = {
    LogTitle = 'Mugshot',
    LogName = 'Mugshot',
    LogIcon = 'https://cdn.discordapp.com/attachments/1026588960207667321/1114942675951562844/border-01-tebex.png',
    ScreenShotHook = "https://discord.com/api/webhooks/1185571707474427905/PoPWOEhqkO06KGmZFclCUDO6OxUwYkNpnGWaTVKaTDpgoMMBn0wj8H1gT1JLLNgtfsyZ",
    MugShotHook = "https://discord.com/api/webhooks/1185570647930327131/XZB8-oPkVHbmrd8ry45axFHjA5UaV69qzfpAQRy6QroCMJftjOvYTPz_PzviPZRbNBTN",
}

Config.Mugshotsloc = {
    LSHP = {
            target = {coords = vec3(1556.2, 835.35, 77.05), size = vec3(0.45, 1.05, 0.75), rotation = 328.75, debug = true, groups = 'police'},
            mugshot = {pos = {x = 1559.377, y = 837.511, z = 77.}, rotation = 152.532},
            camera = {pos = vec3(1558.736, 836.173, 77.655), rotation = {x = 0, y = 0.0, z = -31.467708587646}},
            
            PoliceJob = 'police',
            BoardHeader = 'Los Santos Highway Patrol',
    },
    MRPD = {
            target = {coords = vec3(474.15, -1014.4, 26.25), size = vec3(0.55, 0.25, 0.15), rotation = 0.0, debug = true, groups = 'police'},
            mugshot = {pos = vec3(473.049, -1011.176, 25.6), rotation = 177.427},
            camera = {pos = vec3(473.0146484375, -1012.581237793, 26.2), rotation = {x = 0, y = 0.0, z = 0.23536868393421}},
            
            PoliceJob = 'police',
            BoardHeader = 'Los Santos Sherrifs Office',
    },
}

Config.Guns = { -- Where you set the items detected by frisk only supports weapons atm.
    "WEAPON_PISTOL_MK2",
    "WEAPON_ASSAULTSMG",
    "WEAPON_MOLOTOV",
    "WEAPON_SMG_MK2",
    "WEAPON_POOLCUE",
    "WEAPON_GRENADE",
    "WEAPON_MARKSMANPISTOL",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_BOTTLE",
    "WEAPON_COMBATMG",
    "WEAPON_MINISMG",
    "WEAPON_SWEEPERSHOTGUN",
    "WEAPON_ASSAULTRIFLE_MK2",
    "WEAPON_CARBINERIFLE_MK2",
    "WEAPON_BAT",
    "WEAPON_HEAVYSNIPER_MK2",
    "WEAPON_PUMPSHOTGUN_MK2",
    "WEAPON_FLASHLIGHT",
    "WEAPON_COMBATPDW",
    "WEAPON_COMBATPISTOL",
    "WEAPON_SNSPISTOL_MK2",
    "WEAPON_FIREWORK",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_MARKSMANRIFLE",
    "WEAPON_AUTOSHOTGUN",
    "WEAPON_PROXMINE",
    "WEAPON_REVOLVER",
    "WEAPON_COMBATSHOTGUN",
    "WEAPON_MILITARYRIFLE",
    "WEAPON_RAYCARBINE",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_GUSENBERG",
    "WEAPON_HEAVYSHOTGUN",
    "WEAPON_FLARE",
    "WEAPON_KNIFE",
    "WEAPON_STONE_HATCHET",
    "WEAPON_GRENADELAUNCHER_SMOKE",
    "WEAPON_CERAMICPISTOL",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_PIPEBOMB",
    "WEAPON_MICROSMG",
    "WEAPON_DAGGER",
    "WEAPON_MUSKET",
    "WEAPON_RAYMINIGUN",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_GADGETPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_HOMINGLAUNCHER",
    "WEAPON_PIPEWRENCH",
    "WEAPON_MARKSMANRIFLE_MK2",
    "WEAPON_RAYPISTOL",
    "WEAPON_FIREEXTINGUISHER",
    "WEAPON_MINIGUN",
    "WEAPON_PETROLCAN",
    "WEAPON_HATCHET",
    "WEAPON_DBSHOTGUN",
    "WEAPON_DOUBLEACTION",
    "WEAPON_REVOLVER_MK2",
    "WEAPON_COMPACTLAUNCHER",
    "WEAPON_STUNGUN",
    "WEAPON_BULLPUPRIFLE_MK2",
    "WEAPON_SWITCHBLADE",
    "WEAPON_SNIPERRIFLE",
    "WEAPON_KNUCKLE",
    "WEAPON_SPECIALCARBINE_MK2",
    "WEAPON_NIGHTSTICK",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_CROWBAR",
    "WEAPON_RPG",
    "WEAPON_GRENADELAUNCHER",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_RAILGUN",
    "WEAPON_PISTOL50",
    "WEAPON_SMG",
    "WEAPON_HAMMER",
    "WEAPON_PISTOL",
    "WEAPON_GOLFCLUB",
    "WEAPON_SNSPISTOL",
    "WEAPON_CARBINERIFLE",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_HAZARDCAN",
    "WEAPON_DIGISCANNER",
    "WEAPON_NAVYREVOLVER",
    "WEAPON_SMOKEGRENADE",
    "WEAPON_BZGAS",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_MACHETE",
    "WEAPON_STICKYBOMB",
    "WEAPON_COMBATMG_MK2",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_MG",
    "WEAPON_FLAREGUN",
}