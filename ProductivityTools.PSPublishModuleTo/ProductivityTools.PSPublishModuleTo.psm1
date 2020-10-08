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
	$psd1 -replace $version, $NewVersion | Out-File $psd1Path -Force
}

function GetTypeOfModule{
     [Cmdletbinding()]
	param(
		[string]$psd1FullName
	)
	$psd1= Get-Content $psd1FullName -Raw
	$rootModule = [regex]::matches($psd1, "\s*RootModule\s=\s'(.*)'\s*")
	$rootModuleName=$rootModule.groups[1].value
	if($rootModuleName.EndsWith('.dll'))
	{
		return "binary"
	}
	
	if($rootModuleName.EndsWith('.psm1'))
	{
		return "text"
	}
	
	throw "In the Root module no dll nor psm1 type is defined"	
}

function Buildapplication{
	[Cmdletbinding()]
	param()
	dotnet pack
}

function Publish-ModuleTo{
 
	[Cmdletbinding()]
	param(
		[string]$PSRepositoryName, #PSGallery, PawelGallery
		[string]$PSRepositoryApiConfigKey, #Key stored in MasterConfiguration
		[switch]$IncreaseModuleVersion 
	)
	
	$PSRepositoryApiKey=Get-MasterConfiguration -Key $PSRepositoryApiConfigKey

	$psd1s=@(Get-ChildItem -Recurse "*.psd1") 

	Write-Verbose "Found $($psd1s.Length) module manifests"

	foreach($psd1 in $psd1s)
	{
		$psd1FullName=$psd1.FullName
		if ($psd1FullName.Contains("bin")) {continue}

		$moduleType=GetTypeOfModule $psd1FullName
		if($IncreaseModuleVersion.IsPresent)
		{
			Write-Verbose "Update Module Version"
			UpdateModuleVersion $psd1FullName
		}
		
		$psd1ToBePublished;
		if ($moduleType -eq "binary")
		{
			Buildapplication
			$psd1sForBin=@(Get-ChildItem -Recurse "*.psd1") 
			$binPsd1=$psd1sForBin |where {$_.DirectoryName -like "*bin*" -and $_.Name -eq $psd1.Name}
			$psd1ToBePublished=$binPsd1
		}
		
		if ($moduleType -eq "text")
		{
			$psd1ToBePublished=$psd1FullName
		}
		
		

		Write-Verbose "Publish $fullPath"
		Write-Verbose "PSRepository: $PSRepositoryName"
		Write-Verbose "PSRepositoryApiKey: $PSRepositoryApiConfigKey"
		Write-Verbose "PSRepositoryApiValue: $PSRepositoryApiKey"
		Publish-Module -Repository $PSRepositoryName -NuGetApiKey $PSRepositoryApiKey -Name $psd1ToBePublished  -Verbose:$VerbosePreference
	}
}

Export-ModuleMember Publish-ModuleTo