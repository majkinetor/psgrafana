#$Env:GRAFANA_URL =         
#$Env:GRAFANA_USERNAME =
#$Env:GRAFANA_PASSWORD =

import-module -force $PSScriptRoot\..

Initialize-Session
Get-Dashboards -List
