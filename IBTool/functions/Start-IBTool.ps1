Function Start-IBTool {
    <#
    .SYNOPSIS
    Function to start the 'Information Barriers' tool.
    
    .DESCRIPTION
    Function to start the 'Information Barriers' tool.
    
    .PARAMETER Credential
    Credential to use for the connection.

    .PARAMETER Confirm
    If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

    .PARAMETER WhatIf
    If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

    .EXAMPLE
    PS C:\> Start-IBTool
    This command will launch the 'Information Barriers' GUI tool.
    #>
    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Low')]
    param (
        [PSCredential]
        $Credential = (Get-Credential -Message "Please specify O365 Global Admin Credentials")
    )

    # Check connection status, and connect if needed
    Connect-OnlineServices -Credential $Credential -EXO -SCC

    function GenerateForm {
        #region Import the Assemblies
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        Add-Type -AssemblyName Microsoft.VisualBasic
        [System.Windows.Forms.Application]::EnableVisualStyles()
        #endregion Import the Assemblies

        #region Creating required Forms Objects
        $MainForm = New-Object System.Windows.Forms.Form
        $statusBar = New-Object System.Windows.Forms.StatusBar
        $labelAuditLogStatus = New-Object System.Windows.Forms.Label
        $labelAuditLogStatusValue = New-Object System.Windows.Forms.Label
        $labelABPStatus = New-Object System.Windows.Forms.Label
        $labelABPStatusValue = New-Object System.Windows.Forms.Label
        $buttonGetSegments = New-Object System.Windows.Forms.Button
        $buttonGetIBPolicies = New-Object System.Windows.Forms.Button
        $textBoxUser1 = New-Object System.Windows.Forms.TextBox
        $labelCompareWith = New-Object System.Windows.Forms.Label
        $textBoxUser2 = New-Object System.Windows.Forms.TextBox
        $buttonCompareIdentities = New-Object System.Windows.Forms.Button
        $dataGrid = New-Object System.Windows.Forms.DataGridView
        $InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
        #endregion Creating required Forms Objects

        #region Internal scriptblocks
        $OnLoadMainWindow_StateCorrection={#Correct the initial state of the form to prevent the .Net maximized form issue
            $MainForm.WindowState = $InitialFormWindowState
        }
        #endregion Internal scriptblocks

        #region Generated Form Code
        #
        # Main Form
        #
        $statusBar.Name = "statusBar"
        $statusBar.Text = "Ready..."
        $MainForm.Controls.Add($statusBar)
        $MainForm.ClientSize = New-Object System.Drawing.Size(900,720)
        $MainForm.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation
        $MainForm.Name = "Main Form"
        $MainForm.Text = "Managing Information Barriers for Microsoft Teams"
        $MainForm.StartPosition = "CenterScreen"
        $MainForm.KeyPreview = $True
        $MainForm.Add_KeyDown({
            if ( $_.KeyCode -eq "Escape" ){ $MainForm.Close() }
        })
        #
        # Label Audit Logging Status
        #
        $labelAuditLogStatus.Location = New-Object System.Drawing.Point(10,10)
        $labelAuditLogStatus.Size = New-Object System.Drawing.Size(125,20)
        $labelAuditLogStatus.Name = "labelAuditLogStatus"
        $labelAuditLogStatus.Text = "Audit Logging Enabled:"
        #$labelAuditLogStatus.add_Click($handler_labelAuditLogStatus_Click)
        $MainForm.Controls.Add($labelAuditLogStatus)
        #
        # Label Audit Logging Status Value
        #
        $labelAuditLogStatusValue.Location = New-Object System.Drawing.Point(155,10)
        $labelAuditLogStatusValue.Size = New-Object System.Drawing.Size(35,20)
        $labelAuditLogStatusValue.Name = "labelAuditLogStatusValue"
        Get-AuditLogStatus
        $MainForm.Controls.Add($labelAuditLogStatusValue)
        #
        # Label Exchange Address Book Policy Status
        #
        $labelABPStatus.Location = New-Object System.Drawing.Point(10,35)
        $labelABPStatus.Size = New-Object System.Drawing.Size(145,20)
        $labelABPStatus.Name = "labelABPStatus"
        $labelABPStatus.Text = "No Exchange ABP applied:"
        $MainForm.Controls.Add($labelABPStatus)
        #
        # Label Exchange Address Book Policy Status Value
        #
        $labelABPStatusValue.Location = New-Object System.Drawing.Point(155,35)
        $labelABPStatusValue.Size = New-Object System.Drawing.Size(35,20)
        $labelABPStatusValue.Name = "labelABPStatusValue"
        Get-ExchangeABPStatus
        $MainForm.Controls.Add($labelABPStatusValue)
        #
        # Button Get Organization Segments
        #
        $buttonGetSegments.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonGetSegments.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonGetSegments.Location = New-Object System.Drawing.Point(10,60)
        $buttonGetSegments.Size = New-Object System.Drawing.Size(200,25)
        $buttonGetSegments.TabIndex = 17
        $buttonGetSegments.Name = "GetSegments"
        $buttonGetSegments.Text = "Get Organization Segments"
        $buttonGetSegments.UseVisualStyleBackColor = $True
        $buttonGetSegments.add_Click({Get-OrgSegments})
        $MainForm.Controls.Add($buttonGetSegments)
        #
        # Button Get Information Barriers Policies
        #
        $buttonGetIBPolicies.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonGetIBPolicies.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonGetIBPolicies.Location = New-Object System.Drawing.Point(220,60)
        $buttonGetIBPolicies.Size = New-Object System.Drawing.Size(250,25)
        $buttonGetIBPolicies.TabIndex = 17
        $buttonGetIBPolicies.Name = "GetIBPolicies"
        $buttonGetIBPolicies.Text = "Get Information Barriers Policies"
        $buttonGetIBPolicies.UseVisualStyleBackColor = $True
        $buttonGetIBPolicies.add_Click({Get-IBPolicies})
        $MainForm.Controls.Add($buttonGetIBPolicies)
        #
        # Text Box for user1
        #
        $textBoxUser1.Location = New-Object System.Drawing.Point(10,100)
        $textBoxUser1.Size = New-Object System.Drawing.Size(150,20)
        $textBoxUser1.Name = "textBoxUser1"
        $textBoxUser1.Text = "Sample User1"
        $MainForm.Controls.Add($textBoxUser1)
        #
        # Label Compare with
        #
        $labelCompareWith.Location = New-Object System.Drawing.Point(170,103)
        $labelCompareWith.Size = New-Object System.Drawing.Size(80,20)
        $labelCompareWith.Name = "labelABPStatusValue"
        $labelCompareWith.Text = "compare with:"
        $MainForm.Controls.Add($labelCompareWith)
        
        #
        # Text Box for user2
        #
        $textBoxUser2.Location = New-Object System.Drawing.Point(250,100)
        $textBoxUser2.Size = New-Object System.Drawing.Size(150,20)
        $textBoxUser2.Name = "textBoxUser2"
        $textBoxUser2.Text = "Sample User2"
        $MainForm.Controls.Add($textBoxUser2)
        #
        # Button to Compare both identities
        #
        $buttonCompareIdentities.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonCompareIdentities.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonCompareIdentities.Location = New-Object System.Drawing.Point(410,98)
        $buttonCompareIdentities.Size = New-Object System.Drawing.Size(150,25)
        $buttonCompareIdentities.TabIndex = 17
        $buttonCompareIdentities.Name = "CompareIdentities"
        $buttonCompareIdentities.Text = "Compare Users"
        $buttonCompareIdentities.UseVisualStyleBackColor = $True
        $buttonCompareIdentities.add_Click({Get-IBPolicies})
        $MainForm.Controls.Add($buttonCompareIdentities)
        #
        # Data Grid outputs
        #
        $dataGrid.Anchor = 15
        $dataGrid.DataBindings.DefaultDataSourceUpdateMode = 0
        $dataGrid.DataMember = ""
        $dataGrid.Location = New-Object System.Drawing.Point(5,460)
        $dataGrid.Size = New-Object System.Drawing.Size(890,240)
        $dataGrid.Name = "dataGrid"
        $dataGrid.ReadOnly = $True
        $dataGrid.RowHeadersVisible = $False
        $dataGrid.Visible = $True
        $dataGrid.AllowUserToOrderColumns = $True
        $dataGrid.AllowUserToResizeColumns = $True
        $MainForm.Controls.Add($dataGrid)

        #endregion Generated Form Code

        # Show Form
        #Save the initial state of the form
        $InitialFormWindowState = $MainForm.WindowState
        #Init the OnLoad event to correct the initial state of the form
        $MainForm.add_Load($OnLoadMainWindow_StateCorrection)
        $MainForm.Add_Shown({$MainForm.Activate()})
        $MainForm.ShowDialog() | Out-Null
    } #End Function

    #Call the Function
    GenerateForm
}