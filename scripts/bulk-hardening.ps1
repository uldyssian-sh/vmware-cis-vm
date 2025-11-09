#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Bulk CIS hardening for multiple VMs

.PARAMETER ConfigFile
    JSON config file with VM list
#>

param(
    [Parameter(Mandatory)]
    [string]$ConfigFile
)

$Config = Get-Content $ConfigFile | ConvertFrom-Json
$Results = @()

foreach ($VM in $Config.VMs) {
    try {
        Write-Host "Hardening $($VM.Name)..." -ForegroundColor Cyan
        & "$PSScriptRoot/../apply-cis-vm-hardening.ps1" -vCenter $VM.vCenter -VMName $VM.Name
        $Results += @{ VM = $VM.Name; Status = "Success" }
        Write-Host "✅ $($VM.Name) hardened" -ForegroundColor Green
    }
    catch {
        $Results += @{ VM = $VM.Name; Status = "Failed"; Error = $_.Exception.Message }
        Write-Host "❌ $($VM.Name) failed: $($_.Exception.Message)" -ForegroundColor Red
    }
}

$Results | ConvertTo-Json | Out-File "hardening-results-$(Get-Date -Format 'yyyyMMdd-HHmmss').json"# Updated Sun Nov  9 12:52:26 CET 2025
