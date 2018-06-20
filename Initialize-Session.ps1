<#
.SYNOPSIS
    Initialize Grafana session by providing credentials or ApiToken

.DESCRIPTION
    This function authenticates user on Grafana server. It must be called prior to any other 
    function call.

.EXAMPLE
    Initialize-Session admin adminpwd

    Login with username and password

.EXAMPLE
    Initialize-Session -Password eyJrIjoiT0tTcG1pUlY2RnVKZTFVaDFsNFZXdE9ZWmNrMkZYbk

    Use ApiToken to authenticate.

.LINK
    http://docs.grafana.org/http_api/auth/
#>
function Initialize-Session {
    [CmdletBinding()]
    param(
        # Username, if ommitted password must be set as AccessToken
        [string] $Username,

        # Password, if omitted previously generated refresh token will be used
        [string] $Password,

        # API endpoint to the Grafana service, by default taken from environment variable GRAFANA_URL
        [string] $Url = $Env:GRAFANA_URL
    )

    function b64($s) { [Convert]::ToBase64String( [System.Text.Encoding]::Utf8.GetBytes($s)) }

    $authorization = if (!$Username -and $Password) {
                        "Bearer $Password"
                    } else {
                        "Basic " + ( b64 "${Username}:${Password}" )
                    }

    irm "$Url/api/user" -Headers @{ Authorization = $authorization } -ErrorAction STOP

    $script:global = @{
        Url           = "$Url/api"
        Authorization = $authorization
    }

}