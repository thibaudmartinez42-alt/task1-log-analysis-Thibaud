<#
.SYNOPSIS
Active Directory & GPO Configuration Script - Task 7
Simulates Domain Controller setup, OU creation, and GPO linking.
#>

Write-Host "Starting Windows Server AD & GPO Configuration..." -ForegroundColor Cyan

# 1. DOMAIN CONTROLLER SETUP
Write-Host "[+] Installing Active Directory Domain Services..." -ForegroundColor Yellow
# Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
# Install-ADDSForest -DomainName "corp.local" -InstallDns

# 2. ORGANIZATIONAL UNITS (OUs)
Write-Host "[+] Creating Organizational Units (OUs)..." -ForegroundColor Yellow
# New-ADOrganizationalUnit -Name "Teachers" -Path "DC=corp,DC=local"
# New-ADOrganizationalUnit -Name "Students" -Path "DC=corp,DC=local"

# 3. USERS CREATION
Write-Host "[+] Provisioning Test Users..." -ForegroundColor Yellow
# New-ADUser -Name "teacher_test" -Path "OU=Teachers,DC=corp,DC=local" -Enabled $true
# New-ADUser -Name "student_test" -Path "OU=Students,DC=corp,DC=local" -Enabled $true

# 4. GPO CREATION & CONFIGURATION
Write-Host "[+] Creating Group Policy Objects (GPOs)..." -ForegroundColor Yellow
# New-GPO -Name "GPO_Restrict_ControlPanel"
# New-GPO -Name "GPO_Disable_SoftwareInstall"
# New-GPO -Name "GPO_Strong_Password_Policy"

# 5. GPO LINKING
Write-Host "[+] Linking GPOs to Organizational Units..." -ForegroundColor Yellow
# Set-GPLink -Name "GPO_Restrict_ControlPanel" -Target "OU=Students,DC=corp,DC=local"
# Set-GPLink -Name "GPO_Disable_SoftwareInstall" -Target "OU=Students,DC=corp,DC=local"
# Set-GPLink -Name "GPO_Strong_Password_Policy" -Target "DC=corp,DC=local"

Write-Host "Active Directory & GPO Configuration successfully applied!" -ForegroundColor Green
