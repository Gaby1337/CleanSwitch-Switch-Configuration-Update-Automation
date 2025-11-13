<h1 align="center">⚡ CleanSwitch – Automated Switch Configuration Cleanup</h1> <p align="center"> A fully automated PowerShell tool for bulk VLAN and configuration cleanup across multiple switches via SSH. </p> <p align="center"> <img src="https://img.shields.io/badge/Automation-PowerShell%205.1+-blue?style=for-the-badge"> <img src="https://img.shields.io/badge/Protocol-SSH-green?style=for-the-badge"> <img src="https://img.shields.io/badge/Switching-IOS/NXOS-orange?style=for-the-badge"> <img src="https://img.shields.io/badge/Safe-Dummy%20Data-purple?style=for-the-badge"> </p>
🚀 Overview

CleanSwitch is a standalone PowerShell automation script designed to safely clean up VLANs, trunk ports, and related configuration items on multiple network switches.

It requires zero external files:
✔ All management IPs are stored directly inside the script
✔ Credentials are embedded using secure strings
✔ Logging is fully automatic

Ideal for environments where fast, repeatable switch cleanup is needed without manual SSH interaction.

📦 Features

🔑 Auto-login to switches using SSH (Posh-SSH)

⚙️ Detects enable/privileged mode

🧹 Removes specific VLANs (customizable)

🔌 Cleans trunk ports (g0/1, g0/2 + fallback)

🧾 Saves running config to memory

📋 Generates detailed logs per switch

📝 Creates a global execution log

🛡 Uses dummy IPs and dummy credentials in repo (no sensitive data)

📁 Architecture
CleanSwitch/
│
├── wipe_switches.ps1        → Main automation script (IPs & logic inside)
│
├── outputs/                 → Auto-generated logs per switch
│   └── README.md
│
├── LICENSE                  → MIT License
├── CONTRIBUTING.md          → (Optional: How to contribute)
└── .gitignore               → Ignore logs, backups, etc.

🔧 Requirements

PowerShell 5.1 or PowerShell 7+

Posh-SSH module v3.0+

Windows, Linux or macOS supported (via PowerShell 7)

🛠 Installation

Install the SSH module:

Install-Module Posh-SSH -Scope CurrentUser -Force


Clone the repository:

git clone https://github.com/Gaby1337/CleanSwitch-Switch-Configuration-Update-Automation
cd CleanSwitch-Switch-Configuration-Update-Automation

🖥 Configuration
🔌 Management IPs

All switch management IPs are stored directly inside the script:

# Switch IPs (dummy data for GitHub)
$IPs = @(
    "10.10.10.1",
    "10.10.10.2",
    "10.10.10.3"
)


Replace these IPs with your real management IPs before running in production.

🔐 Credentials

Credentials are stored in secure string format:

$User = "admin"
$SecurePass = ConvertTo-SecureString "yourpassword" -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)


⚠️ Never commit real passwords or customer data to GitHub.

▶️ Running CleanSwitch

Execute the script:

powershell.exe -ExecutionPolicy Bypass -File .\wipe_switches.ps1


The tool will:

Connect to each switch

Enter enable/privileged mode

Remove the configured VLAN

Clean trunk ports & artifacts

Save config

Generate logs

Logs will automatically appear inside the outputs/ folder.

📜 Example Logs

Example entries generated:

[2025-01-01 12:00:00] Connecting to 10.10.10.1 ...
[2025-01-01 12:00:02] Entered enable mode
[2025-01-01 12:00:04] VLAN removed successfully
[2025-01-01 12:00:05] Trunk ports cleaned
[2025-01-01 12:00:08] Configuration saved
[OK] Completed: 10.10.10.1

🧪 Compatibility

Tested on:

Cisco IOS

Cisco NX-OS

Layer 2/3 enterprise switches

Standard SSH configurations

🧩 Roadmap

 Add Dry-Run mode

 Add parallel execution

 Add custom VLAN selector

 Add switch model autodetection

 Add multi-vendor templates

🤝 Contributing

Contributions are welcome!
Please check CONTRIBUTING.md for details.

📝 License

This project is licensed under the MIT License.
You may use, modify, and distribute freely — see LICENSE.

⭐ Support the Project

If you find this project useful, consider giving it a ⭐ on GitHub.
Your feedback motivates further development.
