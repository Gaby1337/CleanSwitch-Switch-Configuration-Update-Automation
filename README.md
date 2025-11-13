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

## 🧠 Architecture

```text
+---------------------------+
|   Switch IP list (demo)   |
+-------------+-------------+
              |
              v
  +---------------------+      SSH       +----------------------+
  |  wipe_switches.ps1  |  ---------->   |  Switch stack / LAB  |
  |  (PowerShell 5.1)   |                |  IOS / NX-OS / etc   |
  +---------------------+                +----------------------+
              |
              v
    outputs/<ip>_YYYYMMDD_HHMMSS.txt
    run_YYYYMMDD_HHMMSS.log
```

---

## ## 🚦 Quickstart

### 1️⃣ Install dependencies  
(Open PowerShell as Administrator)

```powershell
Install-Module Posh-SSH -Scope CurrentUser -Force
```
Configure the script

Open wipe_switches.ps1 and update:

SSH username → CHANGE_ME_USER

SSH password → CHANGE_ME_PASSWORD

VLAN ID → replace 2999 with your target VLAN

Replace dummy IP list (192.0.2.x) with your real management IPs

Run CleanSwitch:
.\wipe_switches.ps1

After execution:

Detailed per-device logs will be available in outputs/

A global run log file will be generated with a timestamp

📜 How the Script Works (Step-by-Step)
🔧 1. SSH session

For each switch in the IP list, the script creates:

an SSH session (New-SSHSession)

an interactive shell stream (New-SSHShellStream)

🔧 2. Enter privileged EXEC

The script sends:
terminal length 0
enable   (if required)


