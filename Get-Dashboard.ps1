<#
.SYNOPSIS
    Get single Grafana dashboard

.LINK
    http://docs.grafana.org/http_api/dashboard/#get-dashboard-by-uid
#>
function Get-Dashboard {
    param(
        [string] $Uri
    )

    $params = @{
        Endpoint = "dashboards/$Uri"
        Method   = 'GET'
    }
    send-request $params
}