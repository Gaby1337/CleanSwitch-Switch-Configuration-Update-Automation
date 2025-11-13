<h1 align="center">CleanSwitch ⚡</h1>
<p align="center"><b>Production‑ready PowerShell automation for bulk VLAN cleanup on Layer 2 switches over SSH</b></p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Tested%20On-PSVersion%205.1.20348.4163-success?style=for-the-badge">
  <img src="https://img.shields.io/badge/Switch%20Type-Layer%202-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Transport-SSH%20(via%20Posh--SSH)-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/Data-No%20real%20IPs%20or%20passwords-purple?style=for-the-badge">
</p>

---

## 📚 Table of Contents

- [Overview](#-overview)
- [Key Capabilities](#-key-capabilities)
- [Architecture & Flow](#-architecture--flow)
- [Requirements](#-requirements)
- [Quick Start](#-quick-start)
- [Configuration Details](#-configuration-details)
  - [Credentials](#1-credentials)
  - [Target Switch IPs](#2-target-switch-ips)
  - [VLAN & Interfaces](#3-vlan--interfaces)
- [Execution Flow](#-execution-flow)
- [Logging & Output](#-logging--output)
- [Best Practices \& Safety](#-best-practices--safety)
- [Limitations](#-limitations)
- [Roadmap](#-roadmap)
- [FAQ](#-faq)
- [License](#-license)
- [Contributions](#-contributions)

---

## 🚀 Overview

**CleanSwitch** is a single‑file PowerShell automation tool that performs **orchestrated VLAN cleanup** across multiple **Layer 2 switches** via SSH.

The goal is simple:

> **One script → Many switches → Same, repeatable VLAN cleanup procedure.**

It has been **tested and validated** on the following PowerShell runtime:

```powershell
PSVersionTable

Name                           Value
----                           -----
PSVersion                      5.1.20348.4163
```

All examples in this repository are **sanitized** and contain **no real management IPs or credentials**.  
In a real environment, you keep your private version of the script with real data **outside this public repo**.

---

## 💡 Key Capabilities

| Area                 | Details                                                                 |
|----------------------|-------------------------------------------------------------------------|
| Target               | Layer 2 switches (IOS‑style CLI)                                       |
| Transport            | SSH using the `Posh-SSH` module + ShellStream                          |
| Scope                | Bulk VLAN removal & related cleanup on multiple switches               |
| Pre/Post Validation  | Runs read‑only `show` commands before and after config changes         |
| Interface Handling   | Supports both short (`g0/1`) and long (`GigabitEthernet0/1`) syntax    |
| Automation Style     | Fully self‑contained PowerShell script (no CSV / JSON needed)          |
| Logging              | Per‑device output logs + global execution log                          |
| Safety               | Clear, predictable sequence of operations with validation at each step |

---

## 🧱 Architecture & Flow

Conceptual flow for each switch:

```text
+----------------------------+
|   Start: IP from $IPs      |
+-------------+--------------+
              |
              v
    New-SSHSession (Posh-SSH)
              |
              v
     New-SSHShellStream
              |
              v
   Ensure-PrivExec (enable?)
              |
              v
   [Pre-checks: show VLAN,   ]
   [interfaces, DHCP snooping]
              |
              v
  [Config mode -> remove VLAN]
  [cleanup trunk ports, DHCP ]
              |
              v
       write memory
              |
              v
   [Post-checks: same shows]
              |
              v
   Save output to ./outputs/
              |
              v
     Log OK / ERROR in .log
```

Everything above lives in a single script: **`wipe_switches.ps1`**.

---

## 🔧 Requirements

| Component      | Details                                              |
|----------------|------------------------------------------------------|
| PowerShell     | **5.1+** (tested on `5.1.20348.4163`)                |
| Module         | [`Posh-SSH`](https://www.powershellgallery.com/)     |
| Access         | SSH enabled on all target Layer 2 switches           |
| Permissions    | User must have rights to enter `enable` and write config |
| OS             | Windows Server / Windows 10/11 with PowerShell 5.1   |

The script will automatically install `Posh-SSH` for the current user if missing.

---

## ⚡ Quick Start

1. **Clone or download** this repository.
2. Open **PowerShell 5.1+**.
3. Navigate to the folder:

   ```powershell
   cd C:\Path\To\CleanSwitch
   ```

4. Edit `wipe_switches.ps1` and:
   - set your **credentials**
   - set your **switch management IPs**
   - optionally change the **VLAN ID**

5. Run:

   ```powershell
   .\wipe_switches.ps1
   ```

6. Review logs in:
   - `.\outputs\` (per‑device)
   - `.\run_yyyyMMdd_HHmmss.log` (master log)

---

## ⚙ Configuration Details

### 1️⃣ Credentials

> ⚠ **Never** commit real usernames or passwords to a public repo.

In the public version the block is conceptual:

```powershell
# Creds (example – use your own secure handling)
$User = '<switch-username>'
$SecurePass = ConvertTo-SecureString '<switch-password>' -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)

$PlainPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePass)
)
```

For a more secure private variant (not in GitHub), you could use environment variables:

```powershell
$User = $env:SW_USER
$SecurePass = ConvertTo-SecureString $env:SW_PASS -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)
```

---

### 2️⃣ Target Switch IPs

By design, CleanSwitch keeps the IP list **inside the script** for simplicity:

```powershell
# TOATE IP-URILE (management IPs for your Layer 2 switches)
$IPs = @(
    "127.0.0.1",
    "127.0.0.2"
)
```

- These `127.x.x.x` values are **placeholders** in the public repo.
- In your real copy, replace them with your own management IPs (e.g. `172.16.x.x`).
- You can add/remove as many IPs as needed.

---

### 3️⃣ VLAN & Interfaces

The script focuses on **one VLAN** at a time (example: VLAN 12) and assumes that:

- VLAN needs to be removed globally.
- It must be removed from trunk interfaces:
  - `g0/1`
  - `g0/2`
- Some devices may require the long form:
  - `GigabitEthernet0/1`
  - `GigabitEthernet0/2`

Search for `12` in the script and replace with your target VLAN ID.

> 🔁 Always test with a lab switch or a non‑critical device before running against dozens of switches.

---

## 🔄 Execution Flow

For each IP in `$IPs`:

1. **SSH session created**

   ```powershell
   $sess = New-SSHSession -ComputerName $Ip -Credential $Cred -AcceptKey -ConnectionTimeout 12
   ```

2. **ShellStream attached**

   ```powershell
   $stream = New-SSHShellStream -SessionId $sess.SessionId
   ```

3. **Privilege ensured**  
   Sends `terminal length 0`, checks for `#`, and if needed:

   ```powershell
   enable
   Password: <PlainPass>
   ```

4. **Pre‑checks executed**

   - `show vlan id 12`
   - `show running-config interface g0/1`
   - `show ip dhcp snooping`

5. **Configuration applied**

   - `no vlan 12`
   - `interface g0/1` → `switchport trunk allowed vlan remove 12`
   - `interface g0/2` → `switchport trunk allowed vlan remove 12`
   - `no ip dhcp snooping vlan 12`
   - `write memory`

6. **Fallback interfaces**  
   If CLI returns invalid/ambiguous input, retry with:

   - `GigabitEthernet0/1`
   - `GigabitEthernet0/2`

7. **Post‑checks executed**  
   Same set of `show` commands to confirm result.

8. **Session closed & result logged**

---

## 📂 Logging & Output

On each run the script generates:

### 📁 Per‑device logs

Location: `.\outputs\`  
Pattern: `<IP>_<timestamp>.txt`

Example:

```text
172.16.10.11_20251113_182200.txt
172.16.10.12_20251113_182204.txt
```

Content typically includes:

- Device prompt & banners
- Pre‑check `show` outputs
- All configuration commands executed
- Fallback attempts (if any)
- Post‑check `show` outputs

### 🧾 Master run log

File name pattern:

```text
run_yyyyMMdd_HHmmss.log
```

Example content:

```text
[18:22:01] 172.16.10.11 OK -> .\outputs\172.16.10.11_20251113_182200.txt
[18:22:03] 172.16.10.12 ERROR: Connection timed out
[18:22:05] 172.16.10.14 OK -> .\outputs\172.16.10.14_20251113_182205.txt
```

This log gives you a quick **per‑device success/failure summary**.

---

## 🛡 Best Practices & Safety

- 🔬 **Start small**  
  Run against **one test switch** before targeting production.

- 🧪 **Pilot group**  
  Then run on a small subset of switches to confirm behavior.

- 📝 **Backup first**  
  Use `copy running-config tftp:` or your preferred backup solution.

- 🔐 **Keep secrets private**  
  Store real IPs & credentials in a private fork or local only.

- 📊 **Review logs**  
  Always read a few per‑device logs after each run to validate changes.

---

## ⚠ Limitations

- Optimized for **Layer 2 / IOS‑like switches**.
- Designed for **a single VLAN per execution** (one VLAN ID hard‑coded per script run).
- Expects standard CLI structure; very customized CLIs may require adjustments.
- No built‑in “dry-run” mode yet (planned in roadmap).

---

## 🗺 Roadmap

Potential future enhancements:

- [ ] Multi‑VLAN support in a single run
- [ ] CSV/JSON input of IPs and VLANs
- [ ] Parallel execution (run multiple switches in parallel jobs)
- [ ] Dry‑run / preview mode (only pre‑checks, no config)
- [ ] Enhanced error categorization in the master log
- [ ] Optional transcript export in PowerShell

---

## ❓ FAQ

**Q: Is this safe for production?**  
A: The logic is deterministic and has pre/post checks, but **safety depends on how you use it**. Always test on lab or non‑critical switches first, then roll out gradually.

**Q: Why keep IPs inside the script, not in CSV?**  
A: Simplicity. For some environments, a single self‑contained script is easier to store, review and execute. You can always extend it later to CSV if needed.

**Q: Does it support Layer 3 features?**  
A: The focus is **Layer 2 VLAN cleanup**. Layer 3 behavior is not the scope of this script.

**Q: Can I change the VLAN ID?**  
A: Yes. Search for the current VLAN ID (e.g. `12`) in the script and replace it with your target VLAN. Then test carefully.

---

## 📜 License

```text
MIT License
```

You are free to use, modify and distribute this tool under the terms of the MIT license.

---

## 🤝 Contributions

Contributions, ideas and refactors are welcome:

- Open an **Issue** for bugs / questions / feature requests.
- Submit a **Pull Request** for code or documentation improvements.

If you use CleanSwitch in your environment and find it useful, a ⭐ on GitHub is always appreciated.
