Config = {}

Config.EmoteResource = 'native' -- native, this is where you set you animation resource ONLY SUPPORTS NATIVE ATM

Config.Notify = 'ox' -- Notify method ox for ox_lib TODO ADD MORE

Config.EnableMenu = true -- Enables PD action menu

Config.EnableRadial = true -- Enables Premade radials

Config.PDJobs = { -- The jobs that have access to PD functions
    'police',
}


Config.EnableCuffKeys = true -- Enables Handcuff keybinds

Config.MaxCuffBreaks = 4

Config.SoftCuffKey = '->'

Config.HardCuffKey = '<-'

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
    MRPD = {
            target = {coords = vec3(461.0, -996.0, 25.0), size = vec3(1, 1, 1), rotation = 0, debug = true, groups = 'police'},
            mugshot = {pos = {x = 465.727, y = -998.084, z = 23.914}, rotation = 86.008},
            camera = {pos = vec3(464.730, -998.058, 25.5), rotation = {x = -8.9770584106445, y = 0.014564922079444, z = -90.994934082031}},
            
            PoliceJob = 'police',
            BoardHeader = 'Los Santos County Sherrifs office',
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