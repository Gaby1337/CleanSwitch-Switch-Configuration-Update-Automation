<h1 align="center">CleanSwitch ⚡</h1>
<p align="center">
  Bulk VLAN cleanup & switch configuration automation over SSH using PowerShell.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-PowerShell%205.1%2B-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Protocol-SSH-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/Module-Posh--SSH-lightgrey?style=for-the-badge">
  <img src="https://img.shields.io/badge/Scope-L2/L3%20Switches-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Data-No%20real%20IPs%20or%20passwords-purple?style=for-the-badge">
</p>

## 🚀 Overview

CleanSwitch is a standalone PowerShell automation script that performs bulk VLAN cleanup across multiple switches using SSH. It is designed for network engineers who need a fast, safe and repeatable method to remove a VLAN and associated configuration from many devices at once.

The script performs:

- SSH connection to each switch
- Auto–privilege elevation (enable)
- Pre-check validation
- VLAN removal
- Trunk port cleanup
- DHCP snooping cleanup
- Configuration save
- Post-check validation
- Per-device logging

## 🔧 Features

| Functionality | Description |
|--------------|-------------|
| SSH automation | Uses Posh-SSH and ShellStream for full control over CLI. |
| Auto privilege elevation | Detects when enable is required and handles password prompts. |
| IOS-style CLI support | Works with both short (g0/1) and long (GigabitEthernet0/1) interface formats. |
| Full logging | Saves all switch output per device and creates a global run log. |
| Safe & repeatable | Pre- and post-checks ensure consistent execution. |

## 📁 Repository contents

```
.
├── wipe_switches.ps1    # Main script
├── README.md            # Documentation
└── outputs/             # Auto-created log folder
```

## 🔒 Credentials & security notice

This repository contains no real IP addresses, usernames or passwords.

## ⚙️ How to configure the script

### Add your switch login

```
$User = '<switch-username>'
$SecurePass = ConvertTo-SecureString '<switch-password>' -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)
```

### Add your management IPs

```
# TOATE IP-URILE
$IPs = @(
    "127.0.0.1",
    "127.0.0.2"
)
```

Replace these placeholders with real management IPs.

### VLAN ID & interfaces

The current script removes VLAN 12. Replace 12 if needed.

## ▶️ How to run

```
cd C:\Path\To\CleanSwitch
.\wipe_switches.ps1
```

## 📄 Logs & output

Log files are automatically saved in the outputs/ folder.

## 🛡️ Safety recommendations

- Test on 1–2 switches first
- Keep production version private
- Backup running config before mass cleanup

## 🔮 Future improvements

- Multi-VLAN support
- Parallel SSH sessions
- Importing IPs from CSV

## 📝 License

MIT License

## 🤝 Contributions

Open to bug reports, feature requests and pull requests.

