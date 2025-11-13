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
