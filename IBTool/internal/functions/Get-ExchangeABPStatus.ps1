Function Get-ExchangeABPStatus {
    <#
    .SYNOPSIS
    Function to verify if Exchange AddressBook Policies are in place.
    
    .DESCRIPTION
    Function to verify if Exchange AddressBook Policies are in place.
    
    .EXAMPLE
    PS C:\> Get-ExchangeABPStatus
    #>
    [CmdletBinding()]
    Param(
        # Parameters
    )
    # Verify no Exchange AddressBook Policies are in place
    Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Verifing if no Exchange AddressBook Policies are in place."
    if ( Get-AddressBookPolicy ){
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] Existing Address Book Policies in Exchange will get in conflict with Information Barriers." -DefaultColor Red
        $labelABPStatusValue.ForeColor = "Red"
        $labelABPStatusValue.Text = "False"
    }
    else{
        Write-PSFHostColor -String "[$((Get-Date).ToString("HH:mm:ss"))] No Exchange AddressBook Policies were found." -DefaultColor Green
        $labelABPStatusValue.ForeColor = "Green"
        $labelABPStatusValue.Text = "True"
    }
}