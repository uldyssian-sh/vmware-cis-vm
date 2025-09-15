# VMware vSphere VM CIS Hardening Tool

[![PowerShell](https://img.shields.io/badge/PowerShell-7%2B-blue.svg)](https://github.com/PowerShell/PowerShell)
[![VMware PowerCLI](https://img.shields.io/badge/PowerCLI-13%2B-green.svg)](https://developer.vmware.com/powercli)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CI/CD](https://github.com/uldyssian-sh/vmware-cis-vm/workflows/CI%2FCD%20Pipeline/badge.svg)](https://github.com/uldyssian-sh/vmware-cis-vm/actions)
[![GitHub issues](https://img.shields.io/github/issues/uldyssian-sh/vmware-cis-vm)](https://github.com/uldyssian-sh/vmware-cis-vm/issues)
[![GitHub stars](https://img.shields.io/github/stars/uldyssian-sh/vmware-cis-vm)](https://github.com/uldyssian-sh/vmware-cis-vm/stargazers)

A comprehensive PowerShell tool for applying **CIS (Center for Internet Security) hardening configurations** to VMware vSphere Virtual Machines.
This tool implements security best practices to enhance VM security posture with a single command.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           VMware vSphere Environment                           │
├─────────────────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                        vCenter Server                                  │    │
│  │                    • Management Interface                              │    │
│  │                    • API Endpoints                                     │    │
│  │                    • Configuration Database                            │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
│                                       │                                         │
│                                       ▼                                         │
│  ┌─────────────────┬─────────────────┬─────────────────────────────────────┐    │
│  │   ESXi Host 1   │   ESXi Host 2   │   ESXi Host 3                       │    │
│  │                 │                 │                                     │    │
│  │ ┌─────────────┐ │ ┌─────────────┐ │ ┌─────────────┐                     │    │
│  │ │ Virtual     │ │ │ Virtual     │ │ │ Virtual     │                     │    │
│  │ │ Machines    │ │ │ Machines    │ │ │ Machines    │                     │    │
│  │ │             │ │ │             │ │ │             │                     │    │
│  │ │ • Security  │ │ │ • Security  │ │ │ • Security  │                     │    │
│  │ │ • Config    │ │ │ • Config    │ │ │ • Config    │                     │    │
│  │ │ • Compliance│ │ │ • Compliance│ │ │ • Compliance│                     │    │
│  │ └─────────────┘ │ └─────────────┘ │ └─────────────┘                     │    │
│  └─────────────────┴─────────────────┴─────────────────────────────────────┘    │
│                                       │                                         │
│                                       ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                      Audit & Compliance Engine                         │    │
│  │              • Security Checks • Configuration Validation              │    │
│  │              • Compliance Reports • Remediation Guidance               │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────────────────┘
```

**Author**: LT - [GitHub Profile](https://github.com/uldyssian-sh)

## 🚀 Features

- **One-Click Hardening**: Apply all CIS VM security settings instantly
- **Comprehensive Coverage**: 35+ security parameters aligned with CIS benchmarks
- **Safe Operations**: Non-destructive configuration changes with rollback capability
- **Cross-Platform**: Works on Windows, Linux, and macOS with PowerShell 7+
- **Production Ready**: Extensively tested with error handling and logging
- **Zero Dependencies**: Only requires VMware PowerCLI

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Installation](#installation)
- [Usage](#usage)
- [Security Settings](#security-settings)
- [Examples](#examples)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## ⚡ Quick Start

```powershell
# Clone the repository
git clone https://github.com/uldyssian-sh/vmware-cis-vm.git
cd vmware-cis-vm

# Apply CIS hardening to a VM
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM"
```

## 📦 Installation

### Prerequisites

- **PowerShell**: 7.0+ (recommended) or Windows PowerShell 5.1+
- **VMware PowerCLI**: Version 13.0 or higher
- **vSphere Access**: Permissions to modify VM advanced settings
- **Network**: Connectivity to vCenter Server on port 443

### Install PowerCLI

```powershell
# Install PowerCLI for current user
Install-Module -Name VMware.PowerCLI -Scope CurrentUser -Force

# Verify installation
Get-Module -ListAvailable VMware.PowerCLI
```

### Download Tool

#### Option 1: Git Clone
```bash
git clone https://github.com/uldyssian-sh/vmware-cis-vm.git
cd vmware-cis-vm
```

#### Option 2: Direct Download
Download the latest release from [Releases](https://github.com/uldyssian-sh/vmware-cis-vm/releases)

## 🔧 Usage

### Basic Syntax

```powershell
./apply-cis-vm-hardening.ps1 -vCenter <vCenter-FQDN> -VMName <VM-Name> [OPTIONS]
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vCenter` | String | Yes | vCenter Server FQDN or IP address |
| `VMName` | String | Yes | Target Virtual Machine name |
| `Credential` | PSCredential | No | vCenter credentials (prompts if not provided) |
| `WhatIf` | Switch | No | Preview changes without applying them |
| `Backup` | Switch | No | Create configuration backup before changes |
| `LogPath` | String | No | Custom log file path |

### Basic Examples

```powershell
# Apply hardening with credential prompt
./apply-cis-vm-hardening.ps1 -vCenter "vcsa.lab.local" -VMName "WebServer01"

# Preview changes without applying
./apply-cis-vm-hardening.ps1 -vCenter "vcsa.lab.local" -VMName "WebServer01" -WhatIf

# Apply with backup and custom logging
./apply-cis-vm-hardening.ps1 -vCenter "vcsa.lab.local" -VMName "WebServer01" -Backup -LogPath "C:\Logs\hardening.log"
```

## 🔒 Security Settings

The tool applies the following CIS-recommended security configurations:

### Guest Operations Control
- **Copy/Paste Operations**: Disabled to prevent data exfiltration
- **Drag & Drop**: Disabled to prevent unauthorized file transfers
- **GUI Options**: Restricted to limit guest customization
- **Unity Mode**: Disabled to prevent desktop integration vulnerabilities

### Device Security
- **Device Connectivity**: Restricted hotplug operations
- **USB/Serial Devices**: Controlled access to prevent data theft
- **CD/DVD Drives**: Secured to prevent unauthorized media access
- **Floppy Drives**: Disabled legacy device access

### Remote Access Control
- **VNC Access**: Disabled or limited connections
- **Remote Display**: Maximum connection limits enforced
- **Console Access**: Secured with proper authentication

### System Hardening
- **BIOS Settings**: Boot sequence protection
- **UUID Generation**: Enabled for proper VM identification
- **Logging**: Enhanced audit trail with rotation policies
- **Memory Protection**: Secured memory operations

### VMware Tools Isolation
- **Host Information**: Limited guest access to host details
- **Credential Access**: Prevented unauthorized credential harvesting
- **System Integration**: Controlled host-guest interactions

## 📚 Examples

### Production Environment
```powershell
# Harden multiple VMs with backup
$vms = @("WebServer01", "WebServer02", "DBServer01")
foreach ($vm in $vms) {
    ./apply-cis-vm-hardening.ps1 -vCenter "prod-vcenter.company.com" -VMName $vm -Backup
}
```

### Development Environment
```powershell
# Preview changes in dev environment
./apply-cis-vm-hardening.ps1 -vCenter "dev-vcenter.lab.local" -VMName "DevVM01" -WhatIf
```

### Automated Deployment
```powershell
# Use stored credentials for automation
$cred = Get-Credential
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "AutoVM" -Credential $cred
```

## ⚙️ Configuration

### PowerCLI Setup
```powershell
# Configure PowerCLI for your environment
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -DefaultVIServerMode Multiple -Confirm:$false
```

### Custom Settings
Create a `config.json` file to customize hardening parameters:

```json
{
  "logging": {
    "keepOld": 10,
    "rotateSize": 2048000
  },
  "remoteDisplay": {
    "maxConnections": 1,
    "vncEnabled": false
  },
  "devices": {
    "hotplug": false,
    "usbAccess": false
  }
}
```

## 🔧 Troubleshooting

### Common Issues

#### PowerCLI Not Found
```
Error: VMware.PowerCLI module not found
```
**Solution:**
```powershell
Install-Module -Name VMware.PowerCLI -Scope CurrentUser -Force
```

#### Connection Issues
```
Error: Could not connect to vCenter Server
```
**Solutions:**
- Verify vCenter FQDN/IP: `Test-NetConnection vcenter.example.com -Port 443`
- Check credentials and permissions
- Validate certificate trust settings

#### Permission Errors
```
Error: Insufficient permissions to modify VM settings
```
**Required Permissions:**
- Virtual Machine → Configuration → Modify device settings
- Virtual Machine → Configuration → Advanced configuration
- Virtual Machine → Configuration → Change Settings

#### VM Not Found
```
Error: VM 'VMName' not found
```
**Solutions:**
- Verify VM name spelling and case sensitivity
- Check VM visibility in vCenter inventory
- Ensure VM is not in a restricted folder

### Debug Mode
Enable verbose logging for troubleshooting:
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM" -Verbose
```

### Log Analysis
Check log files for detailed error information:
- **Windows**: `%TEMP%\vmware-cis-hardening.log`
- **Linux/macOS**: `/tmp/vmware-cis-hardening.log`

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes and add tests
4. Run tests: `./tests/Run-Tests.ps1`
5. Commit changes: `git commit -m 'Add amazing feature'`
6. Push to branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

### Reporting Issues
Please use [GitHub Issues](https://github.com/uldyssian-sh/vmware-cis-vm/issues) to report bugs or request features.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [CIS VMware vSphere Benchmark](https://www.cisecurity.org/benchmark/vmware_vsphere)
- [VMware vSphere Security Guide](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-security/)
- [VMware PowerCLI Community](https://developer.vmware.com/powercli)

## 📞 Support

- **Documentation**: [Wiki](https://github.com/uldyssian-sh/vmware-cis-vm/wiki)
- **Issues**: [GitHub Issues](https://github.com/uldyssian-sh/vmware-cis-vm/issues)
- **Discussions**: [GitHub Discussions](https://github.com/uldyssian-sh/vmware-cis-vm/discussions)

---

**⚠️ Disclaimer**: This tool is provided "as is" without warranty.
Always test in non-production environments first.
Users are responsible for reviewing and validating all configurations in their specific environments.
