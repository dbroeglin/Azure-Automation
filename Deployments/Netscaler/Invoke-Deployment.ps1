Param(
    [String]
    $ResourceGroupName = "NS",

    [String]
    $Location = 'West Europe',

    [SecureString]
    $AdminPassword
)

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location

New-AzureRmResourceGroupDeployment `
    -Name test `
    -ResourceGroupName $ResourceGroupName `
    -Verbose `
    -TemplateFile ./ARM/netscaler-ha-3nic.json `
    -TemplateParameterObject @{
        adminUsername        = "nsoperator"
        adminPassword        = $AdminPassword
        vmSku                = "netscaler10enterprise"
        vnetName             = "ns-vnet"
        vnetResourceGroup    = "NS-NET"
        vnetNewOrExisting    = "existing"
        managementSubnetName = "FirewallManagementSubnet"
        frontendSubnetName   = "FirewallSubnet"
        backendSubnetName    = "FirewallBackendSubnet"
        lbFrontendIpAddress  = "10.218.0.65"
        backendIPAddresses   = @(
            "10.218.2.4"
            "10.218.2.5"
        )
    }