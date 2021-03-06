function Remove-AzureResourceGroups {
    param (
        [object] $armParameters
    )

    Write-ScriptSection "Removing Azure Resource Groups"

    # ORDER MATTERS!!!
    $resourceGroupsToRemove = @(
        $armParameters.cognitiveServicesResourceGroupName
        $armParameters.dnsResourceGroupName
        $armParameters.applicationGatewayResourceGroupName
        $armParameters.trafficManagerResourceGroupName
        $armParameters.sqlTodoResourceGroupName
        $armParameters.secondaryRegionHelloWorldWebAppResourceGroupName
        $armParameters.primaryRegionHelloWorldWebAppResourceGroupName
        $armParameters.imageResizerResourceGroupName
        $armParameters.secondaryRegionAppServicePlanResourceGroupName
        $armParameters.primaryRegionAppServicePlanResourceGroupName
        $armParameters.aksResourceGroupName
        $armParameters.wordpressResourceGroupName
        $armParameters.containerRegistryResourceGroupName
        $armParameters.alertsResourceGroupName
        $armParameters.vmssResourceGroupName
        $armParameters.ntierResourceGroupName
        $armParameters.w10clientResourceGroupName
        $armParameters.developerResourceGroupName
        $armParameters.jumpboxResourceGroupName
        $armParameters.bastionResourceGroupName
        $armParameters.storageResourceGroupName
        $armParameters.networkingResourceGroupName
        $armParameters.managedIdentityResourceGroupName
    )

    $resourceGroupsToRemove | ForEach-Object {
        $resourceGroupExists = Confirm-AzureResourceExists 'group' $_
        if (-not $resourceGroupExists) {
            Write-Log "The resource group $_ does not exist; skipping."
            return
        }
        
        Write-Log "Removing $_ Resource Group"

        az group delete -n $_ -y
        Confirm-LastExitCode

        Write-Log "Removed $_ Resourced Group"
    }

    Write-ScriptSection "Finished Removing Azure Resource Groups"
}