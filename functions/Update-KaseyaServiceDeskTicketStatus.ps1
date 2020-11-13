function Update-KaseyaServiceDeskTicketStatus {

	<#
	.SYNOPSIS
    Updates the status of a service desk ticket.

    .PARAMETER TicketId
    Specify Ticket ID.

    .PARAMETER StatusId
    Specify Status ID.

    #>
    
	# Functions parameters
	Param(

        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^[0-9]')]
        [string]$TicketId,

        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^[0-9]')]
        [string]$StatusId
        
    )

    # Set API request parameters
    $params = @{
        ApiMethod = 'PUT'
        ApiRequest = '/automation/servicedesktickets/{0}/status/{1}' -f $TicketId, $StatusId
    }

    # Get API response
    $response = New-KaseyaApiRequest @params
    return $response.result
}