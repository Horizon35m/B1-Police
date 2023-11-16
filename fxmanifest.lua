fx_version 'cerulean'
game 'gta5'

author 'B1 Studios - HRZN'
description 'Advanced Police Job for ESX'
version '0.0.1'

lua54 "yes"

client_scripts {
    'function_cl.lua',
    'menu.lua',
    'interaction.lua'
}

server_scripts {
    'function_sv.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

dependencies {
    'ox_lib',
    'screenshot-basic'
}