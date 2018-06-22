#require -version 3.0

# Export functions that start with capital letter, others are private
# Include file names that start with capital letters, ignore other

$pre = ls Function:\*
ls "$PSScriptRoot\*.ps1" | ? { $_.Name -cmatch '^[A-Z]+' } | % { . $_  }
$post = ls Function:\*
$funcs = compare $pre $post | select -Expand InputObject | select -Expand Name
$funcs | ? { $_ -cmatch '^[A-Z]+'} | % { Export-ModuleMember -Function $_ }

Export-ModuleMember -Alias *

if ($Env:GRAFANA_URL) {
    Write-Host -NoNewLine -Foreground green "`n  Grafana URL: ".PadRight(15)
    Write-Host $Env:GRAFANA_URL "`n"
}

# All script variables used
$script:URL           = ''
$script:Authorization = ''
$script:EpochStart    = New-Object DateTime 1970,1,1,0,0,0,([DateTimeKind]::Utc)
