Function Start-IBTool {
    <#
    .SYNOPSIS
    Function to start the 'Information Barriers' tool.
    
    .DESCRIPTION
    Function to start the 'Information Barriers' tool.
    
    .PARAMETER Credential
    Credential to use for the connection.

    .PARAMETER Confirm
    If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

    .PARAMETER WhatIf
    If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

    .EXAMPLE
    PS C:\> Start-IBTool
    This command will launch the 'Information Barriers' GUI tool.
    #>
    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Low')]
    param (
        [PSCredential]
        $Credential = (Get-Credential -Message "Please specify O365 Global Admin Credentials")
    )

    # Connecting to online modules
    Connect-OnlineServices -Credential $Credential -SCC

    #region Import the Assemblies
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName Microsoft.VisualBasic
    [System.Windows.Forms.Application]::EnableVisualStyles()
    #endregion
}