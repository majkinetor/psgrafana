. $PSScriptRoot\_init.ps1

Get-Dashboards -List
$dashboards = Get-Dashboards | % { Get-Dashboard $_.uri } 

mkdir $PSScriptRoot\export | out-null
foreach ($dash in $dashboards) {
    if ($dash.meta.isFolder) { continue }
    $dash = $dash.dashboard
    $fn = "$($dash.title).json"
    $fn
    $dash | ConvertTo-Json -Depth 100 | Out-File $PSScriptRoot\export\$fn -Encoding UTF8
} 
