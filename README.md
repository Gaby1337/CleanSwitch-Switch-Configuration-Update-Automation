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
- [Output & Logging](#-output--logging)
- [Security Notes](#-security-notes)
- [Roadmap / Ideas](#-roadmap--ideas)
- [License](#-license)

---

## 🔎 Overview

**CleanSwitch** is a PowerShell-based automation script used to clean up a specific VLAN and its related configuration on multiple switches over SSH.

It is designed as a **template / example project** for network engineers who want to:
- remove a VLAN from many switches in bulk
- update trunk interfaces
- disable DHCP snooping for that VLAN
- keep a per-device log of all CLI output

> **Note:** In this public example the VLAN ID is `2999`.  
> In your real environment you can change it to whatever VLAN you need.

---

## ✨ Features

- Bulk configuration changes on multiple switches over SSH
- VLAN removal (from configuration and trunk interfaces)
- DHCP snooping disable for the selected VLAN
- Optional pre-check and post-check commands
- Per-switch CLI logs saved to files
- Simple structure that can be adapted to any environment
- No real management IPs or credentials stored in the repository

---

## ⚙️ How It Works

For each switch in the list, the script:

1. Connects over SSH using the **Posh-SSH** module  
2. (Optionally) enters privileged EXEC / enable mode  
3. Runs **pre-check** commands (show VLAN, interfaces, DHCP snooping)  
4. Removes the target VLAN from:
   - VLAN database
   - access ports (if needed)
   - trunk interfaces
5. Disables DHCP snooping for that VLAN  
6. Runs **post-check** commands to verify the change  
7. Saves all CLI output to a per-device text file in the `outputs/` folder  

---

## 📁 Repository Structure

Planned / example structure for the project:

```text
CleanSwitch-Switch-Configuration-Update-Automation/
  scripts/
    wipe_switches.ps1        # Main PowerShell automation script
  config/
    switch_list.example.txt  # Example switch list (no real IPs)
  outputs/
    ...                      # Generated at runtime, contains logs
  README.md
  LICENSE
  .gitignore                 # Keeps logs and real configs out of Git
