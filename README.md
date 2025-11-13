# ⚡ CleanSwitch — Switch Configuration Update Automation

PowerShell-based automation for bulk VLAN cleanup and switch configuration updates over SSH.

![status](https://img.shields.io/badge/status-active-brightgreen)
![tech](https://img.shields.io/badge/powershell-automation-blue)
![license](https://img.shields.io/badge/license-MIT-green)

---

## 📚 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [How It Works](#how-it-works)
- [Repository Structure](#repository-structure)
- [Requirements](#requirements)
- [Configuration](#configuration)
- [Usage](#usage)
- [Output & Logging](#output--logging)
- [Security Notes](#security-notes)
- [Roadmap / Ideas](#roadmap--ideas)
- [License](#license)

---

## 🔎 Overview
**CleanSwitch** is a PowerShell-based automation script designed for bulk VLAN cleanup and switch configuration updates across multiple network devices via SSH.

It is ideal for situations where you need to:
- Remove a VLAN on many switches simultaneously
- Clean trunk interfaces
- Disable DHCP snooping for a specific VLAN
- Perform pre-check and post-check validation
- Log all device outputs for auditing or troubleshooting

> This public version uses **VLAN 2999** as example.  
> In production you can set any VLAN ID you need.

---

## ✨ Features
- Bulk configuration execution on multiple switches  
- VLAN removal from database + trunk ports  
- DHCP snooping disable for selected VLAN  
- Optional pre-check and post-check validation  
- Per-device CLI output logs  
- Safe template: **no real IPs or credentials included**  
- Clean structure that can be reused for any network automation task  

---

## ⚙️ How It Works

For each switch in the device list, the script performs these actions:

1. Connects via SSH using the **Posh-SSH** module  
2. Enters privileged EXEC mode if required  
3. Executes **pre-check commands**:
   - show vlan  
   - show interfaces trunk  
   - show ip dhcp snooping  
4. Removes the selected VLAN from:
   - VLAN database  
   - Access ports (optional)
   - Trunk ports  
5. Disables DHCP snooping for that VLAN  
6. Executes **post-check commands**  
7. Saves all CLI output in the `outputs/` folder  

---

## 📁 Repository Structure

