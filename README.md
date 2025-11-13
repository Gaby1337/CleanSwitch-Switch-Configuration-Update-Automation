<h1 align="center">CleanSwitch ⚡</h1>
<p align="center">A fast, safe and fully automated VLAN cleanup tool for multi-switch environments.</p>

<p align="center">
  <img src="https://img.shields.io/badge/Automation-PowerShell 5.1+-blue?style=flat-square">
  <img src="https://img.shields.io/badge/Protocol-SSH-green?style=flat-square">
  <img src="https://img.shields.io/badge/Purpose-VLAN Cleanup-orange?style=flat-square">
  <img src="https://img.shields.io/badge/Safe-Dummy Data-purple?style=flat-square">
</p>

---

## 🚀 Overview

**CleanSwitch** is a compact PowerShell automation script designed to remove a specific VLAN  
from dozens of switches in bulk, through SSH, with zero manual interaction.

It handles everything automatically:

- Privileged mode detection  
- Pre-check and post-check validation  
- VLAN removal  
- Trunk port cleanup (g0/1 & g0/2 + long-form fallback)  
- DHCP snooping cleanup  
- Config save (`write memory`)  
- Per-device logs and a master run log  

This repository contains **no real IPs or credentials** — it is a safe public template.

---

## 🧠 Architecture Overview

```text
+-----------------------+
|  List of Switch IPs   |
+-----------+-----------+
            |
            v
  +---------------------+      SSH       +------------------------+
  |  wipe_switches.ps1  |  ---------->   |   Switch (IOS/NX-OS)   |
  |  PowerShell 5.1     |                |   Lab or Production    |
  +---------------------+                +------------------------+
            |
            v
   outputs/<ip>_timestamp.txt
   run_YYYYMMDD_HHMMSS.log
