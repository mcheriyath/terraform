# Variables    
    ## Global
    $rgName = "devopsdenvermcresourcegroup"
    $location = "eastus"

    ## Storage
    $storageName = "pkdevopsdenvermcstorage"
    $storageType = "Standard_LRS"

    ## Network
    $nicname = "testnic"
    $subnet1Name = "subnet1"
    $vnetName = "testnet"
    $vnetAddressPrefix = "10.0.0.0/16"
    $vnetSubnetAddressPrefix = "10.0.0.0/24"

    ## Compute
    $vmName = "testvm"
    $computerName = "testcomputer"
    $vmSize = "Standard_A2"
    $osDiskName = $vmName + "osDisk"

# Network
$pip = New-AzureRmPublicIpAddress -Name $nicname -ResourceGroupName $rgName -Location $location -AllocationMethod Dynamic
$subnetconfig = New-AzureRmVirtualNetworkSubnetConfig -Name $subnet1Name -AddressPrefix $vnetSubnetAddressPrefix
$vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -Location $location -AddressPrefix $vnetAddressPrefix -Subnet $subnetconfig
$nic = New-AzureRmNetworkInterface -Name $nicname -ResourceGroupName $rgName -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id

# Compute
    ## Setup local VM object
    $vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize

    $vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
    $osDiskUri = "https://pkdenverdevopsmcstorage.blob.core.windows.net/den-devops-mc-win2012r2/disk-1.vhd"
    $vm = Set-AzureRmVMOSDisk -VM $vm -Name $osDiskName -VhdUri $osDiskUri -CreateOption attach -Windows

    ## Create the VM in Azure
    New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vm -Verbose -Debug
