function UpdateModuleVersion{
	[Cmdletbinding()]
	param(
		[string]$psd1Path
	)
	
	$psd1= Get-Content $psd1Path
	[version]$Version = [regex]::matches($psd1, "\s*ModuleVersion\s=\s'(\d*.\d*.\d*)'\s*").groups[1].value
	Write-Verbose "Old Version - $Version"
	[version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1)
	Write-Verbose "New Version - $NewVersion"
	$psd1 -replace $version, $NewVersion | Out-File $psd1Path

}

function Publish-ModuleTo{
 
	[Cmdletbinding()]
	param(
		[string]$PSRepositoryName, #PSGallery, PawelGallery
		[string]$PSRepositoryApiConfigKey, #Key stored in MasterConfiguration
		[switch]$UpdateModuleVersion 
	)
	
	$PSRepositoryApiKey=Get-MasterConfiguration -Key $PSRepositoryApiConfigKey

	$psd1s=@(Get-ChildItem -Recurse "*.psd1") 

	Write-Verbose "Found $($psd1s.Length) module manifests"

	foreach($psd1 in $psd1s)
	{
		$fullPath=$psd1.FullName

		if($UpdateModuleVersion.IsPresent)
		{
			Write-Verbose "Update Module Version"
			UpdateModuleVersion $fullPath
		}

		Write-Verbose "Publish $fullPath"
		Write-Verbose "PSRepository: $PSRepositoryName"
		Write-Verbose "PSRepositoryApiKey: $PSRepositoryApiConfigKey"
		Write-Verbose "PSRepositoryApiValue: $PSRepositoryApiKey"
		Publish-Module -Repository $PSRepositoryName -NuGetApiKey $PSRepositoryApiKey -Name $fullPath  -Verbose:$VerbosePreference
	}
}

Export-ModuleMember Publish-ModuleTo