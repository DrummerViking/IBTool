Function Stop-ModuleUpdate {
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