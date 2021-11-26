function New-OrgSegment
{
	<#
	.SYNOPSIS
	Creates a new organization Segment.
	
	.DESCRIPTION
	Creates a new organization Segment to be used in Information Barriers.
	
	.PARAMETER Name
	Defines the Organization Segment Name.
	
	.PARAMETER GroupFilter
	Defines the User Group filter attribute to be use.
	
	.PARAMETER Comparison
	Defines the condition's comparison. Can be "Equals" or "Not Equals".
	
	.PARAMETER AttributeValue
	Defines the attribute value.
	
	.PARAMETER Confirm
    If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

    .PARAMETER WhatIf
    If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.
   
	.EXAMPLE
	PS C:\> New-OrgSegment -Name "test users" -GroupFilter "Company" -Comparison "equals" -AttributeValue "Contoso.com"
	This command will create the new Organization Segment named "Test users" based on the "Company" user's attribute, being Equals to "Contoso.com".
	#>
	[CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Low')]
	Param (
		[Parameter(Mandatory = $true, HelpMessage = "Defines the Organization Segment Name.")]
		[String]$Name,

		[Parameter(Mandatory = $true, HelpMessage = "Defines the User Group filter attribute to be use.")]
		[String]$GroupFilter,

		[Parameter(Mandatory = $true, HelpMessage = "Defines the condition comparison.")]
		[String]$Comparison,

		[Parameter(Mandatory = $true, HelpMessage = "Defines the attribute value.")]
		[String]$AttributeValue
	)
	if ($Comparison -eq "Equals") {$comp = "eq"}
	else {$comp = "ne"}

	$statusBarLabel.Text = "Running..."
	try {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Creating / editing Organization Segment '$Name'."
		if ( Get-OrganizationSegment -identity $Name ) {
			Set-OrganizationSegment -identity $name -UserGroupFilter "$GroupFilter -$comp '$AttributeValue'" -ErrorAction Stop
		}
		else {
			New-OrganizationSegment -Name $Name -UserGroupFilter "$GroupFilter -$comp '$AttributeValue'" -errorAction Stop
		}
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Successfully created / modified Organization Segment '$Name'."
		$statusBarLabel.Text = "Ready. Created / edited Organization Segment '$Name'."
	}
	catch {
		Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Something failed to create / edit the Organization Segment '$Name'. $_"
		$statusBarLabel.Text = "Ready. Someting failed to create / edit the Organization Segment '$Name'. Please see the Powershell window to verify error message."
	}
}