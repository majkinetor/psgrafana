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

    Invoke-RestMethod @p   
}
