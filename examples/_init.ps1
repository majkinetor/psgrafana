@{
    GRAFANA_URL      = "http://localhost:3000"
    GRAFANA_USERNAME = 'admin'
    GRAFANA_PASSWORD = 'admin' 
}.GetEnumerator() | % { $n=$_.Key; if (!(gi Env:$n -ea 0)) { New-Item -Path Env: -Name $n -Value $_.Value } }

import-module -force $PSScriptRoot\.. 
$user = Initialize-Session
Write-Host "Authenticated as:" $user.name $user.login $user.email