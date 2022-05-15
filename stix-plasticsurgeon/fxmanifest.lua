fx_version "cerulean"
game { "gta5" }

author 'ColdStiX#1906'
description 'Script for plastic surgeon for trill city (Custom Asset)'
version 'v1.0'

shared_script 'shared/*.lua'

client_scripts {
  '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
  'cl/*.lua',
}

server_scripts {
  'sv/*.lua',
}