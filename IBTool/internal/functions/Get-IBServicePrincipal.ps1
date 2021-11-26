function Get-IBServicePrincipal {
    <#
    .SYNOPSIS
    This function gets the current Information Barriers Service Principal in the tenant.
    
    .DESCRIPTION
    This function gets the current Information Barriers Service Principal in the tenant.
    
    .EXAMPLE
    PS C:\> Get-IBServicePrincipal
    This function gets the current Information Barriers Service Principal in the tenant.
    #>
    [CmdletBinding()]
    param (
        # Parameters
    )
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting Information Barriers Service Principal."
    #$Sp = Get-AzureADServicePrincipal -All:$True | Where-Object appid -eq "bcf62038-e005-436d-b970-2a472f8c1982"
    $Sp = Get-AzADServicePrincipal | Where-Object ApplicationId -eq "bcf62038-e005-436d-b970-2a472f8c1982"
    if ($null -eq $sp) {
        $labelIBServicePrincipalValue.ForeColor = "Red"
        $labelIBServicePrincipalValue.Text = "False"
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Information Barriers Service Principal not found." -DefaultColor "Red"

        $buttonChangeAzContext = New-Object System.Windows.Forms.Button
        $buttonChangeAzContext.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonChangeAzContext.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonChangeAzContext.Location = New-Object System.Drawing.Point(270,78)
        $buttonChangeAzContext.Size = New-Object System.Drawing.Size(250,25)
        $buttonChangeAzContext.Name = "NewServicePrincipal"
        $buttonChangeAzContext.Text = "Add Service Principal and Grant consent"
        $buttonChangeAzContext.UseVisualStyleBackColor = $True
        $buttonChangeAzContext.add_Click({New-IBServicePrincipal})
        $MainForm.Controls.Add($buttonChangeAzContext)
    }
    else{
        $labelIBServicePrincipalValue.ForeColor = "Green"
        $labelIBServicePrincipalValue.text = "True"
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Information Barriers Service Principal found." -DefaultColor "Green"
    }
}