Function Get-IBPoliciesAppStatus {
    <#
    .SYNOPSIS
    This function will get the current Information Barriers Policies Application Status.
    
    .DESCRIPTION
    This function will get the current Information Barriers Policies Application Status.
    
    .PARAMETER ShowOutputLine
    Use this switch to show a small output line to Powershell session.

    .EXAMPLE
    PS C:\> Get-IBPoliciesAppStatus
    This function will get the current Information Barriers Policies Application Status.

    #>
    [OutputType([System.Collections.ArrayList])]
    [CmdletBinding()]
    param (
        [Switch]$ShowOutputline
    )
    if ( $ShowOutputline ) { Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting current Information Barriers Policies Application status." }
    $statusBar.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $results = Get-InformationBarrierPoliciesApplicationStatus -All:$true | Select-Object Identity, ApplicationStartTime, ApplicationEndTime, Status, PercentProgress
    $results | ForEach-Object { $null = $array.Add($_) }
    $statusBar.Text = "Ready."
    return $array
}