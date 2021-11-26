function Remove-IBPolicy
{
	<#
	.SYNOPSIS
	Removes an Information Barrier Policy.
	
	.DESCRIPTION
	Removes an Information Barrier Policy to be used in Information Barriers.
	
	.PARAMETER Identity
	Defines the Information Barrier Policy Name to be removed.
	
	.PARAMETER Confirm
    If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

    .PARAMETER WhatIf
    If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.
   
	.EXAMPLE
	PS C:\> Remove-IBPolicy -Identity "Manager Users"
	This command will remove the Information Barrier Policy named "Manager Users".
	#>
	[CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Low')]
	Param (
		[String]$Identity
	)
	$statusBarLabel.Text = "Running..."
	try {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Removing Information Barrier Policy '$Identity'."

		Remove-InformationBarrierPolicy -Identity $Identity -Confirm:$false -ErrorAction Stop

		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Successfully removed Information Barrier Policy '$Identity'."
		$statusBarLabel.Text = "Ready. Removed Information Barrier Policy '$Identity'."
	}
	catch {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Something failed to remove the Information Barrier Policy '$Identity'. $_"
		$statusBarLabel.Text = "Ready. Someting failed to remove the Information Barrier Policy '$Identity'. Please see the Powershell window to verify error message."
	}
}
