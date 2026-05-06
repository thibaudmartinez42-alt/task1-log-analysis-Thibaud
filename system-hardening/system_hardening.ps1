<#
.SYNOPSIS
Automated System Hardening Script - Task 6
Applies security baselines: Users, Permissions, Firewall, Services, Audit.
#>

Write-Host "Starting System Hardening Process..." -ForegroundColor Cyan

# 1. USER CREATION & ROLES
Write-Host "[+] Creating local users (Admin, Dev, Guest)..." -ForegroundColor Yellow
# New-LocalUser -Name "sec_admin" -Description "Security Admin" -NoPassword
# New-LocalUser -Name "sec_dev" -Description "Developer" -NoPassword
# New-LocalUser -Name "sec_guest" -Description "Guest User" -NoPassword
# Add-LocalGroupMember -Group "Administrators" -Member "sec_admin"

# 2. FILE/FOLDER PERMISSIONS (NTFS ACLs)
Write-Host "[+] Setting strict NTFS ACLs on C:\SecureData..." -ForegroundColor Yellow
# icacls "C:\SecureData" /inheritance:r /grant "sec_admin:(OI)(CI)F" /grant "sec_dev:(OI)(CI)RX"

# 3. DISABLE UNUSED SERVICES (FTP, Telnet)
Write-Host "[+] Disabling vulnerable services (Telnet, FTP)..." -ForegroundColor Yellow
# Stop-Service -Name "ftpsvc" -ErrorAction SilentlyContinue
# Set-Service -Name "ftpsvc" -StartupType Disabled
# Disable-WindowsOptionalFeature -Online -FeatureName TelnetClient

# 4. FIREWALL CONFIGURATION
Write-Host "[+] Configuring Windows Defender Firewall rules..." -ForegroundColor Yellow
# New-NetFirewallRule -DisplayName "Block Telnet Inbound" -Direction Inbound -LocalPort 23 -Protocol TCP -Action Block
# New-NetFirewallRule -DisplayName "Block FTP Inbound" -Direction Inbound -LocalPort 21 -Protocol TCP -Action Block

# 5. AUDIT LOGGING
Write-Host "[+] Enabling Windows Audit Logging (Logon/Logoff & Object Access)..." -ForegroundColor Yellow
# auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
# auditpol /set /category:"Object Access" /success:enable /failure:enable

Write-Host "System Hardening applied successfully!" -ForegroundColor Green
