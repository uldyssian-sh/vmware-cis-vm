# API Reference

## Parameters

### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `vCenter` | String | vCenter Server FQDN or IP |
| `VMName` | String | Target VM name |

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `Credential` | PSCredential | Prompt | vCenter credentials |
| `WhatIf` | Switch | False | Preview mode |
| `Backup` | Switch | False | Create backup |
| `LogPath` | String | Auto | Log file path |

## Return Values

### Success
```powershell
@{
    Status = "Success"
    VMName = "MyVM"
    SettingsApplied = 35
    Timestamp = "2024-01-15T10:30:00Z"
}
```

### Error
```powershell
@{
    Status = "Error"
    VMName = "MyVM"
    ErrorMessage = "VM not found"
    Timestamp = "2024-01-15T10:30:00Z"
}
```

## Exit Codes

| Code | Description |
|------|-------------|
| 0 | Success |
| 1 | VM not found |
| 2 | Connection failed |
| 3 | Permission denied |
| 4 | PowerCLI not found |

## Examples

```powershell
# Basic usage
./apply-cis-vm-hardening.ps1 -vCenter "vc.lab.com" -VMName "VM01"

# With backup
./apply-cis-vm-hardening.ps1 -vCenter "vc.lab.com" -VMName "VM01" -Backup

# Preview mode
./apply-cis-vm-hardening.ps1 -vCenter "vc.lab.com" -VMName "VM01" -WhatIf
```