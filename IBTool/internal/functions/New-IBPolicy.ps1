function New-IBPolicy
{
	<#
	.SYNOPSIS
	Creates a new Information Barrier policy.
	
	.DESCRIPTION
	Creates a new Information Barrier policy.
	
	.PARAMETER PolicyName
	Defines the Information Barrier Policy Name.
	
	.PARAMETER AssignedSegment
	Defines the assigned segment to the policy.
	
	.PARAMETER AssignedAction
	Defines the Policy action to Allow or Block to other segments.
	
	.PARAMETER AorBSegments
	Defines the segment(s) to be Allowed or Blocked in the policy.
	
	.EXAMPLE
	PS C:\> New-IBPolicy -PolicyName "Allowed HR to Sales" -AssignedSegment "HR" -AssignedAction "SegmentsAllowed" -AorBSegments "Sales"
	This function will create the new Information Barrier policy named "Allowed HR to Sales" allowing communications to "Sales" team.

	#>
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true, HelpMessage = "Defines the Information Barrier Policy Name.")]
		[String]$PolicyName,

		[Parameter(Mandatory = $true, HelpMessage = "Defines the assigned segment to the policy.")]
		[String]$AssignedSegment,

		[ValidateSet('SegmentsAllowed','SegmentsBlocked')]
		[Parameter(Mandatory = $true, HelpMessage = "Defines the Policy action to Allow or Block to other segments.")]
		[String]$AssignedAction,

		[Parameter(Mandatory = $true, HelpMessage = "Defines the segment(s) to be Allowed or Blocked in the policy.")]
		[String]$AorBSegments
	)
	$statusBar.Text = "Running..."
	try {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Creating new Information Barrier Policy '$PolicyName'."
		$segmentsList = New-Object System.Collections.ArrayList
		$List = $AorBSegments.replace("'",'').split(",")
		foreach ($item in $list) { $null = $segmentsList.add($item.Trim() ) }

		if ($AssignedAction -eq "SegmentsAllowed") {
			$null = $segmentsList.add( $AssignedSegment )
			New-InformationBarrierPolicy -Name $PolicyName -AssignedSegment $AssignedSegment -SegmentsAllowed $segmentsList -State Inactive -Confirm:$False -ErrorAction Stop
		}
		else {
			New-InformationBarrierPolicy -Name $PolicyName -AssignedSegment $AssignedSegment -SegmentsBlocked $segmentsList -State Inactive -Confirm:$False -ErrorAction Stop
		}
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Successfully created Information Barrier Policy '$PolicyName'."
		$statusBar.Text = "Ready. Created Information Barrier Policy '$PolicyName'."
	}
	catch {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Something failed to create the new Information Barrier Policy '$PolicyName'. $_"
		$statusBar.Text = "Ready. Someting failed to create the new Information Barrier Policy '$PolicyName'. Please see the Powershell window to verify error message."
	}
}