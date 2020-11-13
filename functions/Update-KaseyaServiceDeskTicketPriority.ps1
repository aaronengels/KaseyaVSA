function Update-KaseyaServiceDeskTicketPriority {

	<#
	.SYNOPSIS
    Updates the priority of a service desk ticket.

    .PARAMETER TicketId
    Specify Ticket ID.

    .PARAMETER PriorityId
    Specify Priority ID.

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
        [string]$PriorityId
        
    )

    # Set API request parameters
    $params = @{
        ApiMethod = 'PUT'
        ApiRequest = '/automation/servicedesktickets/{0}/priority/{1}' -f $TicketId, $PriorityId
    }

    # Get API response
    $response = New-KaseyaApiRequest @params
    return $response.result
}