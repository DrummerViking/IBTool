Function Start-ModuleUpdate {
	<#
	.SYNOPSIS
	Function to check for updates
	
	.DESCRIPTION
	Function to check for updates
	
	.PARAMETER ModuleRoot
	Modules root path.
	
	.EXAMPLE
	PS C:\> Get-ModuleUpdate -ModuleRoot "C:\Temp"
	Runs the function to check for update for current module in "C:\Temp"
	#>
	Param (
		[String]$ModuleRoot
	)

	$ScriptBlock = {
		Param (
			[String]$ModuleRoot
		)
		$ModuleFileName = (Import-PowerShellDataFile -Path "$((Get-ChildItem -Path $ModuleRoot -Filter *.psd1).Fullname)").RootModule
		$ModuleName = $ModuleFileName.Substring(0,$ModuleFileName.IndexOf("."))
		$script:ModuleVersion = (Import-PowerShellDataFile -Path "$((Get-ChildItem -Path $ModuleRoot -Filter *.psd1).Fullname)").ModuleVersion -as [version]

		$GalleryModule = Find-Module -Name $ModuleName -Repository PSGallery
		if ( $script:ModuleVersion -lt $GalleryModule.version ) {
			$bt = New-BTButton -Content "Get Update" -Arguments "https://github.com/agallego-css/$ModuleName#installation"
			New-BurntToastNotification -Text 'IBTool Update found', 'There is a new version of this module available.' -Button $bt
		}
	}

	# Create Runspace, set maximum threads
	$pool = [RunspaceFactory]::CreateRunspacePool(1, 1)
	$pool.ApartmentState = "MTA"
	$pool.Open()

	$runspace = [PowerShell]::Create()
	$runspace.Runspace.Name = "$ModuleName.Update"
	$null = $runspace.AddScript( $ScriptBlock )
	$null = $runspace.AddArgument( $ModuleRoot )
	$runspace.RunspacePool = $pool
	
	[PSCustomObject]@{
		Pipe = $runspace
		Status = $runspace.BeginInvoke()
		Pool = $pool
	}
}