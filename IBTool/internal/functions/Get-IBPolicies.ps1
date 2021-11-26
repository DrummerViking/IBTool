Function Get-IBPolicies {
    <#
    .SYNOPSIS
    This function gets the current Information Barriers Policies in the tenant.
    
    .DESCRIPTION
    This function gets the current Information Barriers Policies in the tenant.

    .PARAMETER ShowOutputLine
    Use this switch to show a small output line to Powershell session.
    
    .EXAMPLE
    PS C:\> Get-IBPolicies
    This function gets the current Information Barriers Policies in the tenant.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [OutputType([System.Collections.ArrayList])]
    [CmdletBinding()]
    Param(
        [Switch]$ShowOutputline
    )
    if ( $ShowOutputline ) { Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting current Information Barriers Policies." }
    $statusBarLabel.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $array.AddRange( (Get-InformationBarrierPolicy | Select-Object Name, State, AssignedSegment, SegmentsAllowed, SegmentsBlocked, block*) )
    $statusBarLabel.Text = "Ready. IB Policies found: $($array.count)"
    return $array
}