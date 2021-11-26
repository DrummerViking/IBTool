function Remove-OrgSegment
{
	<#
	.SYNOPSIS
	Removes an organization Segment.
	
	.DESCRIPTION
	Removes an organization Segment to be used in Information Barriers.
	
	.PARAMETER Identity
	Defines the Organization Segment Name to be removed.
	
	.PARAMETER Confirm
    If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

    .PARAMETER WhatIf
    If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.
   
	.EXAMPLE
	PS C:\> Remove-OrgSegment -Identity "Manager Users"
	This command will remove the Organization Segment named "Manager Users".
	#>
	[CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Low')]
	Param (
		[String]$Identity
	)
	$statusBarLabel.Text = "Running..."
	try {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Removing Organization Segment '$Identity'."

		Remove-OrganizationSegment -Identity $Identity -Confirm:$false -ErrorAction Stop

		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Successfully removed Organization Segment '$Identity'."
		$statusBarLabel.Text = "Ready. Removed Organization Segment '$Identity'."
	}
	catch {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Something failed to remove the Organization Segment '$Identity'. $_"
		$statusBarLabel.Text = "Ready. Someting failed to remove the Organization Segment '$Identity'. Please see the Powershell window to verify error message."
	}
}
