function Add-ArrayToDataGrid {
    <#
    .SYNOPSIS
    Adds passed data to the DataGrid
    
    .DESCRIPTION
    Adds passed Array data to the DataGrid
    
    .PARAMETER ArrayData
    Array data source to add to the DataGrid

    .PARAMETER DataGrid
    DataGrid object to add the array data.
    
    .PARAMETER Form
    Windows main Form to be refreshed.

    .EXAMPLE
    PS C:\> Add-ArrayToDataGrid -ArrayData $MyData -DataGrid $MyGrid
    Adds array data '$MyData' to the DataGrid '$MyGrid'
    #>
    [CmdletBinding()]
    param (
        [System.Collections.ArrayList]$ArrayData,

        [System.Windows.Forms.DataGridView]$DataGrid,

        [System.Windows.Forms.Form]$Form
    )
    $DataGrid.datasource = $ArrayData
    $DataGrid.AutoResizeColumns()
    $Form.Refresh()
}