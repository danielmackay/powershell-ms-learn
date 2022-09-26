# Assumes the user has already run Connect-AzAccount and Set-AzContext

param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator"

for ($i = 1; $i -le 3; $i++) {
    $vmName = "ConferenceDemo$i"
    Write-Host "Creating VM: $vmName"
    New-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS
}