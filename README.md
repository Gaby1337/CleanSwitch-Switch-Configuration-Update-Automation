# ⚡ CleanSwitch
### Automated Switch Configuration Cleanup

A fully automated PowerShell tool designed to perform safe, repeatable VLAN and configuration cleanup across multiple switches using SSH.

---

## 1. Overview

CleanSwitch provides an automated, reliable method for cleaning VLANs, trunk ports, and configuration artifacts across dozens of switches without manual SSH interaction.

The script is:
- fully automated
- self-contained (no external files)
- safe (dummy data only in repo)
- auditable through generated logs

---

## 2. Key Features

### 2.1 Connectivity
- Automated SSH login using Posh-SSH
- Automatic detection of privileged/enable mode

### 2.2 VLAN & Port Cleanup
- Removes specific VLANs (configurable in script)
- Cleans trunk ports (g0/1, g0/2 + fallback)

### 2.3 Logging & Safety
- Running configuration saved automatically
- Per-switch log files generated
- Global summary log created
- Only dummy IPs and credentials stored in GitHub version

---

## 3. Architecture

```
CleanSwitch/
│
├── wipe_switches.ps1         # Main script (logic, IP list, SSH operations)
│
├── outputs/                  # Logs generated per switch
│   └── README.md
│
├── LICENSE                   # MIT License
├── CONTRIBUTING.md           # Contribution guidelines (optional)
└── .gitignore                # Ignores logs, temp files, artifacts
```

---

## 4. Requirements

| Component | Minimum Version |
|----------|-----------------|
| PowerShell | 5.1 or 7+ |
| Module | Posh-SSH 3.0+ |
| OS | Windows / macOS / Linux (PowerShell 7) |

Install the SSH module:

```powershell
Install-Module Posh-SSH -Scope CurrentUser -Force
```

---

## 5. Configuration

### 5.1 Switch IPs
All management IPs are stored directly in the script:

```powershell
$IPs = @(
    "10.10.10.1",
    "10.10.10.2",
    "10.10.10.3"
)
```

### 5.2 Credentials

```powershell
$User = "admin"
$SecurePass = ConvertTo-SecureString "password" -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)
```

> Note: Only dummy data should be committed to the public repository.

---

## 6. Running the Tool

Execute CleanSwitch:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\wipe_switches.ps1
```

Logs will be stored in:

```
outputs/
```

---

## 7. Example Log Output

```
[12:00:00] Connecting to 10.10.10.1...
[12:00:01] Entered privileged mode
[12:00:03] VLAN 1603 removed
[12:00:04] Trunk ports cleaned
[12:00:06] Configuration saved
[OK] Completed: 10.10.10.1
```

---

## 8. Roadmap

- Dry-run mode
- Parallel execution support
- Automatic platform detection
- Multi-vendor compatibility
- Optional Web UI for execution status

---

## 9. License and Contributions

### License
This project is distributed under the MIT License.

### Contributions
Pull requests, improvements and suggestions are welcome.

⭐ If you find CleanSwitch useful, consider giving it a star.
