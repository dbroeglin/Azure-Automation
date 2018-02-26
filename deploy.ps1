Param(
    [String]
    $ResourceGroupName = "NETSCALER",

    [pscredential]
    $AdminCredential
)

New-AzureRmResourceGroup -Name $ResourceGroupName -Location "West Europe"
New-AzureRmResourceGroupDeployment -Name "$ResourceGroupName-Deployment" `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile .\Deployments\NS-VPX-EXPRESS\ARM\netscaler-vpx-express.json `
    -TemplateParameterObject @{
        Location = "West Europe"
        virtualMachineName = "ns-vpx-express"
        virtualMachineSize = "Standard_A2"
        adminUsername = $AdminCredential.UserName
        adminPassword = $AdminCredential.GetNetworkCredential().Password
        virtualNetworkName = "ns-vnet"
        vnetRG = $ResourceGroupName
        vnetNewOrExisting = 'new'
        networkInterfaceName = "ns-vpx-nic"
        networkSecurityGroupName = "ns-vpx-nsg"
        #diagnosticsStorageAccountName = "storageadom23123123"
        diagnosticsStorageAccountType = "Standard_LRS"
        addressPrefix = "10.0.0.0/20"
        subnetName = "ns-vpx-front"
        subnetPrefix = "10.0.0.0/24"
    }