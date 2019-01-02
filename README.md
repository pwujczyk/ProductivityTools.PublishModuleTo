[![GitHub](http://cdn.productivitytools.tech/Github40px.png)](https://github.com/pwujczyk/ProductivityTools.PSPublishModuleTo)
[![PowershellGallery](http://cdn.productivitytools.tech/Powershell40px.png)](https://www.powershellgallery.com/packages/ProductivityTools.PSPublishModuleTo/)
[![ProductivityTools](http://cdn.productivitytools.tech/Blog40px.png)](http://www.productivitytools.tech/publish-moduleto/)
 

# ProductivityTools.PSPublishModuleTo


Publishing module to Powershell gallery is very straight-forward task. To do it we just need to invoke command

Publish-Module -NuGetApiKey $nuGetApiKey -Name $fullPath
If we are pushing to different repository than default. We also can provide PSRepository  parameter.

Publish-Module -PSRepository $psRepository -NuGetApiKey $nuGetApiKey -Name $fullPath
When publishing module we are always providing the same pair of information, so described module help to automate it a little bit.

First of all Publish-ModuleTo gets nugetApiKey from MasterConfiguration, so we don't need to provide it every time we pushing module.

Additionally we don't need to point to the exact psd1 path to publish module, as Publish-ModuleTo search recursively for psd1 file and push it.

This module is base for other, more specific ones. Please check out Publish-ModuleToPowershellGallery
