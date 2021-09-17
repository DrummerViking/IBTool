function Get-ModuleUpdate
{
	[CmdletBinding()]
	Param (
		# parameters
	)
	$script:ModuleRoot = $PSScriptRoot
	$ModuleFileName = (Import-PowerShellDataFile -Path "$($script:ModuleRoot)\IBTool.psd1").RootModule
	$ModuleName = $ModuleFileName.Substring(0,$ModuleFileName.IndexOf("."))
	$script:ModuleVersion = (Import-PowerShellDataFile -Path "$($script:ModuleRoot)\IBTool.psd1").ModuleVersion

	$GalleryModule = Find-Module -Name $ModuleName -Repository PSGallery
	if ( 2.0.1 -lt $GalleryModule.version ) {
		$bt = New-BTButton -Content "Get Update" -Arguments "https://github.com/agallego-css/IBTool#installation"
		New-BurntToastNotification -Text 'IBTool Update found', 'There is a new version of this module available.' -Button $bt
	}
}
