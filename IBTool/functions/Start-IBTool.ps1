Function Start-IBTool {
    <#
    .SYNOPSIS
    Function to start the 'Information Barriers' tool.
    
    .DESCRIPTION
    Function to start the 'Information Barriers' tool.
    
    .PARAMETER Credential
    Credential to use for the connection.

    .EXAMPLE
    PS C:\> Start-IBTool
    This command will launch the 'Information Barriers' GUI tool.
    #>
    [CmdletBinding()]
    param (
        [PSCredential]
        $Credential = (Get-Credential -Message "Please specify O365 Global Admin Credentials")    
    )

    # Connecting to online modules
    Connect-OnlineServices -Credential $Credential -MicrosofTeams
}