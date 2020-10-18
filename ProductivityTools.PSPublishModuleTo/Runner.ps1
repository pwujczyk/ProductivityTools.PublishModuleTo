clear
Import-Module D:\GitHub\ProductivityTools.PSPublishModuleTo\ProductivityTools.PSPublishModuleTo\ProductivityTools.PSPublishModuleTo.psm1 -Force
cd D:\GitHub\ProductivityTools.PSPublishModuleTo\

$NuGetApiKey=Get-MasterConfiguration -Key PSRepositoryApiKey

#cd "D:\GitHub-3.PublishedToLinkedIn\ProductivityTools.PSMasterConfiguration\ProductivityTools.PSMasterConfiguration.Cmdlet\bin\Debug"
#cd "d:\GitHub-3.PublishedToLinkedIn\ProductivityTools.PSMasterConfiguration\ProductivityTools.PSMasterConfiguration.Cmdlet\"
#Set-MasterConfiguration -Key PSGalleryApiKey -Value "xxx"
#Publish-ModuleTo -PSRepositoryName PSGallery -NuGetApiKey PSRepositoryApiKey -Verbose  -IncreaseModuleVersion
Publish-ModuleTo -NuGetApiKey $NuGetApiKey -Verbose -IncreaseModuleVersion 