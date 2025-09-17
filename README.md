# VMware CIS VM

[![GitHub license](https://img.shields.io/github/license/uldyssian-sh/vmware-cis-vm)](https://github.com/uldyssian-sh/vmware-cis-vm/blob/main/LICENSE)
[![CI](https://github.com/uldyssian-sh/vmware-cis-vm/workflows/CI/badge.svg)](https://github.com/uldyssian-sh/vmware-cis-vm/actions)

## 🚀 Overview

VMware Center for Internet Security (CIS) virtual machine hardening and compliance automation. Implements CIS benchmarks for VMware vSphere virtual machines with PowerCLI automation.

**Technology Stack:** PowerCLI, PowerShell, vSphere API, CIS Benchmarks

## ✨ Features

- 🔒 **CIS Benchmark Compliance** - Automated CIS hardening
- 🔍 **Security Assessment** - Comprehensive security scanning
- 📊 **Compliance Reporting** - Detailed compliance reports
- 🔧 **Automated Remediation** - Fix security misconfigurations
- 📈 **Continuous Monitoring** - Ongoing compliance validation
- 🎯 **Policy Management** - Custom security policies

## 🛠️ Prerequisites

- PowerCLI 12.0+
- PowerShell 5.1+ or PowerShell Core 7+
- vCenter Server access
- Administrative privileges on target VMs

## 🚀 Quick Start

```powershell
# Clone repository
git clone https://github.com/uldyssian-sh/vmware-cis-vm.git
cd vmware-cis-vm

# Import PowerCLI module
Import-Module VMware.PowerCLI

# Connect to vCenter
Connect-VIServer -Server vcenter.domain.com

# Run CIS assessment
.\scripts\Invoke-CISAssessment.ps1 -VMName "target-vm"

# Apply CIS hardening
.\scripts\Invoke-CISHardening.ps1 -VMName "target-vm"
```

## 📋 CIS Controls

### Level 1 Controls (Basic)
- VM hardware configuration
- Guest OS security settings
- Network security controls
- Storage encryption
- Logging configuration

### Level 2 Controls (Advanced)
- Advanced security features
- Detailed audit logging
- Enhanced access controls
- Security monitoring
- Compliance validation

## 🔧 Available Scripts

| Script | Description |
|--------|-------------|
| `Invoke-CISAssessment.ps1` | Run CIS compliance assessment |
| `Invoke-CISHardening.ps1` | Apply CIS hardening measures |
| `Get-ComplianceReport.ps1` | Generate compliance reports |
| `Set-SecurityBaseline.ps1` | Configure security baseline |
| `Test-VMCompliance.ps1` | Validate VM compliance |

## 📊 Compliance Reporting

```powershell
# Generate detailed compliance report
.\scripts\Get-ComplianceReport.ps1 -VMName "target-vm" -OutputPath "C:\Reports\"

# Export results to CSV
.\scripts\Export-ComplianceResults.ps1 -Format CSV -Path "C:\Reports\compliance.csv"

# Generate executive summary
.\scripts\Get-ExecutiveSummary.ps1 -ReportPath "C:\Reports\"
```

## 🔒 Security Controls

### VM Configuration
- Disable unnecessary hardware
- Configure secure boot
- Enable VM encryption
- Set resource limits

### Guest OS Hardening
- User account management
- Service configuration
- Registry settings
- File system permissions

### Network Security
- Network isolation
- Firewall configuration
- Protocol restrictions
- Traffic monitoring

## 📈 Monitoring & Alerting

- Real-time compliance monitoring
- Security event alerting
- Drift detection
- Automated remediation

## 📚 Documentation

- [CIS Benchmark Guide](docs/cis-benchmark.md)
- [Hardening Procedures](docs/hardening.md)
- [Compliance Reporting](docs/reporting.md)
- [Troubleshooting](docs/troubleshooting.md)

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.
