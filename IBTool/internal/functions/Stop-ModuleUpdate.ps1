Function Stop-ModuleUpdate {
    <#
    .SYNOPSIS
    Function to stop checking for updates on this module and clear runspaces.
    
    .DESCRIPTION
    Function to stop checking for updates on this module and clear runspaces.
    
    .PARAMETER RunspaceData
    Runspace data retrieved from intial Start-ModuleUpdate function.
    
    .EXAMPLE
    PS C:\> Stop-ModuleUpdate -RunspaceData $data
    Runs the function to stop checking for update on this module and clear runspaces.
    #>
    [CmdletBinding()]
    Param(
        $RunspaceData
    )
    # Receive Results and cleanup
	$null = $RunspaceData.Pipe.EndInvoke($RunspaceData.Status)
	$RunspaceData.Pipe.Dispose()

	# Cleanup Runspace Pool
	$RunspaceData.pool.Close()
	$RunspaceData.pool.Dispose()
}