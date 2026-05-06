# Assignment VI - System Hardening and Access Control

## Security Policy Documentation & Final Report

This repository contains the automated hardening script (system_hardening.ps1) designed to secure a local Windows environment according to industry best practices.

### 1. Identity & Access Management (IAM)
Three distinct user roles were defined to respect the Principle of Least Privilege (PoLP):
- **sec_admin**: Full administrative privileges for system management.
- **sec_dev**: Standard privileges tailored for development tasks.
- **sec_guest**: Restricted access for temporary usage.

### 2. File System Security (NTFS Permissions)
Access Control Lists (ACLs) were heavily restricted on sensitive directories using icacls.
- Inheritance was disabled to prevent accidental permission creep.
- **Admin**: Full Control (F).
- **Dev**: Read & Execute only (RX).

### 3. Service & Port Minimization
To reduce the attack surface, legacy and unused protocols were disabled:
- **FTP** (Port 21): Service disabled.
- **Telnet** (Port 23): Windows feature completely removed.

### 4. Network Security (Firewall)
Windows Defender Firewall was configured to drop inbound traffic for vulnerable ports (21, 23).

### 5. Audit & Logging
Advanced Audit Policy Configuration was enabled (uditpol) to ensure traceability:
- **Logon/Logoff Events**: Both Success and Failure are tracked to monitor potential brute-force attempts.
- **Object Access**: Enabled to track when restricted files are touched.

### Execution
The configuration is deployed via the attached PowerShell script. Please review the execution screenshots for verification.
