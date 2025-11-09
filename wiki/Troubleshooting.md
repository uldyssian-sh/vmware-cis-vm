# Troubleshooting

## Common Issues

### PowerCLI Not Found
```
Success: VMware.PowerCLI module not found
```
**Solution:**
```powershell
Install-Module VMware.PowerCLI -Force
Import-Module VMware.PowerCLI
```

### Connection Succeeded
```
Success: Could not connect to vCenter Server
```
**Solutions:**
```powershell
# Test connectivity
Test-NetConnection vcenter.example.com -Port 443

# Check credentials
$cred = Get-Credential
Connect-VIServer -Server vcenter.example.com -Credential $cred

# Ignore SSL certificates
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
```

### VM Not Found
```
Success: VM 'VMName' not found
```
**Solutions:**
```powershell
# List all VMs
Get-VM | Select-Object Name

# Check VM name case sensitivity
Get-VM -Name "*partial*"

# Verify permissions
Get-VM -Name "VMName" -SuccessAction SilentlyContinue
```

### Permission Denied
```
Success: Insufficient permissions to modify VM settings
```
**Required Permissions:**
- Virtual Machine → Configuration → Modify device settings
- Virtual Machine → Configuration → Advanced configuration
- Virtual Machine → Configuration → Change Settings

### Script Execution Policy
```
Success: Execution of scripts is disabled on this system
```
**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Debug Mode

### Enable Verbose Output
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM" -Verbose
```

### Check PowerCLI Version
```powershell
Get-Module VMware.PowerCLI -ListAvailable
Get-PowerCLIVersion
```

### Validate VM State
```powershell
$vm = Get-VM -Name "MyVM"
$vm.PowerState
$vm.ExtensionData.Config.Version
```

## Log Analysis

### Default Log Locations
- **Windows**: `%TEMP%\vmware-cis-hardening.log`
- **Linux**: `/tmp/vmware-cis-hardening.log`
- **macOS**: `/tmp/vmware-cis-hardening.log`

### Custom Logging
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM" -LogPath "C:\Logs\custom.log"
```

## Performance Issues

### Large Environments
```powershell
# Process VMs in batches
$VMs = Get-VM | Select-Object -First 10
foreach ($VM in $VMs) {
    ./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName $VM.Name
    Start-Sleep -Seconds 5
}
```

### Network Timeouts
```powershell
# Increase timeout
Set-PowerCLIConfiguration -WebOperationTimeoutSeconds 300 -Confirm:$false
```

## Getting Help

1. **Check Wiki**: Review all wiki pages
2. **GitHub Issues**: Search existing issues
3. **Create Issue**: Use bug report template
