function Assert-EXOConnection
{
<#
    .SYNOPSIS
        Asserts a valid Exchange Online connection has been established.
    
    .DESCRIPTION
        Asserts a valid Exchange Online has been established.
    
    .PARAMETER Cmdlet
        The $PSCmdlet variable of the calling command.
    
    .EXAMPLE
        PS C:\> Assert-EXOConnection -Cmdlet $PSCmdlet
        Asserts a valid graph connection has been established.
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Cmdlet
    )
    
    process
    {
        # Getting current PS Sessions
        $Sessions = Get-PSSession
        if ($Sessions.ComputerName -eq "outlook.office365.com") { return }
        
        $exception = [System.InvalidOperationException]::new('Not yet connected to ExchangeOnline. Use Connect-ExchangeOnline to establish a connection!')
        $errorRecord = [System.Management.Automation.ErrorRecord]::new($exception, "NotConnected", 'InvalidOperation', $null)
        
        $Cmdlet.ThrowTerminatingError($errorRecord)
    }
}