function New-Hash {

	<#
	.SYNOPSIS
	Creates a new hash.

	.PARAMETER Algorithm
	Provide algorithm 'SHA1' or 'SHA256'.

	.PARAMETER Text
	Provide text you would like to hash.
	
	#>
	
	Param(

		[Parameter(Mandatory=$True)]
		[ValidateSet('SHA1','SHA256')]
		[string]$Algorithm,
		
		[Parameter(Mandatory=$True)]
		[string]$Text
	
	)
	try {
		$data = [system.Text.Encoding]::UTF8.GetBytes($Text)
		[string]$hash = -join ([Security.Cryptography.HashAlgorithm]::Create($Algorithm).ComputeHash($data) | ForEach-Object { "{0:x2}" -f $_ })
	}
	catch{
		$_.Exception.Message
	}
	return $hash

}
