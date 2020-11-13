<#
 
	.SYNOPSIS
	A PowerShell module that connects to the Kaseya VSA API.

	.DESCRIPTION
	This module contains all the Kaseya VSA REST API controllers that can used in PowerShell to perform the followiing operations:

	See http://help.kaseya.com/webhelp/EN/RESTAPI/9050000/#home.htm to see full list of operations.
	
	.COPYRIGHT
    Copyright (c) AE Technologies. All rights reserved. Licensed under the MIT license.
    See https://github.com/aaronengels/KaseyaVSA/blob/master/LICENSE.md  for license information.
	
	.PARAMETER apiUrl
	Provide your Kaseya VSA platform URL
	
	.PARAMETER apiUser
	Provide your Kaseya API username
	
	.PARAMETER apiPswd
	Provide your Kaseya API Password
	
#>

# Root Module Parameters
[CmdletBinding()]
Param(
  [Parameter(Position = 0, Mandatory=$False)]
  $apiUrl,
    
  [Parameter(Position = 1, Mandatory=$False)]
  $apiUser,

  [Parameter(Position = 2, Mandatory=$False)]
  $apiPswd
)


# Import functions
$Functions = @(Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 -ErrorAction SilentlyContinue) 
foreach ($Import in @($Functions)){
  try {
    . $Import.fullname
  }
  catch {
    throw "Could not import function $($Import.fullname): $_"
  }
}

# Set API parameters
If ($apiUrl -and $apiUser -and $apiPswd) {
	Set-ApiParameters -Url $apiUrl -User $apiUserName -Pswd $apiPswd
}

