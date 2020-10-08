<p align="right">
 <a href="https://www.powershellgallery.com/packages/ProductivityTools.PSPublishModuleTo/">
  <img src="http://cdn.productivitytools.tech/Powershell40px.png" /></a>
<a href="http://www.productivitytools.tech/publish-moduleto//">
<img src="http://cdn.productivitytools.tech/Blog40px.png" /></a>
</p>


# ProductivityTools.PSPublishModuleTo


Publishing module to Powershell gallery is very straight-forward task. To do it we just need to invoke command

```powershell
Publish-Module -NuGetApiKey $nuGetApiKey -Name $fullPath
```

If we are pushing to different repository than default. We also can provide PSRepository  parameter.

```powershell
Publish-Module -PSRepository $psRepository -NuGetApiKey $nuGetApiKey -Name $fullPath
```

When publishing module we are always providing the same pair of information, so described module help to automate it a little bit.

First of all Publish-ModuleTo gets nugetApiKey from MasterConfiguration, so we don't need to provide it every time we pushing module.

Additionally we don't need to point to the exact psd1 path to publish module, as Publish-ModuleTo search recursively for psd1 file and push it.

This module is base for other, more specific ones. Please check out [Publish-ModuleToPowershellGallery](https://github.com/pwujczyk/ProductivityTools.PublishModuleToPowershellGallery)

## Examples 
To use it first You need to save NugetApiKey in the MasterConfiguration
```powershell
Set-MasterConfiguration -Key PSGalleryApiKey -Value "xxx"
```

Next go to the directory of the module (or parent directory) and invoke
```powershell
Publish-ModuleTo -PSRepository PSGallery -PSRepositoryApiKey PSGalleryApiKey -Verbose
```
