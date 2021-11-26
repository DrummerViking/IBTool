function Start-IBpolicyApp {
	<#
	.SYNOPSIS
	Function to start Information Barrier Policies application to users
	
	.DESCRIPTION
	Function to start Information Barrier Policies application to users.
	Allow 30 minutes for the system to start applying the policies. The system applies policies user by user. The system processes about 5,000 user accounts per hour.
	
	.PARAMETER Confirm
    If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

    .PARAMETER WhatIf
    If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.
   
	.EXAMPLE
	PS C:\> Start-IBpolicyApp
	Executes Start-InformationBarrierPoliciesApplication

	#>
	[CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Low')]
	Param (
		# Parameters
	)
	$statusBarLabel.Text = "Running..."
	try {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Setting all IB Policies status to 'Active'."
		Get-InformationBarrierPolicy | ForEach-Object { Set-InformationBarrierPolicy -Identity $_.name -State active -Confirm:$false -force -WarningAction SilentlyContinue }
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Starting to apply Information Barrier Policies application."
		Start-InformationBarrierPoliciesApplication -ErrorAction Stop
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Started successfully. Allow 30 minutes for the system to start applying the policies. The system applies policies user by user. The system processes about 5,000 user accounts per hour."
		$statusBarLabel.Text = "Ready. Started successfully."
	}
	catch {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Something failed to start applying Information Barrier Policies application. $_"
	}
}
