# VMware CIS Virtual Machine Hardening

<div align="center">

[![Deploy](https://github.com/uldyssian-sh/vmware-cis-vm/actions/workflows/deploy.yml/badge.svg)](https://github.com/uldyssian-sh/vmware-cis-vm/actions/workflows/deploy.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CIS Benchmark](https://img.shields.io/badge/CIS-Benchmark-blue.svg)](https://www.cisecurity.org/cis-benchmarks/)
[![VMware](https://img.shields.io/badge/VMware-vSphere-00A1C9.svg)](https://www.vmware.com/products/vsphere.html)

```
┌─────────────────────────────────────────────────────────────┐
│                CIS VM Hardening Framework                   │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐     │
│  │   vCenter   │────│ CIS Audit   │────│ Compliance  │     │
│  │ Connection  │    │   Engine    │    │   Reports   │     │
│  └─────────────┘    └─────────────┘    └─────────────┘     │
│         │                   │                   │          │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐     │
│  │ Virtual     │    │ Security    │    │ Remediation │     │
│  │ Machines    │    │ Controls    │    │   Scripts   │     │
│  └─────────────┘    └─────────────┘    └─────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

</div>

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

## 📚 Documentation

- [Installation Guide](https://github.com/uldyssian-sh/vmware-cis-vm/wiki/Installation)
- [CIS Controls Reference](https://github.com/uldyssian-sh/vmware-cis-vm/wiki/CIS-Controls)
- [Remediation Guide](https://github.com/uldyssian-sh/vmware-cis-vm/wiki/Remediation)

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.