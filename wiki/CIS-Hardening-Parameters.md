# CIS Hardening Parameters

## Guest Operations Control

| Parameter | Value | Description |
|-----------|-------|-------------|
| `isolation.tools.copy.disable` | TRUE | Disable copy operations |
| `isolation.tools.paste.disable` | TRUE | Disable paste operations |
| `isolation.tools.dnd.disable` | TRUE | Disable drag & drop |
| `isolation.tools.setGUIOptions.enable` | FALSE | Disable GUI options |
| `isolation.tools.diskShrink.disable` | TRUE | Disable disk shrinking |
| `isolation.tools.diskWiper.disable` | TRUE | Disable disk wiping |

## Device Security

| Parameter | Value | Description |
|-----------|-------|-------------|
| `isolation.device.connectable.disable` | TRUE | Disable device connectivity |
| `devices.hotplug` | FALSE | Disable hotplug devices |
| `isolation.bios.bbs.disable` | TRUE | Disable BIOS boot sequence |

## Remote Access Control

| Parameter | Value | Description |
|-----------|-------|-------------|
| `RemoteDisplay.vnc.enabled` | FALSE | Disable VNC console |
| `RemoteDisplay.maxConnections` | 1 | Limit remote connections |

## System Configuration

| Parameter | Value | Description |
|-----------|-------|-------------|
| `EnableUUID` | TRUE | Enable VM UUID |
| `log.keepOld` | 10 | Log rotation count |
| `log.rotateSize` | 2048000 | Log rotation size |
| `mks.enable3d` | FALSE | Disable 3D acceleration |

## VMware Tools Isolation

| Parameter | Value | Description |
|-----------|-------|-------------|
| `isolation.tools.getCreds.disable` | TRUE | Disable credential access |
| `isolation.tools.ghi.autologon.disable` | TRUE | Disable auto logon |
| `isolation.tools.unity.disable` | TRUE | Disable Unity mode |
| `isolation.tools.memSchedFakeSampleStats.disable` | TRUE | Disable memory stats |
| `tools.guestlib.enableHostInfo` | FALSE | Disable host info |
| `tools.setInfo.sizeLimit` | 1048576 | Limit info size |
| `tools.guest.desktop.autolock` | TRUE | Enable desktop autolock |

## Security Impact

### High Impact
- **VNC Disabled**: Prevents unauthorized console access
- **Device Hotplug**: Prevents USB/device attacks
- **Copy/Paste**: Prevents data exfiltration

### Medium Impact
- **Unity Mode**: Reduces desktop integration risks
- **3D Acceleration**: Prevents GPU-based attacks
- **Logging**: Improves audit capabilities

### Low Impact
- **GUI Options**: Reduces user customization
- **Memory Stats**: Prevents information disclosure# Updated Sun Nov  9 12:49:54 CET 2025
# Updated Sun Nov  9 12:52:26 CET 2025
# Updated Sun Nov  9 12:56:27 CET 2025
