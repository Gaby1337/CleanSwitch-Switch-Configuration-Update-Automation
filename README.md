<p align="center">
  <img src="assets/cleanswitch-banner.png" alt="CleanSwitch Banner" width="720">
</p>

<h1 align="center">CleanSwitch 🧼⚡</h1>
<p align="center">
  VLAN exorcism for tired network engineers.<br/>
  Bulk cleanup of a single VLAN across dozens of switches, powered by PowerShell + SSH.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1+-blue" />
  <img src="https://img.shields.io/badge/SSH-automation-in_progress" />
  <img src="https://img.shields.io/badge/Scope-VLAN%20cleanup-orange" />
</p>

---

## 🧠 Concept

You have 50+ switches.  
One cursed VLAN that must disappear from everywhere.  
You don’t want to click through each device like it’s 2004.

**CleanSwitch** is a tiny, brutal PowerShell script that:

- opens SSH sessions to a list of switches
- checks if the target VLAN exists
- removes it from config + trunks
- disables DHCP snooping for that VLAN
- saves *everything* it does into log files

All IPs, credentials and VLAN IDs in this public repo are **dummy values** – it’s a template, not a leak.

---

## 🗺 Architecture (ASCII style)

```text
+-------------------------+
|   IP list (lab / prod)  |
+-----------+-------------+
            |
            v
  +---------------------+      SSH       +----------------------+
  |  wipe_switches.ps1  |  ---------->   |  Switch stack / LAB  |
  |  (PowerShell 5.1)   |                |  IOS / NX-OS / etc   |
  +---------------------+                +----------------------+
            |
            v
   outputs\*.txt   +   run_YYYYMMDD_HHMMSS.log

   git clone https://github.com/YOUR-USER/CleanSwitch-Automated-VLAN-Purge.git
cd CleanSwitch-Automated-VLAN-Purge


Open wipe_switches.ps1

Change:

CHANGE_ME_USER → your SSH username

CHANGE_ME_PASSWORD → your SSH password (or handle via secure vault)

VLAN 2999 → the VLAN you actually want to remove

replace the 192.0.2.x example IPs with your own management IPs

Make sure you have PowerShell 5.1+ and Posh-SSH:

Install-Module Posh-SSH -Scope CurrentUser -Force
.\wipe_switches.ps1

