function New-ApiRequest {

	<#
	.SYNOPSIS
	Makes a API request.

	.DESCRIPTION
	Returns the API response.

	.PARAMETER ApiMethod
	Provide API Method GET, PUT or POST

	.PARAMETER ApiRequest 
	See Kaseya VSA API swagger UI

	.PARAMETER ApiRequestBody 
	Only used with PUT and POST request

    .INPUTS
	$apiUrl = The API URL
	$apiKey = The API Key
	$apiKeySecret = The API Secret Key

	.OUTPUTS
	API response

	#>
    
	Param(
        [Parameter(Mandatory=$True)]
        [ValidateSet('GET','PUT','POST')]
		[string]$apiMethod,

        [Parameter(Mandatory=$True)]
		[string]$apiRequest,
    
        [Parameter(Mandatory=$False)]
		[string]$apiRequestBody
	)

	# Check API Parameters
	if (!$apiUrl -or !$apiUser -or !$apiPswd) {
		Write-Host "API Parameters missing, please run Set-ApiParameters first!"
		return
	}

	# Define parameters for Invoke-WebRequest cmdlet
	$params = [ordered] @{
		Uri         	= '{0}/api/v1.0{1}' -f $apiUrl, $apiRequest
		Method      	= $apiMethod
		ContentType 	= 'application/json; charset=utf-8'
		Headers     	= @{'Authorization' = 'Bearer {0}' -f $apiAccessToken}
	}

	# Add body to parameters if present
	If ($apiRequestBody) {$params.Add('Body',$apiRequestBody)}

	# Request API and return response
	$response = Invoke-RestMethod @params
	return $response
}