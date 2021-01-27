function Start-IBpolicyApp
{
	<#
	.SYNOPSIS
	Function to start Information Barrier Policies application to users
	
	.DESCRIPTION
	Function to start Information Barrier Policies application to users.
	Allow 30 minutes for the system to start applying the policies. The system applies policies user by user. The system processes about 5,000 user accounts per hour.
	
	.EXAMPLE
	PS C:\> Start-IBpolicyApp
	Executes Start-InformationBarrierPoliciesApplication

	#>
	[CmdletBinding()]
	Param (
		# Parameters
	)
	$statusBar.Text = "Running..."
	try {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Starting to apply Information Barrier Policies application."
		Start-InformationBarrierPoliciesApplication -ErrorAction Stop
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Started successfully. Allow 30 minutes for the system to start applying the policies. The system applies policies user by user. The system processes about 5,000 user accounts per hour."
		$statusBar.Text = "Ready. Started successfully."
	}
	catch {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Something failed to start applying Information Barrier Policies application. $_"
	}
}
