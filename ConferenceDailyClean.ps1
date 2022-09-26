# Assumes the user has already run Connect-AzAccount and Set-AzContext

param([string]$resourceGroup)

for ($i = 1; $i -le 3; $i++) {
    $vmName = "ConferenceDemo$i"

    $vm = (Get-AzVm -Name $vmName -ResourceGroupName $resourceGroup)
    if ($null -eq $vm){
        throw "ERROR: Could not find VM"
    }

    Write-Host "Removing VM"
    Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
    Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName

    Write-Host "Removing Network Interface"
    $vm | Remove-AzNetworkInterface -Force

    Write-Host "Removing Disk"
    Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OsDisk.Name | Remove-AzDisk -Force

    Write-Host "Removing Network"
    Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force

    Write-Host "Removing Security Group"
    Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force

    Write-Host "Removing Public IP"
    Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
}
