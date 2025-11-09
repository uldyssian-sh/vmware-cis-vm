#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Validates CIS hardening settings on VMware VMs

.PARAMETER vCenter
    vCenter Server FQDN or IP

.PARAMETER VMName
    VM name to validate
#>

param(
    [Parameter(Mandatory)]
    [string]$vCenter,
    
    [Parameter(Mandatory)]
    [string]$VMName
)

Connect-VIServer -Server $vCenter
$VM = Get-VM -Name $VMName
$Settings = $VM | Get-AdvancedSetting

$Checks = @{
    "EnableUUID" = "TRUE"
    "isolation.tools.copy.disable" = "TRUE"
    "isolation.tools.paste.disable" = "TRUE"
    "RemoteDisplay.vnc.enabled" = "FALSE"
}

$Results = @()
foreach ($Check in $Checks.GetEnumerator()) {
    $Setting = $Settings | Where-Object { $_.Name -eq $Check.Key }
    $Status = if ($Setting -and $Setting.Value -eq $Check.Value) { "PASS" } else { "FAIL" }
    
    $Results += [PSCustomObject]@{
        Setting = $Check.Key
        Expected = $Check.Value
        Actual = if ($Setting) { $Setting.Value } else { "NOT SET" }
        Status = $Status
    }
}

$Results | Format-Table -AutoSize
$PassCount = ($Results | Where-Object { $_.Status -eq "PASS" }).Count
Write-Host "Compliance: $PassCount/$($Results.Count) checks passed" -ForegroundColor $(if ($PassCount -eq $Results.Count) { "Green" } else { "Yellow" })# Updated Sun Nov  9 12:52:26 CET 2025
