Function Get-IBPolicies {
    <#
    .SYNOPSIS
    This funciton gets the current Information Barriers Policies in the tenant.
    
    .DESCRIPTION
    This funciton gets the current Information Barriers Policies in the tenant.
    
    .EXAMPLE
    PS C:\> Get-IBPolicies
    This funciton gets the current Information Barriers Policies in the tenant.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    Param(
        # Parameters
    )
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting current Information Barriers Policies."
    $statusBar.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $array.AddRange( (Get-SCCInformationBarrierPolicy | Select-Object Name, State, AssignedSegment, SegmentsAllowed, SegmentsBlocked, block*) )
    $dataGrid.datasource = $array
    $dataGrid.AutoResizeColumns()
    $MainForm.refresh()
    $statusBar.Text = "Ready. IB Policies found: $($array.count)"
}