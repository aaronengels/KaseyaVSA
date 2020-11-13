function Add-KaseyaServiceDeskTicketNote {

	<#
	.SYNOPSIS
    Adds a note to a specified service desk ticket.

    .PARAMETER TicketId
    Specify Ticket ID.

    .PARAMETER Text
    Ticket note rich text.
    For example "Auto Generated Note:<br/>\r\nTicket Changed<br/>    'invoicenum' was '12345' now '98765'<br/>"

    .PARAMETER HiddenFlag
    Hide Ticket note flag.

    .PARAMETER SystemFlag
    Ticket System flag.

    .PARAMETER Attachments
    JSON Containing attachments
    
    #>
    
	# Functions parameters
	Param(

        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^[0-9]')]
        [string]$TicketId,

        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string]$Text,

        [Parameter(Mandatory=$False)]
        [switch]$HiddenFlag = $false,
        
        [Parameter(Mandatory=$False)]
        [switch]$SystemFlag = $false,

        [Parameter(Mandatory=$False)]
        [string]$Attachments
    )

    # Create request body.
    $request = @{}
    $request.Add('Text', $Text)
    If ($HiddenFlag) {$request.Add('Hidden', 'true')}
    If ($SystemFlag) {$request.Add('SystemFlag', 'true')}
 
    # Set API request parameters
    $params = @{
        ApiMethod = 'POST'
        ApiRequest = '/automation/servicedesktickets/{0}/notes' -f $TicketId
        ApiRequestBody = $request | ConvertTo-Json
    }

    # Get API response
    $response = New-KaseyaApiRequest @params
    return $response.result
}