function Get-KaseyaServiceDeskStatuses {

	<#
	.SYNOPSIS
    Returns an array of ticket statuses for a specified service desk.

    .PARAMETER ServiceDeskId
    Specify Service Desk ID.

	.PARAMETER Filter
    Go to http://help.kaseya.com/webhelp/EN/RESTAPI/9050000/#31622.htm for more info.
    No need to ommit '$filter=' in your string as it will automatically be added for you.
    For example 'Online eq 0' will return all offline agents.

	.PARAMETER OrderBy 
    Go to http://help.kaseya.com/webhelp/EN/RESTAPI/9050000/#31622.htm for more info.
    No need to ommit '$orderby=' in your string as it will automatically be added for you.
    For example 'ComputerName' will order results by the computer name.

    #>
    
	# Functions parameters
	Param(

        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^[0-9]')]
        [string]$ServiceDeskId,

		[Parameter(Mandatory=$False)]
        [string]$Filter,

		[Parameter(Mandatory=$False)]
        [string]$OrderBy
        
    )

    # Set local variables
    $results = @()
    $totalRecords = 0
    $skip = 0
    $top = 100

    do  {

        # Set API request parameters
        $params = @{
            ApiMethod = 'GET'
            ApiRequest = '/automation/servicedesks/{0}/status' -f $ServiceDeskId
            Paging = '?$skip={0}&$top={1}' -f $skip, $top
        }

        # Add filter to parameters if present
        If ($Filter) {$params.Add('Filter','&$filter={0}' -f $Filter)}
        
        # Add sorting to parameters if present
        If ($OrderBy) {$params.Add('OrderBy','&$orderby={0}' -f $OrderBy)}

        # Add records to hash
        $response = New-KaseyaApiRequest @params
        if($response) {$results += $response.result}

        # Get total records
        if($totalRecords -eq 0) {$totalRecords = [int]$response.totalrecords}
        
        # Update paging
        $skip += $top
    }
    until ($skip -ge $totalRecords)

    return $results
}