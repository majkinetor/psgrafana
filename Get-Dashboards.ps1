function Get-Dashboards( [string] $Query, [string] $Tags, [int] $Limit, [switch] $List ) {

    $params = @{
        Method   = 'GET'
        Endpoint = "search"
        Query = @{
            query = $Query
            tags  = $Tags -join '&tags='
            limit = $Limit
        }
    }
    $res = send-request $params

    if ($List) { $res | select title,uri,tags | ft -auto ; return }
    $res
}