<#
.SYNOPSIS
    Get Grafana annotations

.EXAMPLE
    Get-Annotations -From (Get-Date).AddDays(-3) -Tags foo

.LINK
    http://docs.grafana.org/http_api/annotations/#find-annotations
#>
function Get-Annotations {
    param(
        # Use this to filter global annotations
        [string[]]  $Tags,   

        # Find annotations that are scoped to a specific dashboard
        [string]    $DashboardId,

        # Find annotations that are scoped to a specific panel
        [string]    $PanelId,

        [DateTime]  $From,
        [DateTime]  $To,

        # Max limit for results returned, default is 100. 
        [string] $Limit,

        # Find annotations created by a specific user
        [string] $UserId,

        [ValidateSet('alert', 'annotation')]
        [string] $Type
    )
    
    $query = @{
      from        = epoch $From
      to          = epoch $To
      tags        = ($Tags -join '&tags=')
      limit       = $Limit
      dashboardId = $DashboardId
      panelId     = $PanelId
      userId      = $UserId
      type        = $Type
    }

    $params = @{
        Endpoint = "annotations"
        Query    = $query
        Method   = "Get"
    }
    send-request $params
}