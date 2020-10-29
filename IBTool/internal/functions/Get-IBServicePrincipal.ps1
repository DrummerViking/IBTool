function Get-IBServicePrincipal {
    <#
    .SYNOPSIS
    This funciton gets the current Information Barriers Service Principal in the tenant.
    
    .DESCRIPTION
    This funciton gets the current Information Barriers Service Principal in the tenant.
    
    .EXAMPLE
    PS C:\> Get-IBServicePrincipal
    This funciton gets the current Information Barriers Service Principal in the tenant.
    #>
    [CmdletBinding()]
    param (
        # Parameters
    )
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Getting Information Barriers Service Principal."
    $Sp = Get-AzureADServicePrincipal -All:$True | Where-Object appid -eq "bcf62038-e005-436d-b970-2a472f8c1982"
    if ($null -eq $sp) {
        $labelIBServicePrincipalValue.ForeColor = "Red"
        $labelIBServicePrincipalValue.Text = "False"
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Information Barriers Service Principal not found." -DefaultColor "Red"

        $buttonNewServicePrincipal = New-Object System.Windows.Forms.Button
        $buttonNewServicePrincipal.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonNewServicePrincipal.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonNewServicePrincipal.Location = New-Object System.Drawing.Point(270,57)
        $buttonNewServicePrincipal.Size = New-Object System.Drawing.Size(250,25)
        $buttonNewServicePrincipal.TabIndex = 17
        $buttonNewServicePrincipal.Name = "NewServicePrincipal"
        $buttonNewServicePrincipal.Text = "Add Service Principal and Grant consent"
        $buttonNewServicePrincipal.UseVisualStyleBackColor = $True
        $buttonNewServicePrincipal.add_Click({New-IBServicePrincipal})
        $MainForm.Controls.Add($buttonNewServicePrincipal)
    }
    else{
        $labelIBServicePrincipalValue.ForeColor = "Green"
        $labelIBServicePrincipalValue.text = "True"
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Information Barriers Service Principal found." -DefaultColor "Green"
    }
}