<#
.SYNOPSIS
    Create new Grafana annotation

.NOTES
    Only works with Basic Authentication

.EXAMPLE
    New-User psgrafana psgrafana@foo.bar

    Create new user
s.

.LINK
   http://docs.grafana.org/http_api/admin/#global-users
#>
function New-User {
    param(
        # First and last user name
        [string] $Name,

        # User email
        [string] $Email,
        
        # Grafana username
        [string] $Login,

        # Grana password
        [string] $Password
    )

    $Body = @{
        name    = $Name
        email   = $Email
        login   = $Login
        password = $Password
    }

    $params = @{
        Endpoint = "admin/users"
        Body     = $Body | ConvertTo-Json
    }
    send-request $params
}