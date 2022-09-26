# [CmdletBinding()]
param(
	[parameter(Mandatory=$True)]
	[string] $computername)
'the param you typed in is: ' + $computername