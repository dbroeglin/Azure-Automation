Param(
    [String]
    $ResourceGroupName = "ARM-TEST",

    [String]
    $Location = 'West Europe'
)

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location -Force

New-AzureRmResourceGroupDeployment `
    -Name test `
    -ResourceGroupName $ResourceGroupName `
    -Verbose `
    -TemplateFile ./ARM/test.json `
    -TemplateParameterObject @{        
        lbFrontendIpAddress  = @(
            "10.218.0.65"
            "10.218.0.66"
        )
        frontendIPAddresses   = @(
            @(
                "10.218.0.4"
                "10.218.0.6"
            ),
            @(
                "10.218.0.5"
                "10.218.0.7"
            )
        )
        backendIPAddresses   = (
            (
                "10.218.2.4",
                "10.218.2.6"
            ),
            (
                "10.218.2.5",
                "10.218.2.7"
            )
        )
    } `
    -Debug