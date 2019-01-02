function  Publish-ModuleTo{
	[CmdletBinding()]
	param($PSRepository, $PSRepositoryApiKey)
	
	$pSRepositoryApiValue=Get-MasterConfiguration -Key $PSRepositoryApiKey

	if ($pSRepositoryApiValue -eq $null)
	{
		throw "Missing $PSRepositoryApiKey in configuration, please setup your key using Set-MasterConfiguration -Key $PSRepositoryApiKey -Value value"
	}

	$psd1s=@(Get-ChildItem -Recurse "*.psd1") 

	Write-Verbose "Found $($psd1s.Length) module manifests"

	foreach($psd1 in $psd1s)
	{
		$fullPath=$psd1.FullName
		Write-Verbose "Publish $fullPath"
		Write-Verbose "PSRepository: $PSRepository"
		Write-Verbose "PSRepositoryApiKey: $PSRepositoryApiKey"
		Write-Verbose "PSRepositoryApiValue: $pSRepositoryApiValue"
		Publish-Module -Repository $PSRepository -NuGetApiKey $pSRepositoryApiValue -Name $fullPath
	}
}