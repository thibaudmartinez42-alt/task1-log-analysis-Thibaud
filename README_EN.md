# Task 2 - Local Office Communication System

## Objective
To set up a local communication infrastructure including a mail server, role-based file sharing, and a network printer[cite: 4, 6].

## Technical Implementation
### 1. Mail Server (hMailServer)
- **Local Domain**: `office.local`.
- **5 User Accounts**: direction, h, 	ech, compta, stagiaire[cite: 8].
- **Aliases & Forwarders**: contact@office.local redirects to h@office.local[cite: 10].
- **Distribution List**: ll@office.local includes all staff members.
- **Attachment Limit**: Restricted to 10 MB per message[cite: 10].

### 2. File Sharing (SMB)
- **Public**: Full access for all users[cite: 11].
- **Direction_Only**: Restricted to the Direction_Group (Role-based access)[cite: 14].
- **RH_Only**: Restricted to the RH_Group (Role-based access)[cite: 14].

### 3. Shared Network Printer
- Virtual printer Imprimante_Bureau shared over the local network using the Generic Text driver[cite: 12, 13].

## Validation & Testing
- SMTP delivery tests were validated via PowerShell and hMailServer logs.
- Role-based access control (RBAC) was verified using local authentication for each specific folder[cite: 14].

## Documentation
- Complete user manuals for mail client configuration and network resource access are available in the /docs folder.
