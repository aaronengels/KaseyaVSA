function New-KaseyaApiAccessToken {

	<#
	.SYNOPSIS
	Gets a new API access token.

	.DESCRIPTION
	Returns the API access token.

	.INPUTS
	$KaseyaApiUrl = The Kaseya VSA API URL
	$kaseyaApiUser = Your Kaseya VSA Username
	$KaseyaApiPswd = Your Kaseya VSA Password

	.OUTPUTS
	API Access Token

	#>

	# Check API Parameters
	if (!$kaseyaApiUrl -or !$kaseyaApiUser -or !$kaseyaApiPswd)  {
		Write-Host 'Kaseya VSA API Parameters missing, please run Set-KaseyaApiParameters first!' -ForegroundColor 'Red'
		exit 1
	}

	# Hash Kaseya VSA password
	$RandomNumber = Get-Random -Minimum 10000000 -Maximum 99999999
	$RawSHA256Hash = New-Hash -Algorithm 'SHA256' -Text "$kaseyaApiPswd"
	$CoveredSHA256HashTemp = New-Hash -Algorithm 'SHA256' -Text "$kaseyaApiPswd$kaseyaApiUser"
	$CoveredSHA256Hash = New-Hash -Algorithm 'SHA256' -Text "$CoveredSHA256HashTemp$RandomNumber"
	$RawSHA1Hash = New-Hash -Algorithm 'SHA1' -Text "$kaseyaApiPswd"
	$CoveredSHA1HashTemp = New-Hash -Algorithm 'SHA1' -Text "$kaseyaApiPswd$kaseyaApiUser"
	$CoveredSHA1Hash = New-Hash -Algorithm 'SHA1' -Text "$CoveredSHA1HashTemp$RandomNumber"

	# Create base64 encoded authentication for Authorization header 
	$auth = 'user={0},pass2={1},pass1={2},rpass2={3},rpass1={4},rand2={5}' -f $kaseyaApiUser, $CoveredSHA256Hash, $CoveredSHA1Hash, $RawSHA256Hash, $RawSHA1Hash, $RandomNumber
	$authBase64Encoded = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($auth)) 

	# Define parameters for Invoke-WebRequest cmdlet
	$params = [ordered] @{
		Uri         	= '{0}/api/v1.0/auth' -f $kaseyaApiUrl
		Method      	= 'GET'
		ContentType 	= 'application/json; charset=utf-8'
		Headers     	= @{'Authorization' = "Basic $authBase64Encoded"}
	}

	# Fetch new access token
	try {
		$response = Invoke-RestMethod @params
	}
	catch{
		$_.Exception.Message
	}
	return $response.result.token

}