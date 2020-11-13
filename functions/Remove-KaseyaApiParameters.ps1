function Remove-KaseyaApiParameters {

    <#
    
	.SYNOPSIS
    Removes the Kaseya VSA API variables used throughout the module.
    
	#>
	
    Remove-Variable -Name kaseyaApiUrl -Scope Script -Force
    Remove-Variable -Name kaseyaApiUser -Scope Script  -Force
    Remove-Variable -Name kaseyaApiPswd -Scope Script  -Force
    Remove-Variable -Name kaseyaApiAccessToken -Scope Script  -Force
}