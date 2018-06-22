<#
.SYNOPSIS
    Converts [DateTime] object to unix epoch time in milliseconds
#>
function ConvertTo-EpochTime ( $dt ) {
    if ( !$dt ) { return }
    if ($dt -isnot [DateTime]) {throw "Parameter must be DateTime object"}

    $dt = $dt.ToUniversalTime()
    [int64]($dt - $script:EpochStart).TotalMilliseconds
}

<#
.SYNOPSIS
    Converts epoch time in milliseconds to [DateTime] object
#>
function ConvertFrom-EpochTime ( [int64] $etime ) {    
    $script:EpochStart.AddMilliseconds($etime).ToLocalTime()
}

sal epoch ConvertTo-EpochTime
sal hcope ConvertFrom-EpochTime
