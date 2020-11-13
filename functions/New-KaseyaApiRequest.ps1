function New-KaseyaApiRequest {

	<#
	.SYNOPSIS
	Returns API response.

	.PARAMETER ApiMethod
	Provide API Method GET, PUT or POST

	.PARAMETER ApiRequest 
	See Kaseya VSA API swagger UI

	.PARAMETER ApiRequestBody 
	Only used with PUT and POST request

    .INPUTS
	$KaseyaApiUrl = The API URL
	$apiKey = The API Key
	$apiKeySecret = The API Secret Key

	#>
    
	Param(
        [Parameter(Mandatory=$True)]
        [ValidateSet('GET','PUT','POST')]
		[string]$ApiMethod,

        [Parameter(Mandatory=$True)]
		[string]$ApiRequest,

		[Parameter(Mandatory=$False)]
		[string]$Filter,
		
		[Parameter(Mandatory=$False)]
		[string]$OrderBy,

		[Parameter(Mandatory=$False)]
		[string]$Paging,
    
        [Parameter(Mandatory=$False)]
		[string]$ApiRequestBody
	)

	# Check API Parameters
	if (!$kaseyaApiUrl -or !$kaseyaApiUser -or !$kaseyaApiPswd) {
		Write-Host 'Kaseya VSA API Parameters missing, please run Set-KaseyaApiParameters first!' -ForegroundColor 'Red'
		exit 1
	}

	# Add API parameters
	$params = [ordered] @{
		Uri         	= '{0}/api/v1.0{1}{2}{3}{4}' -f $kaseyaApiUrl, $apiRequest, $Paging, $Filter, $OrderBy
		Method      	= $ApiMethod
		ContentType 	= 'application/json; charset=utf-8'
		Headers     	= @{'Authorization' = 'Bearer {0}' -f $kaseyaApiAccessToken}
	}

	# Add body request
	If ($ApiRequestBody) {$params.Add('Body',$ApiRequestBody)}
	
	# Invoke API request
	try { 
		$response = Invoke-RestMethod @params 
	}
	catch {
		Write-Host $_.Exception.Message -f Red
		if($_.ErrorDetail) {Write-Host $_.ErrorDetail.Message -f Red}
		Write-Host $_.ScriptStackTrace -f Red
		exit 1
	}
	return $response
}