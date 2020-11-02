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
    
    .EXAMPLE
    PS C:\> Get-IBPoliciesRecipientStatus -User1 "john@contoso.com" -User2 "mark@contoso.com"
    This function gets the current Information Barrier Recipient status between john@contoso.com and mark@contoso.com.
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Defines the first user identity to compare.")]
        [string]$user1,

        [Parameter(Mandatory = $true, HelpMessage = "Defines the second user identity to compare.")]
        [string]$user2
    )
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting current information Barrier Recipient status between $user1 and $user2."
    $statusBar.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $array.AddRange( (Get-InformationBarrierRecipientStatus -Identity $user1 -Identity2 $user2 -WarningAction SilentlyContinue) )
    $statusBar.Text = "Ready. Segments found: $($array.count)"
    return $array
}