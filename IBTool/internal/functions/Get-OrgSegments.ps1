Function Get-OrgSegments {
    <#
    .SYNOPSIS
    This function gets the current Organization Segments in the tenant.
    
    .DESCRIPTION
    This function gets the current Organization Segments in the tenant.
    
    .PARAMETER ShowOutputLine
    Use this switch to show a small output line to Powershell session.

    .EXAMPLE
    PS C:\> Get-OrgSegments
    This function gets the current Organization Segments in the tenant.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [OutputType([System.Collections.ArrayList])]
    [CmdletBinding()]
    Param(
        [Switch]$ShowOutputline
    )
    if ( $ShowOutputline ) { Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting current Organization Segments." }
    $statusBarLabel.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $array.AddRange( (Get-OrganizationSegment | Select-Object Name,UserGroupFilter,CreatedBy,WhenCreated) )

    $statusBarLabel.Text = "Ready. Segments found: $($array.count)"
    return $array
}