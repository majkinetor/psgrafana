function Get-Annotations {
    param(
        [string]    $Text = 'Created by psgrafana',
        [string[]]  $Tags = @('psgrafana', 'powershell'),        
        [int]       $DashboardId,       
        [int]       $PanelId = 1,
        [DateTime]  $Time = (Get-Date),

        [ParameterSetName('TimeEnd')]
        [DateTime]  $TimeEnd,

        [ParameterSetName('TimeSpan')]
        [TimeSpan]  $Timespan
    )

    if ($Timespan) { $TimeEnd = $Time + $Timespan }
    
    $unixEpochStart = new-object DateTime 1970,1,1,0,0,0,([DateTimeKind]::Utc)
    $epoch_m     = [int64]($Time.ToUniversalTime() - $unixEpochStart).TotalMilliseconds
    $epochEnd_ms = [int64]($TimeEnd.ToUniversalTime() - $unixEpochStart).TotalMilliseconds


    $params = @{
        Endpoint = "annotations"
        Method = "Get"
    }
    send-request $params
}