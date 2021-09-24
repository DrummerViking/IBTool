# IB Tool

## About
This tool is intended to easily help on managing Information Barriers in Microsoft Teams, Sharepoint and Onedrive.  
- You can list current Organization Segments.  
- Get Segment's members.  
- Get current Information Barriers policies.  
- Verify if there is any policy involved between 2 users.  
- Create new Organization Segments.
- Edit existing Organization Segments.
- Create new Information Barrier policies.
- Start Applying the Information Barrier Policies.
- Get current Information Barrier Policies application status.
- Search unified Audit Logs for IB Policy Application Status events.

## Pre-requisites

 > This Module requires Powershell 5.1 and above.  
 > This Module will install required modules if not installed.  

 ## Installation

 Open a Windows Powershell with "Run as Administrator" and run:
``` powershell
Install-Module IBTool -Force
```

Once the module is installed in your computer, you can always start it by running:
``` powershell
Start-IBTool
```

If there is any newer version available, the tool will toast notify the user and you can run:
``` powershell
Update-Module IBTool -Force
```

## Version History  
[Change Log](/IBTool/changelog.md)