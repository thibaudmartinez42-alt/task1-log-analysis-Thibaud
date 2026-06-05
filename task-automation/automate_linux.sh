#!/bin/bash
# Linux Automation Script - Task 8
LOG_FILE="/var/log/automation_admin.log"

# Log execution time
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Linux Automation Tasks" >> $LOG_FILE

# Add users from a .txt file
if [ -f "users.txt" ]; then
    while IFS= read -r user; do
        sudo useradd "$user"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] User added: $user" >> $LOG_FILE
    done < users.txt
fi

# Create a compressed backup of a directory
tar -czf /backup/system_backup_$(date '+%Y%m%d').tar.gz /etc
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Compressed backup of /etc successfully created." >> $LOG_FILE
