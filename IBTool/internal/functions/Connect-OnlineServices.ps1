function Connect-OnlineServices {
    <#
    .SYNOPSIS
    Connect to Online Services.

    .DESCRIPTION
    Connect to MicrosoftTeams, MS Online and AzureAD Online Services.

    .PARAMETER Credential
    Credential to use for the connection.

    .PARAMETER SCC
    Use this switch parameter to connect to Security and Compliance remote powershell.

    .PARAMETER MicrosoftTeams
    Use this switch parameter to connect to MS Teams module.

    .PARAMETER MSOnline
    Use this switch parameter to connect to MS Online module.

    .PARAMETER AzureAD
    Use this switch parameter to connect to Azure AD module.

    .PARAMETER AzureADPreview
    Use this switch parameter to connect to Azure AD Preview module.

    .PARAMETER Azure
    Use this switch parameter to connect to Azure module.

    .PARAMETER Confirm
    If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

    .PARAMETER WhatIf
    If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.
   
    .EXAMPLE
    PS C:\> Connect-OnlineServices
    Connect to Exchange and Azure Online Services.
    
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Low')]
    param(
        [PSCredential]
        $Credential = (Get-Credential -Message "Please specify O365 Global Admin Credentials"),

        [Switch]
        $SCC,

        [Switch]
        $MicrosoftTeams,

        [Switch]
        $MSOnline,

        [Switch]
        $AzureAD,

        [Switch]
        $AzureADPreview,

        [Switch]
        $Azure
    )
    if(-not $Credential){
        $Credential = Get-Credential -Message "Please specify O365 Global Admin Credentials"
    }
    if(-not $Credential){
        Stop-PSFFunction -Message "Credentials entered are invalid." -EnableException $true -Cmdlet $PSCmdlet
    }

    if($Azure){
        Invoke-PSFProtectedCommand -Action "Connecting to Azure" -Target "Azure" -ScriptBlock {
            Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Connecting to Azure"
            Install-Module Azure -Force -ErrorAction Stop
            Import-Module Azure -ErrorAction Stop
        } -EnableException $true -PSCmdlet $PSCmdlet
    }

    if($AzureAD){
        Invoke-PSFProtectedCommand -Action "Connecting to AzureAD" -Target "AzureAD" -ScriptBlock {
            Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Connecting to AzureAD"
            if ( !(Get-Module AzureAD -ListAvailable) -and !(Get-Module AzureAD) ) {
                Install-Module AzureAD -Force -ErrorAction Stop
            }
            try {
                Import-module AzureAD
                $null = Connect-AzureAD -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ( ($_.Exception.InnerException.InnerException.InnerException.InnerException.ErrorCode | ConvertFrom-Json).error -eq 'interaction_required' ) {
                    Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Your are account seems to be requiring MFA to connect to Azure AD. Requesting to authenticate"
                    $null = Connect-AzureAD -AccountId $Credential.UserName.toString() -ErrorAction Stop
                }
                else {
                    return $_
                }
            }
        } -EnableException $true -PSCmdlet $PSCmdlet
    }

    if($AzureADPreview){
        Invoke-PSFProtectedCommand -Action "Connecting to AzureAD Preview" -Target "AzureAD" -ScriptBlock {
            Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Connecting to AzureAD Preview"
            if ( !(Get-Module AzureADPreview -ListAvailable) -and !(Get-Module AzureADPreview) ) {
                Install-Module AzureADPreview -Force -ErrorAction Stop
            }
            try {
                Import-module AzureADPreview
                $null = Connect-AzureAD -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ( ($_.Exception.InnerException.InnerException.InnerException.InnerException.ErrorCode | ConvertFrom-Json).error -eq 'interaction_required' ) {
                    Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Your are account seems to be requiring MFA to connect to Azure AD. Requesting to authenticate"
                    $null = Connect-AzureAD -AccountId $Credential.UserName.toString() -ErrorAction Stop
                }
                else {
                    return $_
                }
            }
        } -EnableException $true -PSCmdlet $PSCmdlet
    }

    if($MSOnline){
        Invoke-PSFProtectedCommand -Action "Connecting to MSOnline" -Target "MSOnline" -ScriptBlock {
            Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Connecting to MSOnline"
            if ( !(Get-Module MSOnline -ListAvailable) -and !(Get-Module MSOnline) ) {
                Install-Module MSOnline -Force -ErrorAction Stop
            }
            try {
                Import-Module MSOnline
                Connect-MsolService -Credential $Credential -ErrorAction Stop
            }
            catch {
                Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Your are account seems to be requiring MFA to connect to MS Online. Requesting to authenticate"
                Connect-MsolService -ErrorAction Stop
            }
        } -EnableException $true -PSCmdlet $PSCmdlet
    }

    if($MicrosoftTeams){
        Invoke-PSFProtectedCommand -Action "Connecting to MicrosoftTeams" -Target "MicrosoftTeams" -ScriptBlock {
            Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Connecting to MicrosoftTeams"
            if ( !(Get-Module MicrosoftTeams -ListAvailable) -and !(Get-Module MicrosoftTeams) ) {
                Install-Module MicrosoftTeams -Force -ErrorAction Stop
            }
            try {
                #Connect to Microsoft Teams
                $null = Connect-MicrosoftTeams -Credential $Credential -ErrorAction Stop

                #Connection to Skype for Business Online and import into Ps session
                $session = New-CsOnlineSession -Credential $Credential -ErrorAction Stop
                $null = Import-PsSession $session
            }
            catch {
                if ( ($_.Exception.InnerException.InnerException.InnerException.InnerException.ErrorCode | ConvertFrom-Json).error -eq 'interaction_required' ) {
                    Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Your are account seems to be requiring MFA to connect to MicrosoftTeams. Requesting to authenticate"
                    #Connect to Microsoft Teams
                    $null = Connect-MicrosoftTeams -ErrorAction Stop

                    #Connection to Skype for Business Online and import into Ps session
                    $session = New-CsOnlineSession -ErrorAction Stop
                    $null = Import-PsSession $session
                }
                else {
                    return $_
                }
            }
        } -EnableException $true -PSCmdlet $PSCmdlet
    }

    if($SCC){
        Invoke-PSFProtectedCommand -Action "Connecting to Security and Compliance" -Target "SCC" -ScriptBlock {
            Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Connecting to Security and Compliance"
            try {
                Connect-IPPSSession -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ( ($_.Exception.InnerException.InnerException.InnerException.InnerException.ErrorCode | ConvertFrom-Json).error -eq 'interaction_required' ) {
                    Write-PSFHostColor -String  "[$((Get-Date).ToString("HH:mm:ss"))] Your are account seems to be requiring MFA to connect to Security and Compliance. Requesting to authenticate"
                    Connect-IPPSSession -UserPrincipalName $Credential.Username.toString() -ErrorAction Stop
                }
                else {
                    return $_
                }
            }
        } -EnableException $true -PSCmdlet $PSCmdlet
    }
}