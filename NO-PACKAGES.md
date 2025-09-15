# No Packages Policy

This repository has been configured to **eliminate all package costs** and maintain GitHub free tier usage.

## Changes Made

### Removed:
- ✅ Docker image building (Dockerfile disabled)
- ✅ Docker Compose configuration (docker-compose.yml disabled)
- ✅ Container registry publishing
- ✅ Package creation workflows

### Alternative Usage:
Instead of Docker containers, use PowerShell directly:

```powershell
# Install dependencies
Install-Module VMware.PowerCLI -Force

# Run script directly
.\apply-cis-vm-hardening.ps1 -vCenter "your-vcenter" -VMName "your-vm"
```

## Benefits:
- 🆓 **Zero package costs**
- ⚡ **Faster execution** (no container overhead)
- 🔧 **Easier debugging**
- 📦 **No registry dependencies**

This ensures 100% free GitHub usage while maintaining full functionality.