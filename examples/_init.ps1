$Env:GRAFANA_URL      = "http://localhost:3000"        
$Env:GRAFANA_USERNAME = 'admin'
$Env:GRAFANA_PASSWORD = 'admin'

import-module -force $PSScriptRoot\..
$user = Initialize-Session
Write-Host "Authenticated as:" $user.name $user.login $user.email