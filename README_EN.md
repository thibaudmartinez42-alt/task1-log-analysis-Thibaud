# Assignment III - Network Configuration & Backup Strategy

## 1. Network Design
A small office network has been simulated using Cisco Packet Tracer. The topology consists of 3 clients, 1 central server, and 1 network printer interconnected via a Cisco 2960 Switch.

## 2. IP Addressing Table
Static IPv4 addresses are assigned to ensure persistent connectivity for shared resources (Server and Printer) within the 192.168.10.0/24 subnet.
- **Server (SRV-MAIN)**: 192.168.10.10
- **Clients (PC-TECH, PC-RH, PC-DIR)**: 192.168.10.21 - 192.168.10.23
- **Printer (PRN-OFFICE)**: 192.168.10.50
- **DNS Resolution**: office-server.local points to 192.168.10.10

## 3. Backup Strategy (Robocopy)
Automation is handled via a scheduled Windows Robocopy script to ensure data redundancy.
- **Command**: obocopy C:\Users\Data \\192.168.10.10\Backups /MIR /LOG:C:\Logs\backup_log.txt
- **Schedule**: Daily at 20:00

## 4. Disaster Recovery Test
A simulated failure was performed by deleting a file on PC-DIR. The file was successfully restored using the latest backup from the server. Screenshots of the topology and connectivity tests are provided in the delivery email.
