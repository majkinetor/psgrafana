function send-request( [HashTable] $Params ) {

    $p = $Params.Clone()

    $p.UseBasicParsing = $true

    if (!$p.Uri)                   { $p.Uri         = $script:Url + '/' + $p.Endpoint }
    if (!$p.Method)                { $p.Method      = 'POST' }
    if (!$p.CotentType)            { $p.ContentType = 'application/json' }
    if (!$p.Headers)               { $p.Headers     = @{} }
    if (!$p.Headers.Authorization) { $p.Headers.Authorization = $script:Authorization }
    
    if ($p.Query) {
        $query = $p.Query.GetEnumerator() | % { if ($_.Value -and $_.Value -ne '') { "{0}={1}" -f $_.Key, $_.Value} } 
        if ($query) { $query = $query -join '&'; $p.Uri += "?$query" }
    }

    $p.Remove('EndPoint')
    $p.Remove('Query')

    if (!$p.Uri.StartsWith('http')) { throw 'Before calling any module function you need to use Initialize-Session' }

    if ( $VerbosePreference -eq 'continue' ) { $p | ConvertTo-Json | Write-Verbose }

    Invoke-RestMethod @p   
}
