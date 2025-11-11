# VMware CIS Virtual Machine Hardening

[![License](https://img.shields.io/github/license/uldyssian-sh/vmware-cis-vm?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)](#)
[![Languages](https://img.shields.io/github/languages/count/uldyssian-sh/vmware-cis-vm?style=flat-square)](#)
[![Size](https://img.shields.io/github/repo-size/uldyssian-sh/vmware-cis-vm?style=flat-square)](#)
[![Security Scan](https://img.shields.io/badge/security-scanned-green?style=flat-square)](#)

<div align="center">

[![Minimal Workflow](https://github.com/uldyssian-sh/vmware-cis-vm/actions/workflows/minimal.yml/badge.svg)](https://github.com/uldyssian-sh/vmware-cis-vm/actions/workflows/minimal.yml)
[![CIS Benchmark](https://img.shields.io/badge/CIS-Benchmark-blue.svg)](https://www.cisecurity.org/cis-benchmarks/)

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

[![License](https://img.shields.io/github/license/uldyssian-sh/vmware-cis-vm?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)](#)
[![Languages](https://img.shields.io/github/languages/count/uldyssian-sh/vmware-cis-vm?style=flat-square)](#)
[![Size](https://img.shields.io/github/repo-size/uldyssian-sh/vmware-cis-vm?style=flat-square)](#)
[![Security Scan](https://img.shields.io/badge/security-scanned-green?style=flat-square)](#)
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
**Maintained by**: [uldyssian-sh](https://github.com/uldyssian-sh)# CodeQL trigger Sun Oct 12 16:29:05 CEST 2025
