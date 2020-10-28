Function Get-AuditLogStatus {
    <#
    .SYNOPSIS
    Function to check Audit log status in the tenant.
    
    .DESCRIPTION
    Function to check Audit log status in the tenant.
    
    .EXAMPLE
    PS C:\> Get-AuditLogStatus
    Function to check Audit log status in the tenant.
    #>
    [cmdletbinding()]
    Param(
        # Parameters
    )
    # Verify Audit Logging is enabled
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Verifing if Audit Logging is enabled."
    if ( -not (Get-AdminAuditLogConfig).UnifiedAuditLogIngestionEnabled ){
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Audit Logging is not enabled. please run 'Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled `$true' and wait at least 1 hour." -DefaultColor Red
        $labelAuditLogStatusValue.ForeColor = "Red"
        $labelAuditLogStatusValue.Text = "False"
    }
    else{
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Audit Logging is enabled." -DefaultColor Green
        $labelAuditLogStatusValue.ForeColor = "Green"
        $labelAuditLogStatusValue.Text = "True"
    }
}