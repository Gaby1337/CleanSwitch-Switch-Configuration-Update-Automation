<h1 align="center">CleanSwitch ⚡🧼</h1>
<p align="center">
  Automated VLAN cleanup across dozens of switches using PowerShell + SSH.<br>
  Clean, safe, and production-friendly template — no real IPs or credentials.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1+-blue?style=flat-square" />
  <img src="https://img.shields.io/badge/SSH-automation-green?style=flat-square" />
  <img src="https://img.shields.io/badge/VLAN-cleanup-orange?style=flat-square" />
  <img src="https://img.shields.io/badge/Public-template-purple?style=flat-square" />
</p>

---

## ✨ Concept

You have 50+ switches.  
One cursed VLAN that must disappear from everywhere.  
Clicking through each device manually? Not today.

**CleanSwitch** is a compact PowerShell automation script that:

- opens SSH sessions to a list of switches  
- checks if a specific VLAN exists  
- removes it from configuration and trunk ports  
- disables DHCP snooping for that VLAN  
- writes memory  
- logs *everything* into per-device files  

All IPs, VLANs and credentials in this repo are dummy values — clean, safe, non-production.

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
