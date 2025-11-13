# ⚡ CleanSwitch — Switch Configuration Update Automation

PowerShell-based automation for bulk VLAN cleanup and switch configuration updates over SSH.

![status](https://img.shields.io/badge/status-active-brightgreen)
![tech](https://img.shields.io/badge/powershell-automation-blue)
![license](https://img.shields.io/badge/license-MIT-green)

---

## 📚 Table of Contents
- [Overview](#-overview)
- [Features](#-features)
- [How It Works](#-how-it-works)
- [Repository Structure](#-repository-structure)
- [Requirements](#-requirements)
- [Configuration](#-configuration)
- [Usage](#-usage)
- [Output & Logging](#output--logging)
- [Security Notes](#-security-notes)
- [Roadmap / Ideas](#-roadmap--ideas)
- [License](#-license)

---

## 🔎 Overview

**CleanSwitch** is a PowerShell-based automation script designed for bulk VLAN cleanup and switch configuration updates across multiple network devices via SSH.

Use this script when you need to:
- Remove a VLAN from many switches at once  
- Clean trunk interfaces where the VLAN is allowed  
- Disable DHCP snooping for a specific VLAN  
- Perform pre/post-change validation  
- Generate per-switch logs for documentation or troubleshooting  

> This public example uses **VLAN 2999**.  
> You can change it to any VLAN ID in your environment.

---

## ✨ Features

- Bulk execution of configuration changes across multiple switches  
- VLAN removal from:
  - VLAN database  
  - Access ports (optional)  
  - Trunk interfaces  
- DHCP snooping disable for target VLAN  
- Pre-check and post-check validation  
- SSH-based execution using Posh-SSH module  
- Per-switch log files stored automatically  
- Clean, safe template — **no real IPs or credentials included**  

---

## ⚙️ How It Works

For each switch in the list, the script:

1. Connects via SSH using **Posh-SSH**  
2. Enters privileged EXEC (`enable`) mode if necessary  
3. Runs **pre-check commands**:
   - `show vlan`
   - `show interfaces trunk`
   - `show ip dhcp snooping`
4. Removes VLAN 2999 (or your VLAN) from:
   - VLAN table  
   - trunk port `allowed vlan` lists  
5. Disables DHCP snooping on that VLAN  
6. Runs **post-check commands** for verification  
7. Saves all output to `outputs/DEVICE-IP.txt`  

---

## 📁 Repository Structure

```text
CleanSwitch-Switch-Configuration-Update-Automation/
│
├── scripts/
│   └── wipe_switches.ps1               # Main automation script
│
├── config/
│   └── switch_list.example.txt         # Example switch list (template only)
│
├── outputs/                            # Auto-generated logs (ignored by Git)
│
├── .gitignore
├── LICENSE
└── README.md
