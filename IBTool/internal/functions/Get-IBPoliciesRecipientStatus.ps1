function Get-IBPoliciesRecipientStatus {
    <#
    .SYNOPSIS
    This function gets the current Information Barrier Recipient status.
    
    .DESCRIPTION
    This function gets the current Information Barrier Recipient status between 2 users.
    
    .PARAMETER User1
    Defines the first user identity to compare.
    You can use any value that uniquely identifies each user, such as name, alias, distinguished name, canonical domain name, email address, or GUID.

    .PARAMETER User2
    Defines the second user identity to compare.
    You can use any value that uniquely identifies each user, such as name, alias, distinguished name, canonical domain name, email address, or GUID.
    
    .PARAMETER ShowOutputLine
    Use this switch to show a small output line to Powershell session.
    
    .EXAMPLE
    PS C:\> Get-IBPoliciesRecipientStatus -User1 "john@contoso.com" -User2 "mark@contoso.com"
    This function gets the current Information Barrier Recipient status between john@contoso.com and mark@contoso.com.
    
    #>
    [OutputType([System.Collections.ArrayList])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Defines the first user identity to compare.")]
        [string]$user1,

        [Parameter(Mandatory = $true, HelpMessage = "Defines the second user identity to compare.")]
        [string]$user2,

        [Switch]$ShowOutputline
    )
    if ( $ShowOutputline ) { Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting current information Barrier Recipient status between $user1 and $user2." }
    $statusBar.Text = "Running..."
    #$array = New-Object System.Collections.ArrayList
    $array = New-Object System.Collections.ArrayList
    $SegmentsFound1 = New-Object System.Collections.ArrayList
    $SegmentsFound2 = New-Object System.Collections.ArrayList
    $AllSegments = get-OrgSegments
    foreach ($segment in $AllSegments){
        $Members = Get-SegmentMembers -SegmentName $segment.name
        if ( $Members.PrimarySMTPAddress -eq $user1 ) { $null = $SegmentsFound1.add($segment) }
        if ( $Members.PrimarySMTPAddress -eq $user2 ) { $null = $SegmentsFound2.add($segment) }
    }
    $matchedPolicies = Get-IBPolicies | Where-Object { $_.AssignedSegment -eq $SegmentsFound1.name -and ($_.SegmentsAllowed -match $SegmentsFound2.name -or $_.SegmentsBlocked -match $SegmentsFound2.name)}
    $matchedPolicies | ForEach-Object { $null = $array.Add( $_ ) }

    $statusBar.Text = "Ready. Matched: $($array.count)"
    return $array
}