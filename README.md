<h1 align="center">
  <img src="https://img.icons8.com/fluency/96/console.png" width="90"><br>
  <b>CleanSwitch ⚡</b>
</h1>

<p align="center">
  <i>Next‑generation PowerShell automation for orchestrated VLAN cleanup on Layer 2 switches via SSH</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-3178C6?style=for-the-badge&logo=powershell&logoColor=white">
  <img src="https://img.shields.io/badge/Tested%20On-PSVersion%205.1.20348.4163-success?style=for-the-badge">
  <img src="https://img.shields.io/badge/Switch%20Environment-Layer%202-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Transport-SSH%20Automation-0FA958?style=for-the-badge">
  <img src="https://img.shields.io/badge/Security-No%20Real%20Data-purple?style=for-the-badge">
  <img src="https://img.shields.io/badge/Verified-Automation%20Framework-brightgreen?style=for-the-badge&logo=vercel&logoColor=white">
</p>

---

<div align="center">
<img src="https://img.icons8.com/external-flatart-icons-outline-flatarticons/128/external-network-administrator-it-flatart-icons-outline-flatarticons.png" width="110"><br>
<h3>“One script. Unlimited switches. Full automation.”</h3>
</div>

---

# 🌟 CleanSwitch – Advanced Overview

CleanSwitch is a **premium-grade PowerShell automation framework** designed to remove VLANs across **multiple Layer 2 switches**, modify trunk ports, wipe DHCP snooping entries, save configuration changes, and log everything — fully automatically.

Perfect for:
- ISPs  
- Datacenters  
- Corporations  
- Network operations centers (NOC)  
- Mass switch maintenance  

This framework has been **tested** and validated on:

```
PSVersionTable
Name                           Value
----                           -----
PSVersion                      5.1.20348.4163
```

---

# 🧠 How CleanSwitch Works (High‑Level Flow)

```
 ┌────────────────────────────────────────────────────┐
 │                    CleanSwitch.ps1                 │
 └───────────────────┬────────────────────────────────┘
                     │
                     ▼
         Load Credentials (username + password)
                     │
                     ▼
              Load Management IPs
                     │
                     ▼
            For each switch in $IPs:
                     │
                     ▼
            SSH Login → Enter ENABLE mode
                     │
                     ▼
           Pre‑Checks (VLAN, DHCP, Interfaces)
                     │
                     ▼
        Remove VLAN → Clean Trunks → Remove Snooping
                     │
                     ▼
                 write memory
                     │
                     ▼
                 Post Checks
                     │
                     ▼
                 Save Logs
```

---

# 🔧 **Where YOU Must Edit the Script**

The following sections inside your script **must be customized by the user**.

---

# 1️⃣ Credentials – *User + Password for Switches*  
📌 **Modify these lines inside your script:**

```powershell
# ===========================
# SWITCH CREDENTIALS (EDIT)
# ===========================
$User = '<USERNAME_DE_LOGIN_LA_SWITCH>'
$SecurePass = ConvertTo-SecureString '<PAROLA_DE_LA_SWITCH>' -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)

# Required for enable mode (IOS-style prompt)
$PlainPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePass)
)
```

✔ Introduci user + parolă aici  
✔ Parola este convertită automat în SecureString  
✔ Folosită la login + enable mode  

---

# 2️⃣ Management IPs – *List of all switches to process*

📌 **EDIT this block to match your network:**

```powershell
# ===========================
# MANAGEMENT IPs (EDIT)
# ===========================
$IPs = @(
    "10.32.55.11",
    "10.32.55.14",
    "10.32.55.21",
    "10.32.55.22"
)
```

✔ Adaugi / ștergi oricâte IP-uri  
✔ Execută comenzi pe toate automat  

---

# 3️⃣ VLAN Deconfiguration – *The VLAN to remove*

📌 **EDIT all occurrences of the VLAN ID:**

```powershell
# ===========================
# V-L-A-N   T-O   R-E-M-O-V-E
# ===========================
no vlan 12
switchport trunk allowed vlan remove 12
no ip dhcp snooping vlan 12
show vlan id 12
```

✏️ **Schimbă "12" cu VLAN-ul tău real**  
🛡️ Recomandare: Testează întâi pe 1 switch  

---

# 📝 Example of Advanced Log Output (with REALISTIC dummy data)

```
10.32.55.11_20251113_182200.txt
10.32.55.14_20251113_182204.txt
10.32.55.21_20251113_182207.txt
10.32.55.22_20251113_182210.txt

[18:22:01] 10.32.55.11 OK (VLAN removed successfully)
[18:22:03] 10.32.55.14 ERROR: SSH authentication failed
[18:22:05] 10.32.55.21 OK (Trunks cleaned)
[18:22:07] 10.32.55.22 OK (DHCP snooping removed)
```

✔︎ Arată exact ce s-a întâmplat  
✔︎ Fiecare dispozitiv are log separat  
✔︎ Rezumat global în fișier .log  

---

# 🔥 Key Features (Enhanced)

| Feature | Description |
|--------|-------------|
| **Full Automation** | No manual CLI work — everything over SSH |
| **Layer 2 Ready** | Optimized for VLAN/port operations |
| **Enable Mode Smart Logic** | Detects password prompts automatically |
| **Interface Auto-Fallback** | Supports g0/1 + GigabitEthernet0/1 |
| **Verified Automation Badge** | Quality standard for automation frameworks |
| **Structured Logging** | Full output per switch + main summary |
| **Zero Sensitive Data** | Public repo contains no real IPs or passwords |

---

# ▶️ Usage

```powershell
cd C:\Path\To\CleanSwitch
.\wipe_switches.ps1
```

---

# 🛡 Best Practices

✔ Rule #1: Test on one switch first  
✔ Rule #2: Verifică logurile după execuție  
✔ Rule #3: Păstrează versiunea cu date reale în privat  
✔ Rule #4: Fă backup înainte de cleanup masiv  

---

# 🧭 Roadmap

- Multi-VLAN cleanup  
- Multi-threading execution  
- CSV import for IPs  
- Dry-run simulation mode  
- Enhanced error mapping  

---

# 📝 License

MIT License

---

# 🤝 Contributions

PRs & Issues welcome.  
If you're using CleanSwitch and love it — **leave a ⭐ on GitHub!**

