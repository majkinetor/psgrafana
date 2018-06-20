function Get-Dashboards( [string] $Query, [string] $Tag, [int] $Limit, [switch] $List ) {

    $q = @()
    if ($Tag)   { $q += "tag=$Tag" }
    if ($Query) { $q += "query=$Query"}
    if ($Limit) { $q += "limit=$Limit"}
    $q = $q -join '&'

    $params = @{
        Endpoint = "search?$q"
        Method   = 'GET'
    }
    $res = send-request $params

    if ($List) { $res | select title,uri,tags | ft -auto ; return }
    $res
}