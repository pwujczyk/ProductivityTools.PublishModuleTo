clear
Import-Module D:\GitHub\ProductivityTools.PSPublishModuleTo\ProductivityTools.PSPublishModuleTo\ProductivityTools.PSPublishModuleTo.psm1 -Force
cd D:\GitHub\ProductivityTools.PSPublishModuleTo\
Set-MasterConfigurationBaseConfigurationFile -BaseConfigurationFileName D:\Tech\PSMasterConfiguration.xml

#Set-MasterConfiguration -Key PSGalleryApiKey -Value "xxx"
Publish-ModuleTo -PSRepository PSGallery -PSRepositoryApiKey PSRepositoryApiKey -Verbose