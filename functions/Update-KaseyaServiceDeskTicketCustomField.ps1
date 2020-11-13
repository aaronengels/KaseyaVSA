function Update-KaseyaServiceDeskTicketCustomField {

	<#
	.SYNOPSIS
    Updates the value of a custom field in a service desk ticket.

    .PARAMETER TicketId
    Specify Ticket ID.

    .PARAMETER CustomFieldId
    Specify Custom Field ID.

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
        [string]$CustomFieldId,

        [Parameter(Mandatory=$False)]
        [string]$CustomFieldValue
        
    )

    # Set API request parameters
    $params = @{
        ApiMethod = 'PUT'
        ApiRequest = '/automation/servicedesktickets/{0}/customfields/{1}' -f $TicketId, $CustomFieldId
        ApiRequestBody = $CustomFieldValue | ConvertTo-Json
    }

    # Get API response
    $response = New-KaseyaApiRequest @params
    return $response.result
}