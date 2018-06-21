<#
.SYNOPSIS
    Create new Grafana annotation

.DESCRIPTION
    Annotations are saved in the Grafana database (sqlite, mysql or postgres). 
    Annotations can be global annotations that can be shown on any dashboard by configuring an annotation data source - they are filtered by tags. 
    Or they can be tied to a panel on a dashboard and are then only shown on that panel.

    The dashboardId and panelId fields are optional.
    If dasboardId is not specified, the annotation is global and can be queried in any dashboard that adds the Grafana annotations data source.
    if panelId is not specified, annotation can bi picked up with default _Annotations & Alerts (Built-in)_ that filters by Dashboard. 
    You must enable this annotation to see its marks.

.EXAMPLE
    New-Annotation -DashboardId 1 -Text 'Hello world' -Tags hello,world

    Create new annotation on given dashboard at current time

.EXAMPLE
    New-Annotation
    
    Create global annotation with all default parameters.

.LINK
    http://docs.grafana.org/http_api/annotations/#create-annotation
#>

function New-Annotation {
    [CmdletBinding(DefaultParameterSetName="TimeEnd")]
    param(
        [string]    $Text = 'Created by psgrafana',
        [string[]]  $Tags = @('psgrafana', 'powershell'),
        [int]       $DashboardId,       
        [int]       $PanelId,
        [DateTime]  $Time = (Get-Date),

        [Parameter(ParameterSetName = 'TimeEnd')]
        [DateTime]  $TimeEnd,

        [Parameter(ParameterSetName = 'Timespan')]
        [TimeSpan]  $Timespan
    )    
 
    if ($Timespan) { $TimeEnd = $Time + $Timespan }
    
    $unixEpochStart = New-Object DateTime 1970,1,1,0,0,0,([DateTimeKind]::Utc)
    $epoch_ms       = [int64]($Time.ToUniversalTime() - $unixEpochStart).TotalMilliseconds
    if ($TimeEnd) {
         $epochEnd_ms = [int64]($TimeEnd.ToUniversalTime() - $unixEpochStart).TotalMilliseconds
    }
    
    $Body = @{
        dashboardId = $DashboardId
        panelId     = $PanelId
        time        = $epoch_ms
        timeEnd     = $epochEnd_ms
        tags        = $tags
        isRegion    = $epochEnd_ms -ne $null
        text        = $Text
    }

    $params = @{
        Endpoint = "annotations"
        Body = $Body | ConvertTo-Json
    }
    send-request $params
}