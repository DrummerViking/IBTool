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
    # check for updates
    $runspaceData = Start-ModuleUpdate -ModuleRoot $script:ModuleRoot

    # Check current connection status, and connect if needed
    $ServicesToConnect = Assert-ServiceConnection
    # Connect to services if ArrayList is not empty
    if ( $ServicesToConnect.Count ) { Connect-OnlineServices -Services $ServicesToConnect }

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
        $labelTenantInfo = New-Object System.Windows.Forms.Label
        $labelAuditLogStatus = New-Object System.Windows.Forms.Label
        $labelAuditLogStatusValue = New-Object System.Windows.Forms.Label
        $labelABPStatus = New-Object System.Windows.Forms.Label
        $labelABPStatusValue = New-Object System.Windows.Forms.Label
        $labelIBServicePrincipal = New-Object System.Windows.Forms.Label
        $labelIBServicePrincipalValue = New-Object System.Windows.Forms.Label
        $HorizontalLine1 = New-Object System.Windows.Forms.Label
        $LabelGettingInfo = New-Object System.Windows.Forms.Label
        $buttonGetSegments = New-Object System.Windows.Forms.Button
        $buttonGetIBPolicies = New-Object System.Windows.Forms.Button
        $buttonGetIBPoliciesAppStatus = New-Object System.Windows.Forms.Button
        $HorizontalLine2 = New-Object System.Windows.Forms.Label
        $LabelGetOrgSegmentMemberTitle = New-Object System.Windows.Forms.Label
        $textBoxOrgSegment = New-Object System.Windows.Forms.TextBox
        $buttonGetSegmentMembers = New-Object System.Windows.Forms.Button
        $HorizontalLine3 = New-Object System.Windows.Forms.Label
        $LabelGetIBRecipientStatusTitle = New-Object System.Windows.Forms.Label
        $textBoxUser1 = New-Object System.Windows.Forms.TextBox
        $labelCompareWith = New-Object System.Windows.Forms.Label
        $textBoxUser2 = New-Object System.Windows.Forms.TextBox
        $buttonCompareIdentities = New-Object System.Windows.Forms.Button
        $HorizontalLine4 = New-Object System.Windows.Forms.Label
        $labelNewSegmentTitle = New-Object System.Windows.Forms.Label
        $labelNewSegmentHelp = New-Object System.Windows.Forms.Label
        $labelNewSegmentName = New-Object System.Windows.Forms.Label
        $textNewSegmentName = New-Object System.Windows.Forms.TextBox
        $labelUserGroupFilter = New-Object System.Windows.Forms.Label
        $comboBoxAttributelist = New-Object System.Windows.Forms.ComboBox
        $comboBoxComparison = New-Object System.Windows.Forms.ComboBox
        $textAttributeValue = New-Object System.Windows.Forms.TextBox
        $buttonCreateSegment = New-Object System.Windows.Forms.Button
        $HorizontalLine5 = New-Object System.Windows.Forms.Label
        $labelNewIBPolicyTitle = New-Object System.Windows.Forms.Label
        $labelNewIBPolicyName = New-Object System.Windows.Forms.Label
        $textNewIBPolicyName = New-Object System.Windows.Forms.TextBox
        $labelAssignSegment = New-Object System.Windows.Forms.Label
        $textAssignedSegment = New-Object System.Windows.Forms.TextBox
        $comboBoxSegmentAorB = New-Object System.Windows.Forms.ComboBox
        $textAorBSegment = New-Object System.Windows.Forms.TextBox
        $buttonCreateIBpolicy = New-Object System.Windows.Forms.Button
        $buttonStartIBPolicyApplication = New-Object System.Windows.Forms.Button
        $HorizontalLine6 = New-Object System.Windows.Forms.Label
        $labelRemoveIBPolicyTitle = New-Object System.Windows.Forms.Label
        $labelRemoveIBPolicyName = New-Object System.Windows.Forms.Label
        $textRemoveIBPolicyName = New-Object System.Windows.Forms.TextBox
        $buttonRemoveSegment = New-Object System.Windows.Forms.Button
        $buttonRemoveIBpolicy = New-Object System.Windows.Forms.Button

        $dataGrid = New-Object System.Windows.Forms.DataGridView
        $InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
        #endregion Creating required Forms Objects

        #region Internal scriptblocks
        $OnLoadMainWindow_StateCorrection={#Correct the initial state of the form to prevent the .Net maximized form issue
            $MainForm.WindowState = $InitialFormWindowState
        }

        $labelNewSegmentHelp_Click={
            [Microsoft.VisualBasic.Interaction]::MsgBox("This option is to create or edit a simple Organization Segment. If you need to create a more complex segment with more attributes and combinations, please do them with powershell.

If you are trying to create a new Organization Segment with the same name as an existing one, we will overwrite the current one with the new settings.

More info at: https://docs.microsoft.com/en-us/microsoft-365/compliance/information-barriers-policies?view=o365-worldwide#part-1-segment-users

Press CTRL + C to copy this message to clipboard.",[Microsoft.VisualBasic.MsgBoxStyle]::Okonly,"Information Message")
        }

        #endregion Internal scriptblocks

        #region Generated Form Code
        #
        # Main Form
        #
        $statusBar.Name = "statusBar"
        $statusBar.Text = "Ready..."
        $MainForm.Controls.Add($statusBar)
        $MainForm.ClientSize = New-Object System.Drawing.Size(1100,720)
        $MainForm.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation
        $MainForm.Name = "Main Form"
        $MainForm.Text = "Managing Information Barriers for Microsoft Teams"
        $MainForm.StartPosition = "CenterScreen"
        $MainForm.KeyPreview = $True
        $MainForm.Add_KeyDown({
            if ( $_.KeyCode -eq "Escape" ){ $MainForm.Close() }
        })
        #
        # Label Tenant Info
        #
        $labelTenantInfo.Location = New-Object System.Drawing.Point(10,10)
        $labelTenantInfo.Size = New-Object System.Drawing.Size(125,20)
        $labelTenantInfo.Name = "labelTenantInfo"
        $labelTenantInfo.Text = "Tenant Info"
        $labelTenantInfo.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)
        $MainForm.Controls.Add($labelTenantInfo)
        #
        # Label Audit Logging Status
        #
        $labelAuditLogStatus.Location = New-Object System.Drawing.Point(10,($labelTenantInfo.Location.Y + 25))
        $labelAuditLogStatus.Size = New-Object System.Drawing.Size(125,20)
        $labelAuditLogStatus.Name = "labelAuditLogStatus"
        $labelAuditLogStatus.Text = "Audit Logging Enabled:"
        $MainForm.Controls.Add($labelAuditLogStatus)
        #
        # Label Audit Logging Status Value
        #
        $labelAuditLogStatusValue.Location = New-Object System.Drawing.Point(155,($labelTenantInfo.Location.Y + 25))
        $labelAuditLogStatusValue.Size = New-Object System.Drawing.Size(35,20)
        $labelAuditLogStatusValue.Name = "labelAuditLogStatusValue"
        Get-AuditLogStatus
        $MainForm.Controls.Add($labelAuditLogStatusValue)
        #
        # Label Exchange Address Book Policy Status
        #
        $labelABPStatus.Location = New-Object System.Drawing.Point(10,($labelAuditLogStatus.Location.Y + 25))
        $labelABPStatus.Size = New-Object System.Drawing.Size(145,20)
        $labelABPStatus.Name = "labelABPStatus"
        $labelABPStatus.Text = "No Exchange ABP applied:"
        $MainForm.Controls.Add($labelABPStatus)
        #
        # Label Exchange Address Book Policy Status Value
        #
        $labelABPStatusValue.Location = New-Object System.Drawing.Point(155,($labelAuditLogStatus.Location.Y + 25))
        $labelABPStatusValue.Size = New-Object System.Drawing.Size(35,20)
        $labelABPStatusValue.Name = "labelABPStatusValue"
        Get-ExchangeABPStatus
        $MainForm.Controls.Add($labelABPStatusValue)
        #
        # Label Information Barrier Service Principal
        #
        $labelIBServicePrincipal.Location = New-Object System.Drawing.Point(10,($labelABPStatus.Location.Y + 25))
        $labelIBServicePrincipal.Size = New-Object System.Drawing.Size(220,20)
        $labelIBServicePrincipal.Name = "labelIBServicePrincipal"
        $labelIBServicePrincipal.Text = "Information Barrier Service Principal found:"
        $MainForm.Controls.Add($labelIBServicePrincipal)
        #
        # Label Information Barrier Service Principal Status
        #
        $labelIBServicePrincipalValue.Location = New-Object System.Drawing.Point(230,($labelABPStatus.Location.Y + 25))
        $labelIBServicePrincipalValue.Size = New-Object System.Drawing.Size(35,20)
        $labelIBServicePrincipalValue.Name = "labelIBServicePrincipalStatus"
        Get-IBServicePrincipal
        $MainForm.Controls.Add($labelIBServicePrincipalValue)
        #
        # Horizontal Line 1
        #
        $HorizontalLine1.Location = New-Object System.Drawing.Point(5,($labelIBServicePrincipal.Location.Y + 25))
        $HorizontalLine1.Size = New-Object System.Drawing.Size(1090,2)
        $HorizontalLine1.Name = "HorizontalLine1"
        $HorizontalLine1.Text = $null
        $HorizontalLine1.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine1)
        #
        # Label Getting Info
        #
        $LabelGettingInfo.Location = New-Object System.Drawing.Point(10,($HorizontalLine1.Location.Y + 10))
        $LabelGettingInfo.Size = New-Object System.Drawing.Size(250,20)
        $LabelGettingInfo.Name = "LabelGettingInfo"
        $LabelGettingInfo.Text = "Get general Information Barrier Info"
        $LabelGettingInfo.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)
        $MainForm.Controls.Add($LabelGettingInfo)
        #
        # Button Get Organization Segments
        #
        $buttonGetSegments.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonGetSegments.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonGetSegments.Location = New-Object System.Drawing.Point(10,($LabelGettingInfo.Location.Y + 25))
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
        $buttonGetIBPolicies.Location = New-Object System.Drawing.Point(220,($LabelGettingInfo.Location.Y + 25))
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
        $buttonGetIBPoliciesAppStatus.Location = New-Object System.Drawing.Point(480,($LabelGettingInfo.Location.Y + 25))
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
        $HorizontalLine2.Location = New-Object System.Drawing.Point(5,($buttonGetSegments.Location.Y + 40))
        $HorizontalLine2.Size = New-Object System.Drawing.Size(1090,2)
        $HorizontalLine2.Name = "HorizontalLine2"
        $HorizontalLine2.Text = $null
        $HorizontalLine2.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine2)
        #
        # Label Get Org Segment Member title
        #
        $LabelGetOrgSegmentMemberTitle.Location = New-Object System.Drawing.Point(10,($HorizontalLine2.Location.Y + 10))
        $LabelGetOrgSegmentMemberTitle.Size = New-Object System.Drawing.Size(250,20)
        $LabelGetOrgSegmentMemberTitle.Name = "LabelGetOrgSegmentMemberTitle"
        $LabelGetOrgSegmentMemberTitle.Text = "Get Organization Segment members"
        $LabelGetOrgSegmentMemberTitle.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)
        $MainForm.Controls.Add($LabelGetOrgSegmentMemberTitle)
        #
        # Text Box Organization Segment Name
        #
        $textBoxOrgSegment.Location = New-Object System.Drawing.Point(10,($LabelGetOrgSegmentMemberTitle.Location.Y + 28))
        $textBoxOrgSegment.Size = New-Object System.Drawing.Size(200,20)
        $textBoxOrgSegment.Name = "textBoxOrgSegment"
        $textBoxOrgSegment.Text = "Sample Organization Segment"
        $MainForm.Controls.Add($textBoxOrgSegment)
        #
        # Button Get Organization Segment Members
        #
        $buttonGetSegmentMembers.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonGetSegmentMembers.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonGetSegmentMembers.Location = New-Object System.Drawing.Point(220,($LabelGetOrgSegmentMemberTitle.Location.Y + 25))
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
        $HorizontalLine3.Location = New-Object System.Drawing.Point(5,($textBoxOrgSegment.Location.Y + 40))
        $HorizontalLine3.Size = New-Object System.Drawing.Size(1090,2)
        $HorizontalLine3.Name = "HorizontalLine3"
        $HorizontalLine3.Text = $null
        $HorizontalLine3.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine3)
        #
        # Label Get Org Recipient Status
        #
        $LabelGetIBRecipientStatusTitle.Location = New-Object System.Drawing.Point(10,($HorizontalLine3.Location.Y + 10))
        $LabelGetIBRecipientStatusTitle.Size = New-Object System.Drawing.Size(250,20)
        $LabelGetIBRecipientStatusTitle.Name = "LabelGetIBRecipientStatusTitle"
        $LabelGetIBRecipientStatusTitle.Text = "Get Information Barrier Recipient Status"
        $LabelGetIBRecipientStatusTitle.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)
        $MainForm.Controls.Add($LabelGetIBRecipientStatusTitle)
        #
        # Text Box for user1
        #
        $textBoxUser1.Location = New-Object System.Drawing.Point(10,($LabelGetIBRecipientStatusTitle.Location.Y + 25))
        $textBoxUser1.Size = New-Object System.Drawing.Size(150,20)
        $textBoxUser1.Name = "textBoxUser1"
        $textBoxUser1.Text = "Sample User1@domain.com"
        $MainForm.Controls.Add($textBoxUser1)
        #
        # Label Compare with
        #
        $labelCompareWith.Location = New-Object System.Drawing.Point(170,($LabelGetIBRecipientStatusTitle.Location.Y + 28))
        $labelCompareWith.Size = New-Object System.Drawing.Size(80,20)
        $labelCompareWith.Name = "labelABPStatusValue"
        $labelCompareWith.Text = "compare with:"
        $MainForm.Controls.Add($labelCompareWith)
        #
        # Text Box for user2
        #
        $textBoxUser2.Location = New-Object System.Drawing.Point(250,($LabelGetIBRecipientStatusTitle.Location.Y + 25))
        $textBoxUser2.Size = New-Object System.Drawing.Size(150,20)
        $textBoxUser2.Name = "textBoxUser2"
        $textBoxUser2.Text = "Sample User2@domain.com"
        $MainForm.Controls.Add($textBoxUser2)
        #
        # Button to Compare both identities
        #
        $buttonCompareIdentities.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonCompareIdentities.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonCompareIdentities.Location = New-Object System.Drawing.Point(410,($LabelGetIBRecipientStatusTitle.Location.Y + 23))
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
        $HorizontalLine4.Location = New-Object System.Drawing.Point(5,($textBoxUser1.Location.Y + 40))
        $HorizontalLine4.Size = New-Object System.Drawing.Size(1090,2)
        $HorizontalLine4.Name = "HorizontalLine4"
        $HorizontalLine4.Text = $null
        $HorizontalLine4.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine4)
        #
        # Label New Segment Name Title
        #
        $labelNewSegmentTitle.Location = New-Object System.Drawing.Point(10,($HorizontalLine4.Location.Y + 10))
        $labelNewSegmentTitle.Size = New-Object System.Drawing.Size(220,20)
        $labelNewSegmentTitle.Name = "labelNewSegmentTitle"
        $labelNewSegmentTitle.Text = "Create or Edit an Organization Segment"
        $labelNewSegmentTitle.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)
        $MainForm.Controls.Add($labelNewSegmentTitle)
        #
        # Label New Segment Title Help
        #
        $labelNewSegmentHelp.Location = New-Object System.Drawing.Point(240,($HorizontalLine4.Location.Y + 10))
        $labelNewSegmentHelp.Size = New-Object System.Drawing.Size(30,20)
        $labelNewSegmentHelp.Name = "labelNewSegmentHelp"
        $labelNewSegmentHelp.ForeColor = "Blue"
        $labelNewSegmentHelp.Text = "help"
        $labelNewSegmentHelp.add_Click($labelNewSegmentHelp_Click)
        $MainForm.Controls.Add($labelNewSegmentHelp)
        #
        # Label New Segment Name
        #
        $labelNewSegmentName.Location = New-Object System.Drawing.Point(10,($labelNewSegmentTitle.Location.Y + 28))
        $labelNewSegmentName.Size = New-Object System.Drawing.Size(40,20)
        $labelNewSegmentName.Name = "labelNewSegmentName"
        $labelNewSegmentName.Text = "Name:"
        $MainForm.Controls.Add($labelNewSegmentName)
        #
        # Text New Segment Name
        #
        $textNewSegmentName.Location = New-Object System.Drawing.Point(55,($labelNewSegmentTitle.Location.Y + 25))
        $textNewSegmentName.Size = New-Object System.Drawing.Size(150,20)
        $textNewSegmentName.Name = "textNewSegmentName"
        $textNewSegmentName.Text = "Sample Organization Segment"
        $MainForm.Controls.Add($textNewSegmentName)
        #
        # Label user Group Filter
        #
        $labelUserGroupFilter.Location = New-Object System.Drawing.Point(210,($labelNewSegmentTitle.Location.Y + 28))
        $labelUserGroupFilter.Size = New-Object System.Drawing.Size(90,20)
        $labelUserGroupFilter.Name = "labelUserGroupFilter"
        $labelUserGroupFilter.Text = "-UserGroupFilter"
        $MainForm.Controls.Add($labelUserGroupFilter)
        #
        # Combobox Attribute lists
        #
        $comboBoxAttributelist.DataBindings.DefaultDataSourceUpdateMode = 0
        $comboBoxAttributelist.FormattingEnabled = $True
        $comboBoxAttributelist.Location = New-Object System.Drawing.Point(305,($labelNewSegmentTitle.Location.Y + 25))
        $comboBoxAttributelist.Size = New-Object System.Drawing.Size(200,23)
        $comboBoxAttributelist.Items.Add("Co") | Out-Null
        $comboBoxAttributelist.Items.Add("Company") | Out-Null
        $comboBoxAttributelist.Items.Add("Department") | Out-Null
        1..15 | ForEach-Object { $comboBoxAttributelist.Items.Add("CustomAttribute$_") | Out-Null }
        1..5  | ForEach-Object { $comboBoxAttributelist.Items.Add("ExtensionCustomAttribute$_") | Out-Null }
        $comboBoxAttributelist.Items.Add("Alias") | Out-Null
        $comboBoxAttributelist.Items.Add("Office") | Out-Null
        $comboBoxAttributelist.Items.Add("PostalCode") | Out-Null
        $comboBoxAttributelist.Items.Add("EmailAddresses") | Out-Null
        $comboBoxAttributelist.Items.Add("StreetAddress") | Out-Null
        $comboBoxAttributelist.Items.Add("ExternalEmailAddress") | Out-Null
        $comboBoxAttributelist.Items.Add("UsageLocation") | Out-Null
        $comboBoxAttributelist.Items.Add("UserPrincipalName") | Out-Null
        $comboBoxAttributelist.Items.Add("WindowsEmailAddress") | Out-Null
        $comboBoxAttributelist.Items.Add("Description") | Out-Null
        $comboBoxAttributelist.Items.Add("MemberOfGroup") | Out-Null
        $comboBoxAttributelist.Name = "comboBoxAttributelist"
        $MainForm.Controls.Add($comboBoxAttributelist)
        #
        # Combobox Comparison
        #
        $comboBoxComparison.DataBindings.DefaultDataSourceUpdateMode = 0
        $comboBoxComparison.FormattingEnabled = $True
        $comboBoxComparison.Location = New-Object System.Drawing.Point(510,($labelNewSegmentTitle.Location.Y + 25))
        $comboBoxComparison.Size = New-Object System.Drawing.Size(70,23)
        $comboBoxComparison.Items.Add("Equals") | Out-Null
        $comboBoxComparison.Items.Add("Not Equals") | Out-Null
        $comboBoxComparison.Name = "comboBoxComparison"
        $MainForm.Controls.Add($comboBoxComparison)
        #
        # Text Attribute Value
        #
        $textAttributeValue.Location = New-Object System.Drawing.Point(588,($labelNewSegmentTitle.Location.Y + 25))
        $textAttributeValue.Size = New-Object System.Drawing.Size(200,20)
        $textAttributeValue.Name = "textAttributeValue"
        $textAttributeValue.Text = "Sample Attribute Value"
        $MainForm.Controls.Add($textAttributeValue)
        #
        # Button to create Organization Segment
        #
        $buttonCreateSegment.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonCreateSegment.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonCreateSegment.Location = New-Object System.Drawing.Point(795,($labelNewSegmentTitle.Location.Y + 23))
        $buttonCreateSegment.Size = New-Object System.Drawing.Size(100,25)
        $buttonCreateSegment.TabIndex = 17
        $buttonCreateSegment.Name = "buttonCreateSegment"
        $buttonCreateSegment.Text = "Create / Set"
        $buttonCreateSegment.UseVisualStyleBackColor = $True
        $buttonCreateSegment.add_Click({
            New-OrgSegment -Name $textNewSegmentName.Text.toString() -GroupFilter $comboBoxAttributelist.SelectedItem.ToString() -Comparison $comboBoxComparison.SelectedItem.ToString() -AttributeValue $textAttributeValue.Text.ToString()
        })
        $MainForm.Controls.Add($buttonCreateSegment)
        #
        # Horizontal Line 5
        #
        $HorizontalLine5.Location = New-Object System.Drawing.Point(5,($labelNewSegmentName.Location.Y + 40))
        $HorizontalLine5.Size = New-Object System.Drawing.Size(1090,2)
        $HorizontalLine5.Name = "HorizontalLine5"
        $HorizontalLine5.Text = $null
        $HorizontalLine5.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine5)
        #
        # Label New IB Policy Title
        #
        $labelNewIBPolicyTitle.Location = New-Object System.Drawing.Point(10,($HorizontalLine5.Location.Y + 10))
        $labelNewIBPolicyTitle.Size = New-Object System.Drawing.Size(250,20)
        $labelNewIBPolicyTitle.Name = "labelNewIBPolicyTitle"
        $labelNewIBPolicyTitle.Text = "Create a new Information Barrier Policy"
        $labelNewIBPolicyTitle.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)
        $MainForm.Controls.Add($labelNewIBPolicyTitle)
        #
        # Label New IB Policy Name
        #
        $labelNewIBPolicyName.Location = New-Object System.Drawing.Point(10,($labelNewIBPolicyTitle.Location.Y + 28))
        $labelNewIBPolicyName.Size = New-Object System.Drawing.Size(40,20)
        $labelNewIBPolicyName.Name = "labelNewIBPolicyName"
        $labelNewIBPolicyName.Text = "Name:"
        $MainForm.Controls.Add($labelNewIBPolicyName)
        #
        # Text New IB Policy Name
        #
        $textNewIBPolicyName.Location = New-Object System.Drawing.Point(55,($labelNewIBPolicyTitle.Location.Y + 25))
        $textNewIBPolicyName.Size = New-Object System.Drawing.Size(150,20)
        $textNewIBPolicyName.Name = "textNewIBPolicyName"
        $textNewIBPolicyName.Text = "Sample IB Policy"
        $MainForm.Controls.Add($textNewIBPolicyName)
        #
        # Label Assign Segment
        #
        $labelAssignSegment.Location = New-Object System.Drawing.Point(210,($labelNewIBPolicyTitle.Location.Y + 28))
        $labelAssignSegment.Size = New-Object System.Drawing.Size(90,20)
        $labelAssignSegment.Name = "labelAssignSegment"
        $labelAssignSegment.Text = "Assign Segment:"
        $MainForm.Controls.Add($labelAssignSegment)
        #
        # Text Assign Segment name
        #
        $textAssignedSegment.Location = New-Object System.Drawing.Point(305,($labelNewIBPolicyTitle.Location.Y + 25))
        $textAssignedSegment.Size = New-Object System.Drawing.Size(150,20)
        $textAssignedSegment.Name = "textAssignedSegment"
        $textAssignedSegment.Text = "Sample Segment 1"
        $MainForm.Controls.Add($textAssignedSegment)
        #
        # Combobox Segment allowedBlock
        #
        $comboBoxSegmentAorB.DataBindings.DefaultDataSourceUpdateMode = 0
        $comboBoxSegmentAorB.FormattingEnabled = $True
        $comboBoxSegmentAorB.Location = New-Object System.Drawing.Point(460,($labelNewIBPolicyTitle.Location.Y + 25))
        $comboBoxSegmentAorB.Size = New-Object System.Drawing.Size(110,23)
        $comboBoxSegmentAorB.Items.Add("SegmentsAllowed") | Out-Null
        $comboBoxSegmentAorB.Items.Add("SegmentsBlocked") | Out-Null
        $comboBoxSegmentAorB.Name = "comboBoxSegmentAorB"
        $MainForm.Controls.Add($comboBoxSegmentAorB)
        # Arrow label
        $ArrowLabel = New-Object System.Windows.Forms.Label
        $ArrowLabel.Location = New-Object System.Drawing.Point(571,($labelNewIBPolicyTitle.Location.Y + 28))
        $ArrowLabel.Size = New-Object System.Drawing.Size(16,20)
        $ArrowLabel.Name = "ArrowLabel"
        $ArrowLabel.Text = "->"
        $MainForm.Controls.Add($ArrowLabel)
        #
        # Textbox Segments names
        #
        $textAorBSegment.Location = New-Object System.Drawing.Point(588,($labelNewIBPolicyTitle.Location.Y + 25))
        $textAorBSegment.Size = New-Object System.Drawing.Size(200,20)
        $textAorBSegment.Name = "textAorBSegment"
        $textAorBSegment.Text = "'Sample Segment 1', 'Sample Segment 2'"
        $MainForm.Controls.Add($textAorBSegment)
        #
        # Button to create IB policy
        #
        $buttonCreateIBpolicy.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonCreateIBpolicy.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonCreateIBpolicy.Location = New-Object System.Drawing.Point(795,($labelNewIBPolicyTitle.Location.Y + 23))
        $buttonCreateIBpolicy.Size = New-Object System.Drawing.Size(100,25)
        $buttonCreateIBpolicy.TabIndex = 17
        $buttonCreateIBpolicy.Name = "buttonCreateIBpolicy"
        $buttonCreateIBpolicy.Text = "Create"
        $buttonCreateIBpolicy.UseVisualStyleBackColor = $True
        $buttonCreateIBpolicy.add_Click({
            New-IBPolicy -PolicyName $textNewIBPolicyName.text.ToString() -AssignedSegment $textAssignedSegment.Text.ToString() -AssignedAction $comboBoxSegmentAorB.SelectedItem.ToString() -AorBSegments $textAorBSegment.Text.ToString()
        })
        $MainForm.Controls.Add($buttonCreateIBpolicy)
        #
        # Button to Start IB policy Application
        #
        $buttonStartIBPolicyApplication.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonStartIBPolicyApplication.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonStartIBPolicyApplication.Location = New-Object System.Drawing.Point(900,($labelNewIBPolicyTitle.Location.Y + 23))
        $buttonStartIBPolicyApplication.Size = New-Object System.Drawing.Size(150,25)
        $buttonStartIBPolicyApplication.TabIndex = 17
        $buttonStartIBPolicyApplication.Name = "buttonStartIBPolicyApplication"
        $buttonStartIBPolicyApplication.Text = "Start IB Policy Application"
        $buttonStartIBPolicyApplication.UseVisualStyleBackColor = $True
        $buttonStartIBPolicyApplication.add_Click({
            Start-IBPolicyApp
        })
        $MainForm.Controls.Add($buttonStartIBPolicyApplication)
        #
        # Horizontal Line 6
        #
        $HorizontalLine6.Location = New-Object System.Drawing.Point(5,($buttonStartIBPolicyApplication.Location.Y + 40))
        $HorizontalLine6.Size = New-Object System.Drawing.Size(1090,2)
        $HorizontalLine6.Name = "HorizontalLine5"
        $HorizontalLine6.Text = $null
        $HorizontalLine6.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $MainForm.Controls.Add($HorizontalLine6)
        #
        # Label Remove Segment/Policy Title
        #
        $labelRemoveIBPolicyTitle.Location = New-Object System.Drawing.Point(10,($HorizontalLine6.Location.Y + 10))
        $labelRemoveIBPolicyTitle.Size = New-Object System.Drawing.Size(350,20)
        $labelRemoveIBPolicyTitle.Name = "labelRemoveIBPolicyTitle"
        $labelRemoveIBPolicyTitle.Text = "Remove Organization Segment or Information Barrier Policy"
        $labelRemoveIBPolicyTitle.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)
        $MainForm.Controls.Add($labelRemoveIBPolicyTitle)
        #
        # Label Remove Policy Name
        #
        $labelRemoveIBPolicyName.Location = New-Object System.Drawing.Point(10,($labelRemoveIBPolicyTitle.Location.Y + 28))
        $labelRemoveIBPolicyName.Size = New-Object System.Drawing.Size(40,20)
        $labelRemoveIBPolicyName.Name = "labelRemoveIBPolicyName"
        $labelRemoveIBPolicyName.Text = "Name:"
        $MainForm.Controls.Add($labelRemoveIBPolicyName)
        #
        # Textbox Remove names
        #
        $textRemoveIBPolicyName.Location = New-Object System.Drawing.Point(55,($labelRemoveIBPolicyTitle.Location.Y + 25))
        $textRemoveIBPolicyName.Size = New-Object System.Drawing.Size(200,20)
        $textRemoveIBPolicyName.Name = "textRemoveIBPolicyName"
        $textRemoveIBPolicyName.Text = "Organization Segment or IB Policy name"
        $MainForm.Controls.Add($textRemoveIBPolicyName)
        #
        # Button to Remove OrganizationSegment
        #
        $buttonRemoveSegment.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonRemoveSegment.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonRemoveSegment.Location = New-Object System.Drawing.Point(300,($labelRemoveIBPolicyTitle.Location.Y + 23))
        $buttonRemoveSegment.Size = New-Object System.Drawing.Size(150,25)
        $buttonRemoveSegment.TabIndex = 17
        $buttonRemoveSegment.Name = "buttonRemoveSegment"
        $buttonRemoveSegment.Text = "Remove Org Segment"
        $buttonRemoveSegment.UseVisualStyleBackColor = $True
        $buttonRemoveSegment.add_Click({
            Remove-OrgSegment -Identity $textRemoveIBPolicyName.Text
        })
        $MainForm.Controls.Add($buttonRemoveSegment)
         #
        # Button to Remove OrganizationSegment
        #
        $buttonRemoveIBpolicy.DataBindings.DefaultDataSourceUpdateMode = 0
        $buttonRemoveIBpolicy.ForeColor = [System.Drawing.Color]::FromArgb(255,0,0,0)
        $buttonRemoveIBpolicy.Location = New-Object System.Drawing.Point(470,($labelRemoveIBPolicyTitle.Location.Y + 23))
        $buttonRemoveIBpolicy.Size = New-Object System.Drawing.Size(150,25)
        $buttonRemoveIBpolicy.TabIndex = 17
        $buttonRemoveIBpolicy.Name = "buttonRemoveIBpolicy"
        $buttonRemoveIBpolicy.Text = "Remove IB Policy"
        $buttonRemoveIBpolicy.UseVisualStyleBackColor = $True
        $buttonRemoveIBpolicy.add_Click({
            Remove-IBPolicy -Identity $textRemoveIBPolicyName.Text
        })
        $MainForm.Controls.Add($buttonRemoveIBpolicy)
        #
        # Data Grid outputs
        #
        $dataGrid.Anchor = 15
        $dataGrid.DataBindings.DefaultDataSourceUpdateMode = 0
        $dataGrid.DataMember = ""
        $dataGrid.Location = New-Object System.Drawing.Point(5,560)
        $dataGrid.Size = New-Object System.Drawing.Size(1090,240)
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
    try {
        GenerateForm
    }
    finally {
        Stop-ModuleUpdate -RunspaceData $runspaceData
    }
}