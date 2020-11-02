function New-IBServicePrincipal {
    <#
    .SYNOPSIS
    This function creates a new Information Barriers Service Principal in the tenant.
    
    .DESCRIPTION
    This function creates a new Information Barriers Service Principal in the tenant.

    .PARAMETER Confirm
    If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

    .PARAMETER WhatIf
    If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

    .EXAMPLE
    PS C:\> New-IBServicePrincipal
    This function creates a new Information Barriers Service Principal in the tenant.

    #>
    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Low')]
    param (
        # Parameters
    )
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Creating new Information Barriers Service Principal in AzureAD."
    $newSP = New-AzureADServicePrincipal -AppId "bcf62038-e005-436d-b970-2a472f8c1982"
    Start-Process "https://login.microsoftonline.com/common/adminconsent?client_id=$($newSp.appId)"
    
    # Refresh IB Service Principal Status
    Get-IBServicePrincipal
    $MainForm.Controls.RemoveByKey("NewServicePrincipal")
    $MainForm.Refresh()

    <#
    $AdminObjectId = (get-AzureAdUser -searchstring (Get-AzureADCurrentSessionInfo).Account).ObjectId

    if ( -not (Get-AzureADServiceAppRoleAssignment -ObjectId $newsp.ObjectId -All:$true | Where-Object {$_.PrincipalId -eq $AdminObjectId}) ){
        $AppRoleAssignment = $newSP | New-AzureADServiceAppRoleAssignment -PrincipalId $AdminObjectId -ResourceId $newSP.ObjectId -id "00000000-0000-0000-0000-000000000000" -ErrorAction Stop
    }

    if ( -not (Get-AzureADServicePrincipalOAuth2PermissionGrant -ObjectId $newSP.ObjectId -All:$True) ){
        $TenantId = (Get-AzureADTenantDetail).objectid

        $result = Login-AzAccount -Credential $credential -ErrorAction Stop
        $context = Get-AzContext
        $refreshToken = @($context.TokenCache.ReadItems() | Where-Object {$_.tenantId -eq $tenantId -and $_.ExpiresOn -gt (Get-Date)}).AccessToken
        $body = "grant_type=refresh_token&refresh_token=$($refreshToken)&resource=$($newsp.ObjectId)"
        $apiToken = Invoke-RestMethod "https://login.windows.net/$tenantId/oauth2/token" -Method POST -Body $body -ContentType 'application/x-www-form-urlencoded' -ErrorAction Stop
        $header = @{
            'Authorization' = 'Bearer ' + $apiToken.access_token
            'X-Requested-With'= 'XMLHttpRequest'
            'x-ms-client-request-id'= [guid]::NewGuid()
            'x-ms-correlation-id' = [guid]::NewGuid()}
        $url = "https://main.iam.ad.ext.azure.com/api/RegisteredApplications/$($newSP.AppId)/Consent?onBehalfOfAll=true"
        Invoke-RestMethod –Uri $url –Headers $header –Method POST -ErrorAction Stop
    }
    #>
}