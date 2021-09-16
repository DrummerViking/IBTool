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

    # Check if AzureADPreview is present
    if (Get-module "AzureADPreview" -ListAvailable ) {
        Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] 'AzureADPreview' module is not supported. Please remove it and install 'AzureAD' only."
        break
    }

    # Check if AzureAD connection
    try{
        $Null = Get-AzureADCurrentSessionInfo -ErrorAction Stop
    }
    catch {
        $null = $ServicesToConnect.add("AzureAD")
    }
    return $ServicesToConnect
}