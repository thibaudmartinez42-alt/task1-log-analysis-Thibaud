# Task 2 - Local Office Communication System & Infrastructure as Code

## Objective
To set up a local communication infrastructure including a mail server, role-based file sharing, and a network printer. This repository contains the automated setup script (setup_infrastructure.ps1) used to deploy the environment.

---

## Technical Implementation & Code Breakdown

The deployment is automated using PowerShell, interacting directly with Windows OS components and the hMailServer COM API. Here is the precise breakdown of the script operations:

### 1. Users & Groups Management (RBAC)
The script automates the creation of the local Windows environment needed for Role-Based Access Control:
- **Secure Credentials**: Uses ConvertTo-SecureString to securely handle the default password (P@ssw0rd123!).
- **User Creation**: Loops through an array of usernames (direction, h, 	ech, compta, stagiaire) and uses New-LocalUser to provision them on the Windows machine.
- **Group Assignment**: Creates Direction_Group and RH_Group using New-LocalGroup, then binds the respective users to these groups via Add-LocalGroupMember to establish the RBAC foundation.

### 2. File Sharing & NTFS Permissions (SMB)
- **Directory Provisioning**: Uses New-Item to generate the root directory C:\Shares and its sub-folders (Public, Direction_Only, RH_Only).
- **SMB Sharing**: Employs New-SmbShare to expose the folders to the local network.
- **Access Control**: 
  - Public is granted -FullAccess "Everyone".
  - Sensitive folders are locked down using -ReadAccess paired with the specific local groups created in step 1, ensuring data compartmentalization.

### 3. Network Printer Deployment
- **Driver Installation**: Uses Add-PrinterDriver to load the native "Generic / Text Only" driver, ensuring high compatibility without requiring heavy external drivers.
- **Printer Creation**: Uses Add-Printer with the -Shared $true flag to instantly expose the virtual printer (Imprimante_Bureau_Share) to the network on the LPT1: port.

### 4. Mail Server Automation (hMailServer COM API)
Instead of manual GUI configuration, the script leverages the hMailServer Component Object Model (COM) API:
- **Authentication**: Connects to the hMailServer.Application object and authenticates programmatically using the admin credentials.
- **Global Settings**: Modifies the Settings.MaxMessageSize property to strictly limit attachments to 10 MB.
- **Domain & Accounts**: Instantiates a new domain (office.local) via $obApp.Domains.Add() and programmatically loops to generate all internal mailboxes and routing aliases.

---

## Validation & Testing
- SMTP delivery tests were successfully validated via PowerShell (Send-MailMessage) and cross-checked with the hMailServer SMTP logs (status 250 Queued).
- Role-based access control (RBAC) was verified using local authentication for each specific folder mapped via \\localhost.

## Documentation
Complete user manuals for mail client configuration (Thunderbird) and network resource access are available in the /docs folder.
