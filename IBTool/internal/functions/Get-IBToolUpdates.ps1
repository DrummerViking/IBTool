Function Get-IBToolUpdates {
    <#
    .SYNOPSIS
    Function to get and fetch updates for the IBTool Module.
    
    .DESCRIPTION
    Function to get and fetch updates for the IBTool Module.
    
    .EXAMPLE
    PS C:\> Get-IBToolUpdates
    Will get the current module version from PowershellGallery, and if newer, will download and update it.
    
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    Param(
        #Parameters
    )
    $currentModule = Get-Module IBTool
    $foundModule = Find-Module IBTool
    if ( $foundModule.Version -gt $currentModule.Version ) {
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Updated tool's version detected. Will attempt to download and install it."
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] The tool should re run again in the newer version."

        Update-Module IBTool -Force
        Remove-Module IBTool
        Import-Module IBTool
        Start-IBTool
    }
    else {
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] No updates found. You have the latest version installed."
    }
}