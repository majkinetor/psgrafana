<#
.SYNOPSIS
    Creates or updates a Grafana dashboard

.DESCRIPTION
    This function creates a new dashboard.
    If it already exists and parameter Overwrite is used, new empty version with no panels will be created.

.EXAMPLE
    New-Dashboard -Title 'PSGrafana test' -Overwrite

.LINK
    http://docs.grafana.org/http_api/dashboard/#create-update-dashboard
#>
function New-Dashboard {
    param(
        [string]    $Title          = 'PSGrafana Dashboard',
        [string[]]  $Tags           = @('powershell', 'psgrafana'),
        [string]    $CommitMessage  = 'Created by PSGrafana',
        [int]       $FolderId,
        [switch]    $Overwrite
    )

    $Body = @{
        dashboard = @{ title = $Title; tags = $Tags }
        folderId  = $FolderId
        overwrite = $Overwrite -eq $true
        message   = $CommitMessage
    }

    $params = @{
        Endpoint = "dashboards/db"
        Body = $Body | ConvertTo-Json
    }

    send-request $params
}