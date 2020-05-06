fx_version 'adamant'

game 'gta5'

description 'Hypnotix'

version '1.0.0'

client_scripts {	
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'client/cl_main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/fr.lua',
	'config.lua',
	'server/sv_main.lua',
	'server/sv_license.lua'
}