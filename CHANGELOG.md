# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive test suite with Pester framework
- GitHub Actions CI/CD pipeline with multi-platform testing
- Enhanced documentation with usage examples
- Configuration backup functionality
- WhatIf parameter for preview mode
- Custom logging capabilities
- Security scanning in CI pipeline
- Issue templates for better bug reporting
- Contributing guidelines and code of conduct

### Changed
- Improved error handling with detailed messages
- Enhanced parameter validation
- Better PowerCLI configuration management
- Optimized performance for large environments

### Fixed
- PowerCLI module detection on different platforms
- Connection timeout handling
- VM name case sensitivity issues

## [1.0.0] - 2024-01-15

### Added
- Initial release of VMware vSphere VM CIS Hardening Tool
- Core hardening functionality with 35+ security parameters
- Support for PowerCLI 13+ and PowerShell 7+
- Cross-platform compatibility (Windows, Linux, macOS)
- Basic error handling and logging
- MIT License

### Security
- Implementation of CIS benchmark recommendations
- Guest operations isolation settings
- Device connectivity restrictions
- Remote access controls
- VMware Tools security configurations

## [0.9.0] - 2024-01-10

### Added
- Beta version with core hardening parameters
- Basic vCenter connectivity
- VM configuration modification via ExtensionData
- Console output with applied settings

### Changed
- Refactored parameter application logic
- Improved script structure and readability

### Fixed
- PowerCLI session configuration issues
- VM object retrieval problems

## [0.8.0] - 2024-01-05

### Added
- Alpha version with proof of concept
- Basic VM hardening parameters
- Simple PowerCLI integration

---

## Types of Changes

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
