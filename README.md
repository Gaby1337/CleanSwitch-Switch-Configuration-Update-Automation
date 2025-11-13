# ⚡ CleanSwitch — Switch Configuration Update Automation

PowerShell-based automation for bulk VLAN cleanup and switch configuration updates over SSH.

![status](https://img.shields.io/badge/status-active-brightgreen)
![tech](https://img.shields.io/badge/powershell-automation-blue)
![license](https://img.shields.io/badge/license-MIT-green)

---

## Overview

**CleanSwitch** is a PowerShell script used to clean up a specific VLAN and its
related configuration on multiple switches over SSH.

For each switch in the list, the script:

- connects over SSH using Posh-SSH  
- enters privileged EXEC mode (if needed)  
- shows the current state (VLAN, interface config, DHCP snooping)  
- removes a specific VLAN from the switch and from trunk interfaces  
- disables DHCP snooping for that VLAN  
- saves the configuration and runs post-check commands  
- writes all CLI output to per-device text files in `outputs/`.

> **Note:** In this public example the VLAN ID is `2999`.  
> In your real environment you can adjust it to whatever VLAN you need.

---

## Requirements

- Windows PowerShell 5.1 or later  
- [Posh-SSH](https://www.powershellgallery.com/packages/Posh-SSH) module

Install Posh-SSH:

```powershell
Install-Module Posh-SSH -Scope CurrentUser -Force


scripts/
  wipe_switches.ps1       # Main automation script

config/
  switch_list.example.txt # Example switch list (optional)

outputs/
  (created at runtime, contains logs and per-switch output)

README.md
LICENSE
.gitignore


Usage (concept)

Edit scripts/wipe_switches.ps1 locally and replace:

the placeholder password (CHANGE_ME_PASSWORD)

the example management IP addresses in $IPs

(optionally) the VLAN ID (2999).

Run the script from PowerShell:

cd scripts
.\wipe_switches.ps1


The script will:

connect to each switch in $IPs

apply the configuration changes

store per-switch output in the outputs directory

log the run in run_YYYYMMDD_HHMMSS.log.

Security

No real credentials or IP addresses are stored in this public repository.

Do not commit your real management IPs or passwords.
