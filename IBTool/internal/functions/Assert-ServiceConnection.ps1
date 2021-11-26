function Assert-ServiceConnection {
    <#
    .SYNOPSIS
    Checks current connection status for SCC, EXO and AzureAD
    
    .DESCRIPTION
    Checks current connection status for SCC, EXO and AzureAD

    .EXAMPLE
    PS C:\> Assert-ServiceConnection
    Checks current connection status for SCC, EXO and AzureAD
    #>
    [CmdletBinding()]
    param (
        # Parameters
    )
    $Sessions = Get-PSSession
    $ServicesToConnect = New-Object -TypeName "System.Collections.ArrayList"

    # Check if SCC connection
    if ( -not ($Sessions.ComputerName -match "ps.compliance.protection.outlook.com") ) { $null = $ServicesToConnect.add("SCC") }

    # Check if EXO connection
    if ( $Sessions.ComputerName -notcontains "outlook.office365.com" ) { $null = $ServicesToConnect.add("EXO") }

    # Connecting to AzAccount
    $azContext = Get-AzContext
    if ( -not($null -eq $azContext) ) {
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Azure context is connected with: $($azcontext.Account). If it is not correct, click on the button 'Change AzContext Account'" -DefaultColor Yellow
    }
    else {
        $null = $ServicesToConnect.add("AzAccount")
    }
    
    return $ServicesToConnect
}