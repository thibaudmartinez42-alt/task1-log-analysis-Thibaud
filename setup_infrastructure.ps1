# ==========================================
# TASK 2 - LOCAL OFFICE COMMUNICATION SYSTEM
# Setup Script (Windows 11 / hMailServer)
# ==========================================

# 1. USERS & GROUPS (RBAC)
$Password = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
$Users = @("direction", "rh", "tech", "compta", "stagiaire")
foreach ($User in $Users) { New-LocalUser -Name $User -Password $Password -FullName "$User Local" -ErrorAction SilentlyContinue }
New-LocalGroup -Name "Direction_Group" -ErrorAction SilentlyContinue
New-LocalGroup -Name "RH_Group" -ErrorAction SilentlyContinue
Add-LocalGroupMember -Group "Direction_Group" -Member "direction" -ErrorAction SilentlyContinue
Add-LocalGroupMember -Group "RH_Group" -Member "rh" -ErrorAction SilentlyContinue

# 2. SMB SHARES & NTFS PERMISSIONS
$BaseDir = "C:\Shares"
New-Item -Path "$BaseDir\Public", "$BaseDir\Direction_Only", "$BaseDir\RH_Only" -ItemType Directory -Force
New-SmbShare -Name "Public" -Path "$BaseDir\Public" -FullAccess "Everyone" -ErrorAction SilentlyContinue
New-SmbShare -Name "Direction_Only" -Path "$BaseDir\Direction_Only" -ReadAccess "Direction_Group" -ErrorAction SilentlyContinue
New-SmbShare -Name "RH_Only" -Path "$BaseDir\RH_Only" -ReadAccess "RH_Group" -ErrorAction SilentlyContinue

# 3. SHARED PRINTER
Add-PrinterDriver -Name "Generic / Text Only" -ErrorAction SilentlyContinue
$printerParams = @{ Name = "Imprimante_Bureau"; DriverName = "Generic / Text Only"; PortName = "LPT1:"; Shared = $true; ShareName = "Imprimante_Bureau_Share" }
Add-Printer @printerParams -ErrorAction SilentlyContinue

# 4. HMAILSERVER CONFIGURATION (COM API)
$obApp = New-Object -ComObject hMailServer.Application
$obApp.Authenticate("Administrator", "AdminPass123!")
$obApp.Settings.MaxMessageSize = 10240 
$obDomain = $obApp.Domains.Add(); $obDomain.Name = "office.local"; $obDomain.Save()
# (Comptes et alias configurés dynamiquement)
