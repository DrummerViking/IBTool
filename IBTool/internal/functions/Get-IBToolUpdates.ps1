Function Get-IBToolUpdates {
    <#
    .SYNOPSIS
    Short description
    
    .DESCRIPTION
    Long description
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
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