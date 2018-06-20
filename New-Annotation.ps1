function New-Annotation {
    param(
        [string] $Text,
        [string[]] $Tags,
        [int] $DashboardId,
        [int] $PanelId = 1,
        [DateTime] $Time = (Get-Date),
        [DateTime] $TimeEnd
    )
    $unixEpochStart = new-object DateTime 1970,1,1,0,0,0,([DateTimeKind]::Utc)
    $epoch_ms= [int64]($Time - $unixEpochStart).TotalMilliseconds
    
    $Body = @{
        dashboardId = $DashboardId
        panelId     = $PanelId
        time        = $epoch_ms
        timeEnd     = $epoch_ms
        tags        = $tags
        isRegion    = $false
        text        = $Text
    }

    $params = @{
        Endpoint = "annotations"
        Body = $Body | ConvertTo-Json
    }
    send-request $params
}