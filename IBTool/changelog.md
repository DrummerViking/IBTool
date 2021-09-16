# Changelog  

## 2.0.5 (2021-09-16)  
- New: Added section to remove Organization Segments and IB Policies.  
- Updated: Updated section to create Organization Segments and added edition functionality.
- Updated: All new IB Policies created will be with 'Inactive' state, until IB Policy Application is started.
- Fixed: Added validation to prevent the mix with 'AzureAD' and 'AzureADPreview' powershell modules.

## 2.0.1 (2021-01-27)  
- New: Added section to create new Organization segments.  
- New: Added section to create new Information Barrier Policy.  
- New: Added button to start IB Policies application.  
- Fixed: some cosmetic and button organizations in the window Form.  
- Fixed: Get-SegmentMembers function which was throwing an error in Powershell console.

## 1.0.0 (2021-01-19)  
- Update: First release  

## 0.0.21 (2020-11-06)  
- Fixed: Updated some grammar errors.  

## 0.0.20 (2020-11-04)  
- Fixed: Updated Recipient Status function to compare users.  

## 0.0.19 (2020-10-29)  
- Fixed: Updated some grammar errors.  

## 0.0.18 (2020-10-29)  
- Fixed: Updated Connect-OnlineServices function to invert the order of services to connect, to prevent cmdlet overlapping.  
- New: Added function to check (and add if missing) an existing AzureAD Service Principal for "information Barrier Processor" Enterprise App.  
- New: Added function to get Organization Segment members.  
- New: Minor cosmetic change adding horizontal lines.  

## 0.0.13 (2020-10-28)  
 - New: Added 5 functions  
 - New: Added display information for Audit logs and Exchange ABP.  
 - New: Added 3 buttons to call the functions.  
 - Update: Update Connect-OnlineServices function to use a Switch method and connect to passed Services by parameter.  
 - Fixed: Remove help comments from install.ps1 function.  

## 0.0.0 (2020-10-27)  
 - New: Project Start