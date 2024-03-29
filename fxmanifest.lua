fx_version "adamant"
version '1.0.0'
author "Jenga"
description "Default"
game "gta5"

client_script "main/client.lua"
server_script "main/server.lua"
shared_script "main/config.lua"

ui_page "index.html"

files {
    'index.html',
    'vue.js',
    'assets/**/*.*',
}

escrow_ignore { 'main/config.lua' }

lua54 'yes'