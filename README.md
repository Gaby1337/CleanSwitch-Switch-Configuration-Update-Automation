⚡ CleanSwitch
Automated Switch Configuration Cleanup
<div align="center">

A modern, reliable, fully-automated PowerShell tool for mass VLAN cleanup and switch configuration maintenance via SSH.

<br> <img src="https://img.shields.io/badge/PowerShell-5.1+-blue?style=for-the-badge"> <img src="https://img.shields.io/badge/SSH-Enabled-success?style=for-the-badge"> <img src="https://img.shields.io/badge/Platforms-IOS/NXOS-orange?style=for-the-badge"> <img src="https://img.shields.io/badge/Data-Dummy%20Only-purple?style=for-the-badge"> </div>
🔥 Why CleanSwitch?

CleanSwitch provides a safe, repeatable and fully automated way to clean up VLANs, trunk ports and leftover DHCP artifacts across dozens of switches.

✔ No external config files
✔ All management IPs stored inside the script
✔ Automatic logging
✔ Zero manual SSH interaction

Fully automated. Fully auditable. Fully controlled.

✨ Core Features
🟦 Connectivity

SSH automation using Posh-SSH

Automatic detection of enable/privileged mode

🟧 VLAN & Port Cleanup

Removes specific VLANs (customizable)

Cleans trunk ports (g0/1, g0/2 + fallback)

🟩 Safety & Logging

Saves running configuration

Per-switch log files

Global summary log

Uses dummy IPs & credentials in the public repo

🧬 Architecture
CleanSwitch/
│
├── wipe_switches.ps1        # Main engine (logic + IP list + SSH handling)
│
├── outputs/                 # Auto-generated logs
│   └── README.md
│
├── LICENSE                  # MIT License
├── CONTRIBUTING.md          # Optional contribution guidelines
└── .gitignore               # Ignore logs, temp files, artifacts

⚙️ Requirements
Component	Minimum
PowerShell	5.1 or 7+
Module	Posh-SSH 3.0+
OS	Windows / macOS / Linux (PS7)

Install SSH module:

Install-Module Posh-SSH -Scope CurrentUser -Force

🛠 Configuration
Switch IPs

All management IPs are stored directly in wipe_switches.ps1:

$IPs = @(
    "10.10.10.1",
    "10.10.10.2",
    "10.10.10.3"
)

Credentials
$User = "admin"
$SecurePass = ConvertTo-SecureString "password" -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)


⚠️ Only dummy IPs and credentials should be committed to GitHub.

▶️ Running the Tool

Run CleanSwitch:

powershell.exe -ExecutionPolicy Bypass -File .\wipe_switches.ps1


Logs will be generated in:

outputs/

📄 Example Log
[12:00:00] Connecting to 10.10.10.1...
[12:00:01] Entered privileged mode
[12:00:03] VLAN 1603 removed
[12:00:04] Cleaned trunk ports
[12:00:06] Saved configuration
[OK] Completed: 10.10.10.1

🧭 Roadmap

 Dry-run mode

 Parallel device execution

 Switch model auto-detection

 Multi-vendor support

 Web UI for monitoring executions

<div align="center">
🤝 Contributions

PRs, improvements and suggestions are welcome.

📜 License

Released under the MIT License.

⭐ If this project helps you, consider giving it a star.

</div>
