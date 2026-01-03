# VMware CIS Virtual Machine Hardening


## 🛡️ Overview

Automated CIS (Center for Internet Security) benchmark compliance tool for VMware virtual machines. Hardens VM configurations according to industry security standards.

## 🎯 Features

- **CIS Benchmark Compliance**: Automated security hardening
- **Multi-OS Support**: Windows and Linux virtual machines  
- **Compliance Reporting**: Detailed security assessment reports
- **Remediation Scripts**: Automated fix deployment
- **Audit Logging**: Complete audit trail of changes

## 🚀 Quick Start

```powershell
# Prerequisites: PowerCLI 13.0+, vCenter access
Import-Module VMware.PowerCLI
Connect-VIServer -Server vcenter.company.com

# Clone and run
git clone https://github.com/uldyssian-sh/vmware-cis-vm.git
cd vmware-cis-vm
.\apply-cis-vm-hardening.ps1 -vCenter "vcenter.company.com" -VMName "target-vm"
```

## 📁 Repository Structure

- [`apply-cis-vm-hardening.ps1`](apply-cis-vm-hardening.ps1) - Main hardening script
- [`scripts/`](scripts/) - Additional PowerShell scripts
- [`config/`](config/) - Configuration files
- [`docs/`](docs/) - Documentation
- [`examples/`](examples/) - Usage examples
- [`tests/`](tests/) - Test scripts

## 🔧 Configuration

Edit [`config/sample-config.json`](config/sample-config.json) to customize hardening parameters.

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---
**Maintained by**: [uldyssian-sh](https://github.com/uldyssian-sh)
⭐ Star this repository if you find it helpful!