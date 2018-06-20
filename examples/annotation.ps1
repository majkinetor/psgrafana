

import-module -force $PSScriptRoot\..

Initialize-Session
Get-Dashboard db/cir-applicative-metrics | % dashboard | set db

$panelTitle = '*iis*hang*'
$db.panels | ? title -like $panelTitle | select -first 1 | set panel

$params = @{
    Text = "psgrafana test 2" 
    Tags = 'foo', 'bar'
    DashboardId = $db.id
    PanelId  = $panel.Id
}
New-Annotation @params
