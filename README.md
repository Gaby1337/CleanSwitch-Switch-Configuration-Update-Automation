<h1 align="center">
  <img src="https://img.icons8.com/fluency/96/console.png" width="80"><br>
  <b>CleanSwitch ⚡</b>
</h1>

<p align="center">
  <i>Enterprise-grade automation for orchestrated VLAN cleanup on Layer 2 switches via PowerShell + SSH</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-3178C6?style=for-the-badge&logo=powershell&logoColor=white">
  <img src="https://img.shields.io/badge/Tested%20On-PSVersion%205.1.20348.4163-success?style=for-the-badge">
  <img src="https://img.shields.io/badge/Switch%20Type-Layer%202-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Transport-SSH%20(via%20Posh--SSH)-0FA958?style=for-the-badge">
  <img src="https://img.shields.io/badge/Security-No%20Real%20IPs%20or%20Passwords-purple?style=for-the-badge">
  <img src="https://img.shields.io/badge/Verified-Automation%20Framework-brightgreen?style=for-the-badge&logo=vercel&logoColor=white">
</p>

---

<div align="center">
<img src="https://img.icons8.com/external-flatart-icons-outline-flatarticons/128/external-network-administrator-it-flatart-icons-outline-flatarticons.png" width="110"><br>
<h3>“One script. Many switches. Zero manual work.”</h3>
</div>

---

## 📘 What is CleanSwitch?

**CleanSwitch** is a production-ready PowerShell automation framework that performs **safe, predictable, repeatable VLAN cleanup** across multiple **Layer 2 network switches**.

Tested on:

```
PSVersionTable
Name                           Value
----                           -----
PSVersion                      5.1.20348.4163
```

---

## 📁 Log Output Example

Below is a realistic log sample with **different management IP ranges**:

```
10.32.55.11_20251113_182200.txt
10.32.55.14_20251113_182204.txt
10.32.55.21_20251113_182207.txt

[18:22:01] 10.32.55.11 OK -> .\outputs\10.32.55.11_20251113_182200.txt
[18:22:03] 10.32.55.14 ERROR: SSH connection failed
[18:22:05] 10.32.55.21 OK -> .\outputs\10.32.55.21_20251113_182207.txt
```

---

## 🛠 Key Features

| Category | Description |
|---------|-------------|
| **Layer 2 Focus** | VLAN removal, trunk cleanup, DHCP snooping cleanup |
| **Verified Automation Framework** | Badge-certified consistency & reliability |
| **Interface Intelligence** | Short & long interface fallback |
| **IOS-friendly** | Behaves exactly like a human doing CLI operations |
| **Robust Logging** | Every switch gets a fully timestamped output file |
| **Zero Sensitive Data** | Repo contains placeholders only |

---

## ⚙ Configuration

### Switch IP Example (placeholder)

```powershell
$IPs = @(
    "10.32.55.11",
    "10.32.55.14",
    "10.32.55.21"
)
```

---

## ▶️ Usage

```powershell
cd C:\Path\To\CleanSwitch
.\wipe_switches.ps1
```

---

## 📝 License

MIT License

---

## 🤝 Contributions

PRs, Issues and enhancements welcome.
