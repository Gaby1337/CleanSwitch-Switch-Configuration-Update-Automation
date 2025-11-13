<h1 align="center">
  <img src="https://img.icons8.com/fluency/96/console.png" width="80"><br>
  <b>CleanSwitch ⚡</b>
</h1>

<p align="center">
  <i>Enterprise‑grade automation for orchestrated VLAN cleanup on Layer 2 switches via PowerShell + SSH</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-3178C6?style=for-the-badge&logo=powershell&logoColor=white">
  <img src="https://img.shields.io/badge/Tested%20On-PSVersion%205.1.20348.4163-success?style=for-the-badge">
  <img src="https://img.shields.io/badge/Switch%20Type-Layer%202-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Transport-SSH%20(via%20Posh--SSH)-0FA958?style=for-the-badge">
  <img src="https://img.shields.io/badge/Security-No%20Real%20IPs%20or%20Passwords-purple?style=for-the-badge">
</p>

---

<div align="center">
<img src="https://img.icons8.com/external-flatart-icons-outline-flatarticons/128/external-network-administrator-it-flatart-icons-outline-flatarticons.png" width="110"><br>
<h3>“One script. Many switches. Zero manual work.”</h3>
</div>

---

## 📘 What is CleanSwitch?

**CleanSwitch** is a production‑ready PowerShell automation framework that performs **safe, predictable, repeatable VLAN cleanup** across multiple **Layer 2 network switches**.

Designed to eliminate manual CLI work, reduce outages, and enforce consistency, CleanSwitch automates:

- Authentication via SSH  
- Privilege escalation  
- Pre-checks  
- VLAN deletion  
- Trunk interface cleanup  
- DHCP snooping removal  
- Post-check verification  
- Logging & audit trails  

CleanSwitch was **tested with the following runtime environment**:

```
PSVersionTable
Name                           Value
----                           -----
PSVersion                      5.1.20348.4163
```

---

## 🌐 Why CleanSwitch?

<div align="center">
<img src="https://img.icons8.com/color/96/automation.png" width="90">
</div>

- 🚦 **Consistent behavior** across all switches  
- 🛡️ **Zero-risk checks** before & after configuration  
- ⚙️ **IOS-style CLI compatibility** (short & long interface names)  
- 📄 **Full per-device logging** for audits  
- 🧱 **Single-file architecture** – no CSVs, JSONs or external dependencies  
- 🔒 **No sensitive data in repo** (placeholders only)  

---

## 🧩 Architecture Diagram

```
                ┌───────────────────────────────┐
                │          CleanSwitch           │
                │   (wipe_switches.ps1)          │
                └───────────────┬───────────────┘
                                │
                                ▼
                     ┌───────────────────┐
                     │  Load Credentials │
                     └──────────┬────────┘
                                │
               ┌────────────────┴─────────────────┐
               ▼                                  ▼
      ┌──────────────────┐               ┌──────────────────┐
      │ Iterate Switches │               │   For Each IP     │
      └───────┬──────────┘               └────────┬─────────┘
              │                                      │
              ▼                                      ▼
    ┌──────────────────┐                    ┌──────────────────┐
    │ SSH Connection    │──────────────────►│ Privilege Check  │
    └──────────────────┘                    └────────┬─────────┘
                                                     │
                                                     ▼
                                           ┌─────────────────────┐
                                           │   Pre‑Check Phase   │
                                           └─────────┬───────────┘
                                                     │
                                                     ▼
                                           ┌─────────────────────┐
                                           │ Config Application  │
                                           └─────────┬───────────┘
                                                     │
                                                     ▼
                                           ┌─────────────────────┐
                                           │  Post‑Check Phase   │
                                           └─────────┬───────────┘
                                                     │
                                                     ▼
                                           ┌─────────────────────┐
                                           │     Logging         │
                                           └─────────────────────┘
```

---

## 🛠 Key Features

| Category | Description |
|---------|-------------|
| **Layer 2 Focus** | Built for VLAN operations, trunk cleanup, DHCP snooping cleanup |
| **Safe Execution** | Pre & post checks ensure reliability |
| **Interface Intelligence** | Auto-switch between short & long interface names |
| **Portable** | Single-file, no extra files required |
| **Auditable** | All outputs saved, including fallback detection |
| **CLI-like Behavior** | Perfect for IOS-style switches |

---

## ⚙ Configuration

### 1️⃣ Credentials

```powershell
$User = '<switch-username>'
$SecurePass = ConvertTo-SecureString '<switch-password>' -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)
```

### 2️⃣ Switch Management IPs

```powershell
# TOATE IP-URILE
$IPs = @(
    "127.0.0.1",
    "127.0.0.2"
)
```

Replace these with your real management IPs in your private copy.

### 3️⃣ VLAN Configuration

Search for:

```
vlan 12
```

And replace with the VLAN you want to remove.

---

## ▶️ Usage

```powershell
cd C:\Path\To\CleanSwitch
.\wipe_switches.ps1
```

Output will be saved automatically in:

```
.\outputs\
run_YYYYMMDD_HHMMSS.log
```

---

## 📁 Log Output Example

```
172.16.10.11_20251113_182200.txt
172.16.10.12_20251113_182204.txt

[18:22:01] 172.16.10.11 OK
[18:22:03] 172.16.10.12 ERROR: Connection timed out
```

---

## 🛡 Best Practices

- Test on **one switch first**
- Keep production variant **private**
- Always validate logs
- Consider using `copy run tftp:` before running automation

---

## 🧭 Roadmap

- [ ] Multi-VLAN execution  
- [ ] CSV import for IPs  
- [ ] Parallel execution  
- [ ] Dry-run mode  
- [ ] Enhanced exception tracking  

---

## ❓ FAQ

**Does it work on Layer 3 switches?**  
Yes, but only Layer 2 features are touched.

**Can I break something?**  
Only if VLAN removal is critical — test first.

**Can I automate more than VLAN cleanup?**  
Yes! The framework is expandable.

---

## 📝 License

```
MIT License
```

---

## 🤝 Contributions

PRs, Issues and feature requests are welcome!

If this tool helps you, 🌟 **leave a star on GitHub**.
