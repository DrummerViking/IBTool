function Get-SegmentMembers {
    <#
    .SYNOPSIS
    This function gets the current Organization Segment members.

    .DESCRIPTION
    This function gets the current Organization Segment members for the specified Segment.

    .PARAMETER SegmentName
    Defines the Organization Segment name.

    .PARAMETER ShowOutputLine
    Use this switch to show a small output line to Powershell session.
    

    .EXAMPLE
    PS C:\> Get-SegmentMembers -SegmentName "HR Members"
    Gets the current members for the Organization Segment named 'HR Members'.

    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [OutputType([System.Collections.ArrayList])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True, HelpMessage = "Enter Organization Segment Name.")]
        [String]$SegmentName,

        [Switch]$ShowOutputline
    )
    if ( $ShowOutputline ) { Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting Organization Segment Members." }
    $statusBar.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $filter = (Get-OrganizationSegment -Identity $SegmentName).UserGroupFilter
    try { $array.AddRange( (Get-EXORecipient -Filter $filter -ResultSize Unlimited | Select-Object Name,PrimarySMTPAddress,*recipientType* ) ) }
    catch {
        $null = Write-PSFHostColor -String "$_"
    }

    $statusBar.Text = "Ready. Members found: $($array.count)"
    return $array
}