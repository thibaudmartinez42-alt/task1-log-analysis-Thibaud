# Local Office Communication & Resource Sharing System

## 1. Project Overview
This project implements a secure local infrastructure for the agency, focusing on internal messaging and role-based file access[cite: 4]. The environment is built on Windows 11 using hMailServer for SMTP/IMAP services and Native Windows SMB for file sharing[cite: 7, 11].

## 2. Mail System Architecture (hMailServer)
The system uses the local domain `office.local`[cite: 8].

### Accounts & Distribution
- **Users**: 5 dedicated accounts (direction, rh, tech, compta, stagiaire)[cite: 8].
- **Global Mailing List**: `all@office.local` (broadcasts to all staff members)[cite: 10].
- **Alias/Forwarder**: `contact@office.local` automatically forwards to the HR department (rh@)[cite: 10].
- **Policy**: Attachment size is strictly limited to **10 MB** to preserve local storage[cite: 10].

## 3. File Sharing & Permissions (RBAC)
Resources are shared via SMB with Role-Based Access Control (RBAC).

| Folder | Access Level | Target Group |
| :--- | :--- | :--- |
| **Public** | Read/Write | All Staff (Everyone) |
| **Direction_Only** | Restricted | Direction Group only |
| **RH_Only** | Restricted | HR Group only |

## 4. Shared Printing
A central printer named `Imprimante_Bureau` is shared on the network[cite: 12]. It uses a Generic Text driver for cross-platform compatibility[cite: 13].

## 5. Usage Instructions
### Accessing Files
1. Open File Explorer.
2. Enter \\localhost in the address bar.
3. Authenticate with your role credentials (e.g., username: h, password: P@ssw0rd123!).

### Mail Client Setup (Thunderbird)
- **Protocol**: IMAP (Port 143) / SMTP (Port 25)[cite: 9].
- **Server**: 127.0.0.1[cite: 9].
- **Authentication**: Normal password[cite: 9].
