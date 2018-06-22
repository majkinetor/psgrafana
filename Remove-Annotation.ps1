<#
.SYNOPSIS
    Remove Grafana annotation by id
    
.LINK
    http://docs.grafana.org/http_api/annotations/#delete-annotation-by-id
#>
function Remove-Annotation([int] $Id, [switch] $Region) {
    $params = @{
        Endpoint = if ($Region) { "annotations/region/$Id" } else { "annotations/$Id" }
        Method   = "DELETE"
    }
    send-request $params
}