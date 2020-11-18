# About

This module is designed to make it easier to use the Kaseya VSA API in your PowerShell scripts. As all the hard work is done,
you can develop your scripts faster and be more efficient. There is no need to go through a big learning curve spending lots
of time working out how to use the Kaseya VSA API  API. Simply load the module, enter your API keys and get results within minutes!

# Basics

You can install the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/KaseyaVSA) and use example below to get started. To use the code blow you can download my [Alert Desk](https://automationexchange.kaseya.com/products/108) from the Kaseya Automation Exchange.

```powershell
begin {
	
	# Load Modules
	Import-Module KaseyaVSA -Force


	# Specify Kaseya API Parameters
	$kaseyaApiParams = @{
			Url   =  '<Kaseya API URL>'
			User  =  '<Kaseya VSA User'
			Pswd  =  '<Kaseya VSA Password>'
	}

	# Set Module API Parameters
	Set-KaseyaApiParameters @kaseyaApiParams

	# Remove Local API Parameters 
	Remove-Variable kaseyaApiParams -Force

}

process {
	
	# Get Alert Desk Id
	$alertDeskId = (Get-KaseyaServiceDesks -Filter "ServiceDeskName eq 'AlertDesk'").ServiceDeskId

	# Get Alert Desk Tickets
	foreach ($ticket in Get-KaseyaServiceDeskTickets -ServiceDeskId $alertDeskId) {
		$ticket | Write-Output 
	}
}

end {
	
	# Remove API Parameters
	Remove-KaseyaApiParameters
}

```

# Kaseya VSA API

Visit the [online help](http://help.kaseya.com/webhelp/EN/RESTAPI/9050000/index.asp#home.htm) to find out more about the Kaseya API. 

# Release notes

## Version 1.0.0.0
- Added Update-KaseyaServiceDeskTicketCustomField  Function
- Added Update-KaseyaServiceDeskTicketPriority Function
- Added Update-KaseyaServiceDeskTicketStatus Function
- Added Get-KaseyaServiceDeskTicketNotes Function
- Added Get-KaseyaServiceDeskTicket Function
- Added Get-KaseyaServiceDeskTickets Function
- Added Get-KaseyaServiceDeskCustomFields Function
- Added Get-KaseyaServiceDeskStatuses Function
- Added Get-KaseyaServiceDeskPriorities Function
- Added Get-KaseyaServiceDeskCategories Function
- Added Get-KaeyaServiceDesks Function
- Added Get-KaseyaAgents Function
- Added Remove-KaseyaApiParameters Function
- Added Set-KaseyaApiParameters Function
- Added New-ApiRequest Function
- Added New-ApiAccessToken Function





