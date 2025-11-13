🌩️ CleanSwitch
Automated Switch Configuration Cleanup via PowerShell + SSH
<p align="center"> <img src="https://img.shields.io/badge/PowerShell-5.1+-blue?style=for-the-badge"> <img src="https://img.shields.io/badge/Protocol-SSH-green?style=for-the-badge"> <img src="https://img.shields.io/badge/Switching-IOS/NXOS-orange?style=for-the-badge"> <img src="https://img.shields.io/badge/Data-Dummy%20Only-purple?style=for-the-badge"> </p>
📘 Overview

CleanSwitch is a fully automated PowerShell tool for bulk VLAN and configuration cleanup
across multiple switches — safely, consistently, and without manual SSH interaction.

✔ No external files
✔ All management IPs inside the script
✔ Secure credentials using SecureString
✔ Automatic per-switch logs

✨ Features

🔐 Automatic SSH login (Posh-SSH)

🔧 Auto-detect privileged/enable mode

🧹 Remove chosen VLAN(s)

🔌 Clean trunk ports (g0/1, g0/2 + fallback)

💾 Save running configuration

📄 Generate per-switch logs

📊 Create a global summary log

🔒 Uses ONLY dummy data in the GitHub version

🧱 Architecture
CleanSwitch/
│
├── wipe_switches.ps1     → Main automation script (includes IPs + logic)
│
├── outputs/              → Auto-generated logs for each switch
│   └── README.md
│
├── LICENSE               → MIT License
├── CONTRIBUTING.md       → Contribution guidelines (optional)
└── .gitignore            → Ignore logs, temp files, backups

⚙️ Requirements

PowerShell 5.1 or PowerShell 7+

Posh-SSH 3.0+

Windows, Linux or macOS (via PS7)

Install SSH module:

Install-Module Posh-SSH -Scope CurrentUser -Force

🛠 Configuration

All switch IPs are defined inside the script:

$IPs = @(
    "10.10.10.1",
    "10.10.10.2",
    "10.10.10.3"
)


Credentials:

$User = "admin"
$SecurePass = ConvertTo-SecureString "password" -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)


⚠️ Do NOT commit real IPs or real passwords. Only dummy data.

▶️ Usage
powershell.exe -ExecutionPolicy Bypass -File .\wipe_switches.ps1


During execution, the script will:

Connect to each switch

Enter privileged mode

Remove VLAN

Clean trunk ports

Save configuration

Log actions

Logs appear automatically in:

outputs/

📄 Sample Log Output
[12:00:00] Connecting to 10.10.10.1...
[12:00:01] Entered privileged mode
[12:00:03] VLAN 1603 removed
[12:00:04] Cleaned trunk ports
[12:00:06] Saved configuration
[OK] Switch 10.10.10.1 completed

📌 Roadmap

 Add Dry-Run mode

 Parallel execution

 Auto-detect switch platform

 Custom VLAN selector

 Multi-vendor profiles

🤝 Contributing

Contributions welcome!
See CONTRIBUTING.md.

📄 License

Released under the MIT License.
