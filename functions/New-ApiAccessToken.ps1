function New-ApiAccessToken {

	<#
	.SYNOPSIS
	Gets a new API access token.

	.DESCRIPTION
	Returns the API access token.

	.INPUTS
	$apiUrl = The Kaseya VSA API URL
	$apiUser = Your Kaseya VSA Username
	$apiPswd = Your Kaseya VSA Password

	.OUTPUTS
	API Access Token

	#>

	# Check API Parameters
	if (!$apiUrl -or !$apiUser -or !$apiPswd) {
		Write-Host "API Parameters missing, please run Set-ApiParameters first!"
		return
	}

	# Hash Kaseya VSA password
	$RandomNumber = Get-Random -Minimum 10000000 -Maximum 99999999
	$RawSHA256Hash = New-Hash -Algorithm 'SHA256' -Text "$apiPswd"
	$CoveredSHA256HashTemp = New-Hash -Algorithm 'SHA256' -Text "$apiPswd$apiUser"
	$CoveredSHA256Hash = New-Hash -Algorithm 'SHA256' -Text "$CoveredSHA256HashTemp$RandomNumber"
	$RawSHA1Hash = New-Hash -Algorithm 'SHA1' -Text "$apiPswd"
	$CoveredSHA1HashTemp = New-Hash -Algorithm 'SHA1' -Text "$apiPswd$apiUser"
	$CoveredSHA1Hash = New-Hash -Algorithm 'SHA1' -Text "$CoveredSHA1HashTemp$RandomNumber"

	# Create base64 encoded authentication for Authorization header 
	$auth = 'user={0},pass2={1},pass1={2},rpass2={3},rpass1={4},rand2={5}' -f $apiUser, $CoveredSHA256Hash, $CoveredSHA1Hash, $RawSHA256Hash, $RawSHA1Hash, $RandomNumber
	$authBase64Encoded = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($auth)) 

	# Define parameters for Invoke-WebRequest cmdlet
	$params = [ordered] @{
		Uri         	= '{0}/api/v1.0/auth' -f $apiUrl
		Method      	= 'GET'
		ContentType 	= 'application/json; charset=utf-8'
		Headers     	= @{'Authorization' = "Basic $authBase64Encoded"}
	}

	# Fetch new access token
	$response = Invoke-RestMethod @params
	return $response.result.token

}