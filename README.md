<h1 align="center">
  <b>CleanSwitch ⚡</b>
</h1>

<p align="center">
  Orchestrated VLAN cleanup on Layer 2 switches via PowerShell + SSH (Posh-SSH)
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-3178C6?style=for-the-badge&logo=powershell&logoColor=white">
  <img src="https://img.shields.io/badge/Tested%20On-PSVersion%205.1.20348.4163-success?style=for-the-badge">
  <img src="https://img.shields.io/badge/Switch%20Type-Layer%202-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Transport-SSH%20(via%20Posh--SSH)-0FA958?style=for-the-badge">
  <img src="https://img.shields.io/badge/Security-No%20Real%20IPs%20or%20Passwords-purple?style=for-the-badge">
  <img src="https://img.shields.io/badge/Verified-Automation%20Framework-brightgreen?style=for-the-badge">
</p>

---

## 📚 Table of Contents

- [Overview](#-overview)
- [What the script actually does](#-what-the-script-actually-does)
- [Architecture & Flow Diagram](#-architecture--flow-diagram)
- [Requirements](#-requirements)
- [Script Structure](#-script-structure)
- [Configuration](#-configuration)
  - [Credentials](#1-credentials)
  - [Target Switch IPs](#2-target-switch-ips)
  - [VLAN and interfaces](#3-vlan-and-interfaces)
- [How to Run](#-how-to-run)
- [Logging & Output](#-logging--output)
- [Best Practices & Safety](#-best-practices--safety)
- [Limitations](#-limitations)
- [Roadmap](#-roadmap)
- [License](#-license)
- [Contributions](#-contributions)

---

## 🚀 Overview

`wipe_switches.ps1` is a **single-file PowerShell script** that performs a **bulk, scripted cleanup of VLAN 12** on multiple **Layer 2 switches** using SSH (via the `Posh-SSH` module).

It is designed to:

- Apply the **same procedure** to every switch in a list
- Use **IOS-style CLI** over SSH
- Remove **VLAN 12** and related configuration from:
  - VLAN database
  - Trunk ports `g0/1` and `g0/2`
  - DHCP snooping configuration
- Save the running configuration
- Generate logs per device + a master run log

The script has been **tested** on:

```powershell
PSVersionTable

Name                           Value
----                           -----
PSVersion                      5.1.20348.4163
```



---

## 🔍 What the script actually does

For each IP in `$IPs`, the script:

1. **Creates an SSH session** using `New-SSHSession` (Posh-SSH)
2. Opens an **interactive shell** using `New-SSHShellStream`
3. **Ensures privileged EXEC mode** with `Ensure-PrivExec`:
   - Sends `terminal length 0`
   - If the prompt is not `#`, sends `enable`
   - If asked for password, sends the same password used for SSH (`$PlainPass`)
4. Runs **pre-check commands** (read-only):

   ```text
   show vlan id 12
   show running-config interface g0/1
   show ip dhcp snooping
   ```

5. Applies the **configuration for VLAN 12**:

   - Remove VLAN 12 from VLAN database:
     ```text
     configure terminal
     no vlan 12
     end
     ```
   - Cleanup VLAN 12 from trunk interfaces:
     ```text
     configure terminal
     interface g0/1
     switchport trunk allowed vlan remove 12
     interface g0/2
     switchport trunk allowed vlan remove 12
     end
     ```
   - Remove VLAN 12 from DHCP snooping:
     ```text
     configure terminal
     no ip dhcp snooping vlan 12
     end
     ```

   - Save configuration:
     ```text
     write memory
     ```

6. Runs **post-check commands** (same as pre-checks) to verify the state:

   ```text
   show vlan id 12
   show running-config interface g0/1
   show ip dhcp snooping
   ```

7. If the switch **does not accept short interface names** (`g0/1`, `g0/2`) and responds with:

   - `Invalid input detected`
   - `% Ambiguous`
   - `Incomplete command`

   then the script automatically retries with **long interface names**:

   ```text
   configure terminal
   interface GigabitEthernet0/1
   switchport trunk allowed vlan remove 12
   interface GigabitEthernet0/2
   switchport trunk allowed vlan remove 12
   end
   show running-config interface GigabitEthernet0/1
   ```

8. Writes **all collected output** to a per-device file and logs success or error in a master log.

---

## 🧱 Architecture & Flow Diagram

The logic in your script matches the following flow:

```text
+---------------------------------------------------------+
|                    wipe_switches.ps1                    |
+---------------------------+-----------------------------+
                            |
                            v
                 Import / Install Posh-SSH
                            |
                            v
                 Prepare credentials & $IPs
                            |
                            v
                  Ensure .\outputs directory
                            |
                            v
               Create master log file ($Log)
                            |
                            v
                 For each $Ip in $IPs array
+---------------------------------------------------------+
|                         Do-Device                       |
+---------------------------+-----------------------------+
                            |
                            v
           New-SSHSession (AcceptKey, Timeout 12s)
                            |
                            v
              New-SSHShellStream (interactive)
                            |
                            v
                     Ensure-PrivExec
        (terminal length 0, enable, password if needed)
                            |
                            v
                    PRE-CHECK PHASE
    - show vlan id 12
    - show running-config interface g0/1
    - show ip dhcp snooping
                            |
                            v
                 CONFIGURATION PHASE
    - no vlan 12
    - remove vlan 12 from g0/1 & g0/2 trunks
    - no ip dhcp snooping vlan 12
    - write memory
                            |
                            v
                    POST-CHECK PHASE
    - same show commands as pre-check
                            |
                            v
        FALLBACK (if CLI error on g0/1 & g0/2)
    - use GigabitEthernet0/1 and 0/2 instead
                            |
                            v
                    LOG & CLEANUP
    - Write full $out to .\outputs\<IP>_timestamp.txt
    - Log OK/ERROR to $Log
    - Remove-SSHSession
```

This diagram reflects exactly how your current PowerShell code behaves.

---

## 📦 Requirements

| Component  | Details                                                  |
|-----------|----------------------------------------------------------|
| PowerShell | 5.1+ (tested on PSVersion 5.1.20348.4163)               |
| Module    | `Posh-SSH` (installed automatically if not present)      |
| Switches  | IOS-style CLI devices with VLAN + trunk + DHCP snooping  |
| Access    | SSH reachable, valid credentials, `enable` permissions   |
| OS        | Windows 10/11 / Windows Server with PowerShell 5.1       |

---

## 🧬 Script Structure

The core blocks in your script:

- `Install-Module` / `Import-Module Posh-SSH`
- Credentials: `$User`, `$SecurePass`, `$Cred`, `$PlainPass`
- IP list: `$IPs = @("127.0.0.1","127.0.0.2")`
- Output directory & master log: `$OutDir`, `$Log`
- Helper function: `Send-Line`
- Privilege helper: `Ensure-PrivExec`
- Main worker: `Do-Device`
- Loop over IPs: `foreach ($ip in $IPs) { Do-Device $ip }`
---

## ⚙ Configuration

### 1️⃣ Credentials

From your script:

```powershell
# Creds
$User = 'admin'
$SecurePass = ConvertTo-SecureString 'us' -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)
$PlainPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePass)
)
```

---

### 2️⃣ Target Switch IPs

Exactly as in your script:

```powershell
# TOATE IP-URILE
$IPs = @(
    "127.0.0.1",
    "127.0.0.2"
)
```
```powershell
$IPs = @(
    "10.32.55.11",
    "10.32.55.14",
    "10.32.55.21"
)
```

---

### 3️⃣ VLAN and interfaces

The script is **hard-coded for VLAN 12**, and interfaces:

- Short form:
  - `g0/1`
  - `g0/2`
- Long form fallback:
  - `GigabitEthernet0/1`
  - `GigabitEthernet0/2`

If you want to target another VLAN, search for:

```text
vlan 12
no vlan 12
switchport trunk allowed vlan remove 12
no ip dhcp snooping vlan 12
show vlan id 12
```

and replace `12` with your desired VLAN ID **everywhere** in the script.

---

## ▶ How to Run

1. Make sure you have PowerShell 5.1 and internet access (first run installs `Posh-SSH`).
2. Save `wipe_switches.ps1` and this `README.md` in the same folder.
3. Open a PowerShell session:

   ```powershell
   cd C:\Path\To\CleanSwitch
   ```

4. Optionally unblock the script if downloaded from internet:

   ```powershell
   Unblock-File .\wipe_switches.ps1
   ```

5. Execute:

   ```powershell
   .\wipe_switches.ps1
   ```

---

## 📂 Logging & Output

Your script produces:

1. **Per-device output files** in `.\outputs\`:

   Pattern:

   ```text
   <IP>_yyyyMMdd_HHmmss.txt
   ```

   Example with more realistic IPs:

   ```text
   10.32.55.11_20251113_182200.txt
   10.32.55.14_20251113_182204.txt
   10.32.55.21_20251113_182207.txt
   ```

2. **Master run log** in the script folder:

   ```text
   run_20251113_182159.log
   ```

   Example content (matching your `Tee-Object` format):

   ```text
   [18:22:01] 10.32.55.11 OK -> .\outputs\10.32.55.11_20251113_182200.txt
   [18:22:03] 10.32.55.14 ERROR: SSH connection failed
   [18:22:05] 10.32.55.21 OK -> .\outputs\10.32.55.21_20251113_182207.txt
   ```

---

## 🛡 Best Practices & Safety

- Start with **one test switch** in `$IPs` before bulk runs.
- Take a **backup** (e.g. `copy running-config tftp:`) before first production run.
- Review at least a few `.\outputs\*.txt` files after every run.
- Keep your **real `$User`, `$SecurePass` and `$IPs` only in private copies** of the script.

---

## ⚠ Limitations

- Designed for **a single VLAN (12) at a time**.
- Only cleans:
  - VLAN database
  - Trunk ports `g0/1`, `g0/2` (and long forms)
  - DHCP snooping for that VLAN
- Assumes IOS-like CLI; other OS types may require adjustment.
- No dry-run mode (all changes are real once config phase begins).

---

## 🗺 Roadmap (Ideas)

- Multi-VLAN cleanup (list of VLANs instead of a single ID)
- Import `$IPs` from CSV
- Parallel execution (run multiple switches in jobs)
- Dry-run / “check-only” mode
- Optional additional pre/post checks (e.g. `show spanning-tree`)

---

## 📜 License

```text
MIT License
```

---

## 🤝 Contributions

If you use CleanSwitch and improve it:

- Open an **Issue** with ideas or problems
- Submit a **Pull Request** with enhancements

A ⭐ on GitHub is always appreciated if this script saves you time on bulk VLAN cleanup.
