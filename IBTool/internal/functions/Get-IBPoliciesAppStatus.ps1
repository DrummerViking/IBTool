Function Get-IBPoliciesAppStatus {
    <#
    .SYNOPSIS
    This function will get the current Information Barriers Policies Application Status.
    
    .DESCRIPTION
    This function will get the current Information Barriers Policies Application Status.
    
    .EXAMPLE
    PS C:\> Get-IBPoliciesAppStatus
    This function will get the current Information Barriers Policies Application Status.

    #>
    [CmdletBinding()]
    param (
        # Parameters
    )
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting current Information Barriers Policies Application status."
    $statusBar.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $results = Get-InformationBarrierPoliciesApplicationStatus -All:$true | Select-Object ApplicationStartTime, ApplicationEndTime, Status, PercentProgress
    $results | ForEach-Object { $null = $array.Add($_) }
    $statusBar.Text = "Ready."
    return $array
}