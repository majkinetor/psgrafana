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