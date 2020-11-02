Function Get-IBPolicies {
    <#
    .SYNOPSIS
    This function gets the current Information Barriers Policies in the tenant.
    
    .DESCRIPTION
    This function gets the current Information Barriers Policies in the tenant.
    
    .EXAMPLE
    PS C:\> Get-IBPolicies
    This function gets the current Information Barriers Policies in the tenant.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [OutputType([System.Collections.ArrayList])]
    [CmdletBinding()]
    Param(
        # Parameters
    )
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting current Information Barriers Policies."
    $statusBar.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $array.AddRange( (Get-InformationBarrierPolicy | Select-Object Name, State, AssignedSegment, SegmentsAllowed, SegmentsBlocked, block*) )
    $statusBar.Text = "Ready. IB Policies found: $($array.count)"
    return $array
}