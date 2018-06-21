<#
.EXAMPLE
    Get-Annotations -From (Get-Date).AddDays(-3) -Tags foo
#>
function Get-Annotations {
    param(
        # Use this to filter global annotations
        [string[]]  $Tags,   

        # Find annotations that are scoped to a specific dashboard
        [string]       $DashboardId,

        # Find annotations that are scoped to a specific panel
        [string]       $PanelId,

        [DateTime]  $From,
        [DateTime]  $To,

        # Max limit for results returned, default is 100. 
        [string] $Limit,

        # Find annotations created by a specific user
        [string] $UserId,

        [ValidateSet('alert', 'annotation')]
        [string] $Type
    )
    
    $unixEpochStart = new-object DateTime 1970,1,1,0,0,0,([DateTimeKind]::Utc)
    $epochFrom_ms   = [int64]($From.ToUniversalTime() - $unixEpochStart).TotalMilliseconds
    $epochTo_ms     = if ($To) { [int64]($To.ToUniversalTime() - $unixEpochStart).TotalMilliseconds }

    $query = @{
      from        = $epochFrom_ms
      to          = $epochTo_ms
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