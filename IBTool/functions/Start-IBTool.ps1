Function Start-IBTool {
    <#
    .SYNOPSIS
    Function to start the 'Information Barriers' tool.
    
    .DESCRIPTION
    Function to start the 'Information Barriers' tool.
    
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
        # Parameters
    )

    # Check current connection status, and connect if needed
    $ServicesToConnect = Assert-ServiceConnection
    # Connect to services if ArrayList is not empty
    if ( $ServicesToConnect.Count ) { Connect-OnlineServices -Credential $Credentials -Services $ServicesToConnect }

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
        $labelIBServicePrincipal = New-Object System.Windows.Forms.Label
        $labelIBServicePrincipalValue = New-Object System.Windows.Forms.Label
        $HorizontalLine1 = New-Object System.Windows.Forms.Label
        $buttonGetSegments = New-Object System.Windows.Forms.Button
        $buttonGetIBPolicies = New-Object System.Windows.Forms.Button
        $buttonGetIBPoliciesAppStatus = New-Object System.Windows.Forms.Button
        $HorizontalLine2 = New-Object System.Windows.Forms.Label
        $textBoxOrgSegment = New-Object System.Windows.Forms.TextBox
        $buttonGetSegmentMembers = New-Object System.Windows.Forms.Button
        $HorizontalLine3 = New-Object System.Windows.Forms.Label
        $textBoxUser1 = New-Object System.Windows.Forms.TextBox
        $labelCompareWith = New-Object System.Windows.Forms.Label
        $textBoxUser2 = New-Object System.Windows.Forms.TextBox
        $buttonCompareIdentities = New-Object System.Windows.Forms.Button
        $HorizontalLine4 = New-Object System.Windows.Forms.Label
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
        # Label Information Barrier Service Principal
        #
        $labelIBServicePrincipal.Location = New-Object System.Drawing.Point(10,60)
        $labelIBServicePrincipal.Size = New-Object System.Drawing.Size(220,20)
        $labelIBServicePrincipal.Name = "labelIBServicePrincipal"
        $labelIBServicePrincipal.Text = "Information Barrier Service Principal found:"
        $MainForm.Controls.Add($labelIBServicePrincipal)
        #
        # Label Information Barrier Service Principal Status
        #
        $labelIBServicePrincipalValue.Location = New-Object System.Drawing.Point(230,60)
        $labelIBServicePrincipalValue.Size = New-Object System.Drawing.Size(35,20)
        $labelIBServicePrincipalValue.Name = "labelIBServicePrincipalStatus"
        Get-IBServicePrincipal
        $MainForm.Controls.Add($labelIBServicePrincipalValue)
        #
        # Horizontal Line 1
        #
        $HorizontalLine1.Location = New-Object System.Drawing.Point(5,85)
        $HorizontalLine1.Size = New-Object System.Drawing.Size(890,2)
        $HorizontalLine1.Name = "HorizontalLine1"
        $HorizontalLine1.Text = $null
        $HorizontalLine1.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine1)
        #
        # Button Get Organization Segments
        #
        $buttonGetSegments.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonGetSegments.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonGetSegments.Location = New-Object System.Drawing.Point(10,100)
        $buttonGetSegments.Size = New-Object System.Drawing.Size(200,25)
        $buttonGetSegments.TabIndex = 17
        $buttonGetSegments.Name = "GetSegments"
        $buttonGetSegments.Text = "Get Organization Segments"
        $buttonGetSegments.UseVisualStyleBackColor = $True
        $buttonGetSegments.add_Click({
            $Segments = Get-OrgSegments -ShowOutputLine
            Add-ArrayToDataGrid -ArrayData $Segments -DataGrid $dataGrid -Form $MainForm
        })
        $MainForm.Controls.Add($buttonGetSegments)
        #
        # Button Get Information Barriers Policies
        #
        $buttonGetIBPolicies.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonGetIBPolicies.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonGetIBPolicies.Location = New-Object System.Drawing.Point(220,100)
        $buttonGetIBPolicies.Size = New-Object System.Drawing.Size(250,25)
        $buttonGetIBPolicies.TabIndex = 17
        $buttonGetIBPolicies.Name = "GetIBPolicies"
        $buttonGetIBPolicies.Text = "Get Information Barriers Policies"
        $buttonGetIBPolicies.UseVisualStyleBackColor = $True
        $buttonGetIBPolicies.add_Click({
            $IBPolicies = Get-IBPolicies -ShowOutputLine
            Add-ArrayToDataGrid -ArrayData $IBPolicies -DataGrid $dataGrid -Form $MainForm
        })
        $MainForm.Controls.Add($buttonGetIBPolicies)
        #
        # Button Get Information Barriers Policies Application Status
        #
        $buttonGetIBPoliciesAppStatus.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonGetIBPoliciesAppStatus.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonGetIBPoliciesAppStatus.Location = New-Object System.Drawing.Point(480,100)
        $buttonGetIBPoliciesAppStatus.Size = New-Object System.Drawing.Size(300,25)
        $buttonGetIBPoliciesAppStatus.TabIndex = 17
        $buttonGetIBPoliciesAppStatus.Name = "GetIBPoliciesAppStatus"
        $buttonGetIBPoliciesAppStatus.Text = "Get IB Policies Application Status"
        $buttonGetIBPoliciesAppStatus.UseVisualStyleBackColor = $True
        $buttonGetIBPoliciesAppStatus.add_Click({
            $IBPoliciesAppStatus = Get-IBPoliciesAppStatus -ShowOutputLine
            Add-ArrayToDataGrid -ArrayData $IBPoliciesAppStatus -DataGrid $dataGrid -Form $MainForm
        })
        $MainForm.Controls.Add($buttonGetIBPoliciesAppStatus)
        #
        # Horizontal Line 2
        #
        $HorizontalLine2.Location = New-Object System.Drawing.Point(5,135)
        $HorizontalLine2.Size = New-Object System.Drawing.Size(890,2)
        $HorizontalLine2.Name = "HorizontalLine2"
        $HorizontalLine2.Text = $null
        $HorizontalLine2.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine2)
        #
        # Text Box Organization Segment Name
        #
        $textBoxOrgSegment.Location = New-Object System.Drawing.Point(10,150)
        $textBoxOrgSegment.Size = New-Object System.Drawing.Size(200,20)
        $textBoxOrgSegment.Name = "textBoxOrgSegment"
        $textBoxOrgSegment.Text = "Sample Organization Segment"
        $MainForm.Controls.Add($textBoxOrgSegment)
        #
        # Button Get Organization Segment Members
        #
        $buttonGetSegmentMembers.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonGetSegmentMembers.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonGetSegmentMembers.Location = New-Object System.Drawing.Point(220,150)
        $buttonGetSegmentMembers.Size = New-Object System.Drawing.Size(250,25)
        $buttonGetSegmentMembers.TabIndex = 17
        $buttonGetSegmentMembers.Name = "GetSegmentMembers"
        $buttonGetSegmentMembers.Text = "Get Segment Members"
        $buttonGetSegmentMembers.UseVisualStyleBackColor = $True
        $buttonGetSegmentMembers.add_Click({
            $members = Get-SegmentMembers -SegmentName $textBoxOrgSegment.Text.ToString() -ShowOutputLine
            Add-ArrayToDataGrid -ArrayData $members -DataGrid $dataGrid -Form $MainForm
        })
        $MainForm.Controls.Add($buttonGetSegmentMembers)
        #
        # Horizontal Line 3
        #
        $HorizontalLine3.Location = New-Object System.Drawing.Point(5,185)
        $HorizontalLine3.Size = New-Object System.Drawing.Size(890,2)
        $HorizontalLine3.Name = "HorizontalLine3"
        $HorizontalLine3.Text = $null
        $HorizontalLine3.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine3)
        #
        # Text Box for user1
        #
        $textBoxUser1.Location = New-Object System.Drawing.Point(10,200)
        $textBoxUser1.Size = New-Object System.Drawing.Size(150,20)
        $textBoxUser1.Name = "textBoxUser1"
        $textBoxUser1.Text = "Sample User1@domain.com"
        $MainForm.Controls.Add($textBoxUser1)
        #
        # Label Compare with
        #
        $labelCompareWith.Location = New-Object System.Drawing.Point(170,203)
        $labelCompareWith.Size = New-Object System.Drawing.Size(80,20)
        $labelCompareWith.Name = "labelABPStatusValue"
        $labelCompareWith.Text = "compare with:"
        $MainForm.Controls.Add($labelCompareWith)
        #
        # Text Box for user2
        #
        $textBoxUser2.Location = New-Object System.Drawing.Point(250,200)
        $textBoxUser2.Size = New-Object System.Drawing.Size(150,20)
        $textBoxUser2.Name = "textBoxUser2"
        $textBoxUser2.Text = "Sample User2@domain.com"
        $MainForm.Controls.Add($textBoxUser2)
        #
        # Button to Compare both identities
        #
        $buttonCompareIdentities.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonCompareIdentities.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonCompareIdentities.Location = New-Object System.Drawing.Point(410,198)
        $buttonCompareIdentities.Size = New-Object System.Drawing.Size(150,25)
        $buttonCompareIdentities.TabIndex = 17
        $buttonCompareIdentities.Name = "CompareIdentities"
        $buttonCompareIdentities.Text = "Compare Users"
        $buttonCompareIdentities.UseVisualStyleBackColor = $True
        $buttonCompareIdentities.add_Click({
            $RecipientStatus = @(Get-IBPoliciesRecipientStatus -User1 $textBoxUser1.Text.toString() -User2 $textBoxUser2.Text.toString() -ShowOutputLine)
            Add-ArrayToDataGrid -ArrayData $RecipientStatus -DataGrid $dataGrid -Form $MainForm
        })
        $MainForm.Controls.Add($buttonCompareIdentities)
        #
        # Horizontal Line 4
        #
        $HorizontalLine4.Location = New-Object System.Drawing.Point(5,235)
        $HorizontalLine4.Size = New-Object System.Drawing.Size(890,2)
        $HorizontalLine4.Name = "HorizontalLine4"
        $HorizontalLine4.Text = $null
        $HorizontalLine4.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine4)
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