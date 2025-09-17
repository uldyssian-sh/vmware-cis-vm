# API Documentation

## PowerShell Cmdlets Reference

### apply-cis-vm-hardening.ps1

Main hardening script that applies CIS security parameters to VMware VMs.

#### Parameters

- **vCenter** (Required): vCenter Server FQDN or IP address
- **VMName** (Required): Target Virtual Machine name

#### Examples

```powershell
# Basic usage
.\apply-cis-vm-hardening.ps1 -vCenter "vcenter.lab.com" -VMName "WebServer-01"

# With error handling
try {
    .\apply-cis-vm-hardening.ps1 -vCenter "vcenter.lab.com" -VMName "WebServer-01"
    Write-Host "Hardening completed successfully"
} catch {
    Write-Error "Hardening failed: $($_.Exception.Message)"
}
```

#### Return Values

- **0**: Success
- **1**: Error (VM not found, connection failed, etc.)

## Bulk Operations

### bulk-hardening.ps1

Apply hardening to multiple VMs using patterns.

```powershell
.\scripts\bulk-hardening.ps1 -vCenter "vcenter.com" -VMPattern "Prod*"
```

### validate-hardening.ps1

Validate applied hardening settings.

```powershell
.\scripts\validate-hardening.ps1 -vCenter "vcenter.com" -VMName "TestVM"
```

## Configuration Options

### Environment Variables

- `VMWARE_CIS_CONFIG`: Path to custom configuration file
- `VMWARE_CIS_LOG_LEVEL`: Logging verbosity (Verbose, Normal, Quiet)

### Custom Parameters

Override default hardening parameters via JSON configuration:

```json
{
  "customParameters": {
    "isolation.tools.unity.disable": "TRUE",
    "log.keepOld": "15"
  }
}
```