function Deploy-AzureKubernetesServicesVote {
    param(
        [object] $armParameters
    )

    Write-ScriptSection "Starting Azure Kubernetes Services: Vote Deployment"

    $aksResourceGroupName = $armParameters.aksResourceGroupName
    $aksClusterName = $armParameters.aksClusterName

    az aks get-credentials -g $aksResourceGroupName -n $aksClusterName
    Confirm-LastExitCode

    Write-Log "Retrieving Kubernetes Cluster Nodes"
    kubectl get nodes
    Confirm-LastExitCode
    
    Write-Log "Deploying Vote Application to Cluster"
    $applicationPath = 'https://raw.githubusercontent.com/Mitaric/AzureDemoEnvironment/master/yaml/azure-vote.yaml'
    kubectl apply -f $applicationPath
    Confirm-LastExitCode

    Write-Log "Getting Status of Kubernetes Service"
    Start-Sleep -Seconds 10
    kubectl get service azure-vote-front
    Confirm-LastExitCode
}