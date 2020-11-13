function Set-KaseyaApiParameters {
	<#
	.SYNOPSIS
	Sets the Kaeya VSA API variables used throughout the module.

	.PARAMETER Url
	Provide Kaseya VSA API url.

	.PARAMETER User
	Provide Kaseya VSA API user.

	.PARAMETER Pswd
	Provide Kaseya VSA API password.
	
	#>
	
	Param(
		[Parameter(Mandatory=$True)]
		$Url,
		
		[Parameter(Mandatory=$True)]
		$User,

		[Parameter(Mandatory=$True)]
		$Pswd
	
	)

	New-Variable -Name kaseyaApiUrl -Value $Url -Scope Script -Force
	New-Variable -Name kaseyaApiUser -Value $User -Scope Script -Force
	New-Variable -Name kaseyaApiPswd -Value $Pswd -Scope Script -Force
	
	$accessToken = New-KaseyaApiAccessToken
	New-Variable -Name kaseyaApiAccessToken -value $accessToken -Scope Script -Force
	
}
