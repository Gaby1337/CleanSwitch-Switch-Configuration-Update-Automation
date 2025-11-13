<h1 align="center">CleanSwitch ⚡</h1>
<p align="center">Professional PowerShell-based automation for bulk VLAN cleanup on Layer 2 network switches.</p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Tested%20On-PSVersion%205.1.20348.4163-success?style=for-the-badge">
  <img src="https://img.shields.io/badge/SSH-Automation-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/Module-Posh--SSH-lightgrey?style=for-the-badge">
  <img src="https://img.shields.io/badge/Switch%20Type-Layer%202-orange?style=for-the-badge">
</p>

---

## 🚀 Overview

**CleanSwitch** is a fully automated PowerShell script designed for **Layer 2 switch environments** that require centralized, repeatable VLAN cleanup through SSH.

The script was **tested and validated** using:

```
PSVersionTable

Name                           Value
----                           -----
PSVersion                      5.1.20348.4163
```

It performs safe, structured actions across multiple switches:
- SSH authentication
- Privilege elevation (`enable`)
- Pre-cleanup validation
- VLAN removal and interface cleanup
- DHCP snooping removal
- Post-cleanup validation
- Per-device audit logging

---

## 🔧 Core Features

| Feature | Description |
|--------|-------------|
| **Layer 2 Compatibility** | Designed and tested specifically for Layer 2 switches. |
| **SSH Automation** | Uses Posh-SSH + ShellStream for complete CLI control. |
| **Privilege Detection** | Auto-detects if `enable` is required and supplies credentials. |
| **Fallback Interface Support** | Supports both short `g0/1` and full `GigabitEthernet0/1` formats. |
| **Detailed Logging** | Per-device output logs + master execution log. |
| **Fully Self-Contained** | No external CSV, JSON or config files required. |

---

## 📁 Repository Structure

```
.
├── wipe_switches.ps1    # Main script
├── README.md            # Documentation
└── outputs/             # Automatically generated logs
```

---

## 🔒 Credentials Notice

This repository contains **no real IPs, usernames or passwords**.  
The script inside the repo includes placeholders only.

You must customize your private local copy with real credentials **outside GitHub**.

---

## ⚙️ Configuration

### 1️⃣ Set your switch credentials

```powershell
$User = '<switch-username>'
$SecurePass = ConvertTo-SecureString '<switch-password>' -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)
$PlainPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePass)
)
```

### 2️⃣ Add Layer 2 switch management IPs

The script uses direct inline configuration:

```powershell
# TOATE IP-URILE
$IPs = @(
    "127.0.0.1",
    "127.0.0.2"
)
```

You may add as many as needed.

### 3️⃣ VLAN and interfaces

The script currently removes **VLAN 12** and cleans:

- `g0/1`
- `g0/2`
- fallback: `GigabitEthernet0/1`, `GigabitEthernet0/2`

To change VLAN ID, replace all occurrences of `12`.

---

## ▶️ Running the Script

```powershell
cd C:\Path\To\CleanSwitch
.\wipe_switches.ps1
```

The script will:

- Connect to each IP in `$IPs`
- Remove the specified VLAN
- Clean trunk ports
- Remove DHCP snooping for that VLAN
- Save logs in `outputs/`

---

## 📄 Logging System

### Per-device logs:

```
outputs/<IP>_<timestamp>.txt
```

Each includes:
- Pre-check state
- Executed configuration
- Fallback interface actions (if needed)
- Post-check validation

### Global master log:

```
run_<timestamp>.log
```

Example:

```
[18:22:01] 172.16.10.11 OK -> .\outputsz.16.10.11_20251113_182200.txt
[18:22:03] 172.16.10.12 ERROR: Connection timed out
```

---

## 🛡️ Safety Recommendations

- Test on **one switch first** before bulk execution
- Keep production version **private**
- Validate logs after each run
- Ensure SSH access + correct AAA configuration
- Consider taking backups (`copy run tftp:`)

---

## 🔮 Planned Enhancements

- Multi-VLAN cleanup
- Multi-threaded execution
- CSV-based IP import
- Dry-run mode (no configuration applied)

---

## 📝 License

```
MIT License
```

---

## 🤝 Contributions

Pull requests & feature ideas are welcome.

---

## 🧩 Notes

This repository intentionally includes **only generic placeholder data**.  
Never commit real switch IPs, usernames, or passwords.
