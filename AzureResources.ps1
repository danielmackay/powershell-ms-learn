# Login
Connect-AzAccount

# Subscriptions
Get-AzSubscription
# Visual Studio Enterprise Subscription
Set-AzContext -Subscription "SUBSCRIPTION-ID-GOES-HERE"

# Resource Group
Get-AzResourceGroup | Format-Table
New-AzResourceGroup -Name "test-rg" -Location "AustraliaEast"

# Resources
Get-AzResource | Format-Table
Get-AzResource -ResourceGroupName "YOUR-RG-NAME" | Format-Table

# Virtual Machines