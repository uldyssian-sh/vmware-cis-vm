BeforeAll {
    $ScriptPath = Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "apply-cis-vm-hardening.ps1"
}

Describe "Full Hardening Integration Tests" {
    
    Context "Script Execution" {
        It "Should validate script exists" {
            Test-Path $ScriptPath | Should -Be $true
        }
        
        It "Should have valid PowerShell syntax" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            { [scriptblock]::Create($ScriptContent) } | Should -Not -Throw
        }
    }
    
    Context "Configuration Validation" {
        It "Should contain all required hardening parameters" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            
            # Core isolation parameters
            $ScriptContent | Should -Match "isolation\.bios\.bbs\.disable"
            $ScriptContent | Should -Match "isolation\.device\.connectable\.disable"
            $ScriptContent | Should -Match "isolation\.tools\.copy\.disable"
            $ScriptContent | Should -Match "isolation\.tools\.paste\.disable"
            $ScriptContent | Should -Match "isolation\.tools\.dnd\.disable"
            
            # Logging parameters
            $ScriptContent | Should -Match "log\.keepOld"
            $ScriptContent | Should -Match "log\.rotateSize"
            
            # Display security
            $ScriptContent | Should -Match "mks\.enable3d"
            $ScriptContent | Should -Match "RemoteDisplay\.vnc\.enabled"
            
            # Device management
            $ScriptContent | Should -Match "devices\.hotplug"
        }
        
        It "Should have proper parameter values" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            
            # Check for secure values
            $ScriptContent | Should -Match "EnableUUID TRUE"
            $ScriptContent | Should -Match "mks\.enable3d FALSE"
            $ScriptContent | Should -Match "RemoteDisplay\.vnc\.enabled FALSE"
            $ScriptContent | Should -Match "devices\.hotplug FALSE"
        }
    }
    
    Context "Security Compliance" {
        It "Should implement CIS benchmark recommendations" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            
            # Verify key CIS controls are present
            $RequiredControls = @(
                "isolation\.tools\.copy\.disable",
                "isolation\.tools\.paste\.disable", 
                "isolation\.tools\.dnd\.disable",
                "isolation\.device\.connectable\.disable",
                "RemoteDisplay\.vnc\.enabled",
                "mks\.enable3d",
                "devices\.hotplug"
            )
            
            foreach ($Control in $RequiredControls) {
                $ScriptContent | Should -Match $Control
            }
        }
    }
}# Updated 20251109_123814
# Updated Sun Nov  9 12:52:26 CET 2025
