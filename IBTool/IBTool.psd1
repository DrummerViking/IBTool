@{
	# Script module or binary module file associated with this manifest
	RootModule = 'IBTool.psm1'
	
	# Version number of this module.
	ModuleVersion = '2.0.5'
	
	# ID used to uniquely identify this module
	GUID = '02adbc63-ac2f-46e0-bbc4-32a47b561894'
	
	# Author of this module
	Author = 'Agustin Gallegos'
	
	# Company or vendor of this module
	CompanyName = 'Microsoft'
	
	# Copyright statement for this module
	Copyright = 'Copyright (c) 2020 Agustin Gallegos'
	
	# Description of the functionality provided by this module
	Description = 'This tool is intended to easily help on managing Information Barriers in Microsoft Teams'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '5.1'
	
	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules = @(
		@{ ModuleName='PSFramework'; ModuleVersion='1.5.170' }
		#@{ ModuleName='AzureAD'; ModuleVersion='2.0.2.135' }
		@{ ModuleName='ExchangeOnlineManagement'; ModuleVersion='2.0.3'}
	)
	
	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @('bin\IBTool.dll')
	
	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @('xml\IBTool.Types.ps1xml')
	
	# Format files (.ps1xml) to be loaded when importing this module
	# FormatsToProcess = @('xml\IBTool.Format.ps1xml')
	
	# Functions to export from this module
	FunctionsToExport = 'Start-IBTool'
	
	# Cmdlets to export from this module
	CmdletsToExport = ''
	
	# Variables to export from this module
	VariablesToExport = ''
	
	# Aliases to export from this module
	AliasesToExport = ''
	
	# List of all modules packaged with this module
	ModuleList = @()
	
	# List of all files packaged with this module
	FileList = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			# Tags = @()
			
			# A URL to the license for this module.
			LicenseUri = 'https://github.com/agallego-css/IBTool/blob/main/LICENSE'
			
			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/agallego-css/IBTool'
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			# ReleaseNotes = ''
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}