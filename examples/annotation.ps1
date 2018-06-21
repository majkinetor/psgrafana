. $PSScriptRoot\_init.ps1

$ErrorActionPreference = 'STOP'

$dash = New-Dashboard 'PSGrafana Annotation Test' -Overwrite

$params = @{
    DashboardId = $dash.id
    Time        = (Get-Date).AddMinutes(-60)
    Timespan    = '00:20'    
}
New-Annotation @params