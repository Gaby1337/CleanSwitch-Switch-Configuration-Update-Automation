# === wipe_switches.ps1 (PS 5.1, compat maxim, ShellStream + enable) ===
if (-not (Get-Module -ListAvailable -Name Posh-SSH)) {
  Install-Module Posh-SSH -Scope CurrentUser -Force -AllowClobber
}
Import-Module Posh-SSH -ErrorAction Stop

# Creds
$User = 'admin'
$SecurePass = ConvertTo-SecureString 'us' -AsPlainText -Force
$Cred = [pscredential]::new($User, $SecurePass)
$PlainPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePass))

# TOATE IP-URILE
$IPs = @(
"127.0.0.1","127.0.0.2"
)

$OutDir = ".\outputs"; if (-not (Test-Path $OutDir)) { New-Item -Type Directory $OutDir | Out-Null }
$Log = ".\run_$(Get-Date -Format yyyyMMdd_HHmmss).log"

function Send-Line { param($Stream,[string]$Cmd,[int]$SleepMs=250); $Stream.WriteLine($Cmd); Start-Sleep -Milliseconds $SleepMs; return $Stream.Read() }
function Ensure-PrivExec {
  param($Stream)
  $out = Send-Line $Stream "terminal length 0"
  if ($out -notmatch "#") {
    $null = Send-Line $Stream "enable"
    $resp = $Stream.Read()
    if ($resp -match "Password") { $null = Send-Line $Stream $PlainPass }
    Start-Sleep -Milliseconds 300
    $out = $Stream.Read()
  }
  return $out
}

function Do-Device {
  param([string]$Ip)
  $stamp = Get-Date -Format "yyyyMMdd_HHmmss"
  $outfile = Join-Path $OutDir "$($Ip)_$stamp.txt"
  try {
    $sess = New-SSHSession -ComputerName $Ip -Credential $Cred -AcceptKey -ConnectionTimeout 12 -ErrorAction Stop
    $stream = New-SSHShellStream -SessionId $sess.SessionId
    Start-Sleep -Milliseconds 200 | Out-Null
    $null = $stream.Read()

    $null = Ensure-PrivExec -Stream $stream

    $out = ""
    # SHOW (pre)
    $out += Send-Line $stream "show vlan id 12"
    $out += Send-Line $stream "show running-config interface g0/1"
    $out += Send-Line $stream "show ip dhcp snooping"

    # CONFIG
    $out += Send-Line $stream "configure terminal"
    $out += Send-Line $stream "no vlan 12"
    $out += Send-Line $stream "end"

    $out += Send-Line $stream "configure terminal"
    $out += Send-Line $stream "interface g0/1"
    $out += Send-Line $stream "switchport trunk allowed vlan remove 12"
    $out += Send-Line $stream "interface g0/2"
    $out += Send-Line $stream "switchport trunk allowed vlan remove 12"
    $out += Send-Line $stream "end"

    $out += Send-Line $stream "configure terminal"
    $out += Send-Line $stream "no ip dhcp snooping vlan 12"
    $out += Send-Line $stream "end"

    $out += Send-Line $stream "write memory" 600

    # SHOW (post)
    $out += Send-Line $stream "show vlan id 12"
    $out += Send-Line $stream "show running-config interface g0/1"
    $out += Send-Line $stream "show ip dhcp snooping"

    # Dacă interfețele scurte nu merg, încearcă numele lungi
    if ($out -match "Invalid input detected|% Ambiguous|Incomplete command") {
      $out += "`r`n---- ALT INTERFETE (GigabitEthernet0/1-0/2) ----`r`n"
      $out += Send-Line $stream "configure terminal"
      $out += Send-Line $stream "interface GigabitEthernet0/1"
      $out += Send-Line $stream "switchport trunk allowed vlan remove 12"
      $out += Send-Line $stream "interface GigabitEthernet0/2"
      $out += Send-Line $stream "switchport trunk allowed vlan remove 12"
      $out += Send-Line $stream "end"
      $out += Send-Line $stream "show running-config interface GigabitEthernet0/1"
    }

    $out | Out-File -FilePath $outfile -Encoding utf8
    "[$(Get-Date -Format HH:mm:ss)] $Ip OK -> $outfile" | Tee-Object -FilePath $Log -Append
    Remove-SSHSession -SessionId $sess.SessionId | Out-Null
  }
  catch {
    "[$(Get-Date -Format HH:mm:ss)] $Ip ERROR: $($_.Exception.Message)" | Tee-Object -FilePath $Log -Append
  }
}

foreach ($ip in $IPs) { Do-Device $ip }
"Done $(Get-Date)" | Add-Content $Log
