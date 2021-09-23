function Get-UnifiedLog {
	<#
	.SYNOPSIS
	Function to get Unified audit logs for InformationBarrierPolicyApplication.
	
	.DESCRIPTION
	Function to get Unified audit logs for InformationBarrierPolicyApplication.
	
	.PARAMETER StartDate
	Date to search audit logs from.
	
	.PARAMETER EndDate
	Date to search audit logs until.
	
	.PARAMETER AppId
	InformationBarrierPolicyApplication Identity to search audits for.
	
	.EXAMPLE
	PS C:\> Get-UnifiedLog -StartDate "01/19/2021" -EndDate "02/19/2021" -AppId "74c593f9-beca-45a2-b77e-cbf36fcfbd81"

	The function will search for all logs about InformationBarrierPolicyApplication related to AppId "74c593f9-beca-45a2-b77e-cbf36fcfbd81" between "01/19/2021" and "02/19/2021".
	#>
	[OutputType([System.Collections.ArrayList])]
	[CmdletBinding()]
	Param (
		[datetime]$StartDate,
		[datetime]$EndDate,
		[String]$AppId
	)
	Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Searching Unified Audit Logs."
	$statusBar.Text = "Running..."
	
	$records = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType InformationBarrierPolicyApplication -ResultSize 5000 -ObjectIds $AppId
	if ($null -ne $records) {
		$array = New-Object System.Collections.ArrayList
		$array.AddRange( ($records.auditdata | convertfrom-json | Select-Object CommandId, CommandStarted, CommandType, CreationTime, EndTime, GalChangeType, Id, ObjectId, Operation, OrganizationId, policyChangeType, recipientId, RecordType, StartTime, UserId, UserKey, UserType, Version, Workload) )
		$statusBar.Text = "Ready. Records found: $($records.Count)"
		return $array
	}
	else {
		$statusBar.Text = "Ready. No records found"
	}
}
