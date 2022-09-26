# NOTE: After executing the variable initialisation below, each command is designed to be run sequentially one by one

$vmName = "testvm-auseast-01"
$rgName = "vm-dev-rg"
$location = "AustraliaEast"
$osName = "UbuntuLTS"
$publicIpAddressName = "test-vm-01"

# Login
Connect-AzAccount

# Subscriptions
Get-AzSubscription
Set-AzContext -Subscription "SUBSCRIPTION-ID-GOES-HERE"

# Resource Group
New-AzResourceGroup -Name $rgName -Location $location
Get-AzResourceGroup -Name $rgName
Get-AzResource -ResourceGroupName $rgName | Format-Table

# Virtual Machine

## Create VM
New-AzVM -ResourceGroupName $rgName -Name $vmName -Credential (Get-Credential) -Location $location -Image $osName -OpenPorts 22 -PublicIpAddressName $publicIpAddressName

## Inspect VM
$vm = (Get-AzVm -Name $vmName -ResourceGroupName $rgName)
$vm
$vm.HardwareProfile
$vm.StorageProfile.OsDisk
$vm | Get-AzVMSize
Get-AzPublicIpAddress -ResourceGroupName $rgName -Name $publicIpAddressName
ssh vm-admin@20.92.73.131

## Delete VM (and attached resources)
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
$vm | Remove-AzNetworkInterface -Force
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OsDisk.Name | Remove-AzDisk -Force
Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force

# Deleted Resource Group
Remove-AzResourceGroup -Name $vm.ResourceGroupName





