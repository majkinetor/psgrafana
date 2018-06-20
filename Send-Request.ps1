function send-request( [HashTable] $Params ) {

    $p = $Params.Clone()

    $p.UseBasicParsing = $true

    if (!$p.Uri)                   { $p.Uri         = $script:global.Url + '/' + $p.Endpoint }
    if (!$p.Method)                { $p.Method      = 'POST' }
    if (!$p.CotentType)            { $p.ContentType = 'application/json' }
    if (!$p.Headers)               { $p.Headers     = @{} }
    if (!$p.Headers.Authorization) { $p.Headers.Authorization = $script:global.Authorization }

    $p.Remove('EndPoint')

    if (!$p.Uri.StartsWith('http')) { throw 'Before calling any module function you need to use Initialize-Session' }

    if ( $VerbosePreference -eq 'continue' ) { $p | ConvertTo-Json | Write-Verbose }

    # try {
    Invoke-RestMethod @p
    # } catch {
    #     $status_code = [int]$_.Exception.Response.StatusCode
    #     $status_desc = $_.Exception.Response.StatusDescription
    #     Write-Verbose "Status: $status_desc ($status_code)"

    #     if ( $status_desc -ne 'Unauthorized' ) {
    #         Write-Verbose "Non 401 error, getting response and rethrowing"
    #         $res = Get-ErrorResult $_

    #         [array] $custom_err = if ( $res -is [string] ) { $res } else { $res.message + $res.status.message }          
    #         $custom_err += switch ($status_desc) {
    #             'Bad Request'         { $res.status.code,   'InvalidOperation', $null }
    #             'Unprocessable Entity'{ $status_code,       'InvalidData',      $res.errors }
    #             'Too Many Reqests'    { $status_code,       'LimitsExceeded',   $res.errors }
    #             'Forbidden'           { $status_code,       'PermissionDenied', $null }
    #             default               { $status_code,       'NotSpecified',     $null }
    #         }            
            
    #         # Arguments to ErrorRecord constructor (message, errorId, errorCategory, targetObject): https://goo.gl/NTG97M
    #         $e = new-object System.Management.Automation.ErrorRecord $custom_err
    #         throw $e
    #     }

    #     Write-Verbose "401 Returned, trying to refresh token"
    #     Initialize-Session -Password $script:global.RefreshToken -Url $script:global.Url
    #     $p.Headers.Authorization = 'Bearer ' + $script:global.AccessToken
    #     Invoke-RestMethod @p
    # }
}
