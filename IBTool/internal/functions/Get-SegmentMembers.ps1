function Get-SegmentMembers {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True, HelpMessage = "Enter Organization Segment Name.")]
        [String]$SegmentName
    )
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting Organization Segment Members."
    $statusBar.Text = "Running..."
    $array = New-Object System.Collections.ArrayList
    $filter = (Get-OrganizationSegment -Identity $SegmentName).UserGroupFilter
    $array.AddRange( (Get-EXORecipient -Filter $filter -ResultSize Unlimited | Select-Object Name,PrimarySMTPAddress,*recipientType* ) )
    $dataGrid.datasource = $array
    $dataGrid.AutoResizeColumns()
    $MainForm.refresh()
    $statusBar.Text = "Ready. Members found: $($array.count)"
}