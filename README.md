

<h1 align="center">CleanSwitch ⚡🧼</h1>
<p align="center">
  Automated VLAN cleanup across dozens of switches using PowerShell + SSH.<br>
  A clean, fast and safe template — with no real IPs or credentials.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1+-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/SSH-automation-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/VLAN-cleanup-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Safe-public_template-purple?style=for-the-badge" />
</p>

---

## ✨ Concept

You have 50+ switches.  
One cursed VLAN that must disappear everywhere.  
Clicking through each device manually? Not today.

**CleanSwitch** is a compact PowerShell automation that:

- opens SSH sessions to a list of switches  
- checks if the target VLAN exists  
- removes it from config + trunk ports  
- disables DHCP snooping  
- writes memory  
- logs *everything* into per-device files  

All IPs, VLANs and credentials here are **dummy values** — this is a clean template, not real production data.

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
    outputs/<device>_timestamp.txt
    run_YYYYMMDD_HHMMSS.log


🚀 Quickstart

<p align="center">
  <img src="assets/demo-session.png" width="720"/>
</p>

