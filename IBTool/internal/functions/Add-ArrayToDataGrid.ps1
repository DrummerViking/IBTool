function Add-ArrayToDataGrid {
    <#
    .SYNOPSIS
    Adds passed data to the DataGrid
    
    .DESCRIPTION
    Adds passed Array data to the DataGrid
    
    .PARAMETER Array
    Array data source to add to the DataGrid

    .PARAMETER DataGrid
    DataGrid object to add the array data.
    
    .PARAMETER Form
    Windows main Form to be refreshed.

    .EXAMPLE
    PS C:\> Add-ArrayToDataGrid -Array $MyData -DataGrid $MyGrid
    Adds array data '$MyData' to the DataGrid '$MyGrid'
    #>
    [CmdletBinding()]
    param (
        $Array,

        $DataGrid,

        $Form
    )
    $DataGrid.datasource = $array
    $DataGrid.AutoResizeColumns()
    $Form.Refresh()
}