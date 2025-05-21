# Sysauto
# Automated Backup Script

This project provides a simple bash script to automate backups of important directories or files, compress them, and optionally send email notifications. It supports local and remote backups.

Sysauto/

├── auto_backup.sh       # Main backup bash script

├── config.sh            # Configuration variables for paths, retention, email

├── README.md            # Project description, usage, config & cron setup

├── .gitignore           # Ignore backup archives like backup_*.tar.gz

---

## Features

- Back up specified directories or files
- Timestamped compressed backups (`.tar.gz`)
- Option to copy backups to a remote server via SCP
- Email notification on success or failure
- Keeps only the latest N backups, cleaning old ones automatically

---

## Setup Instructions

### 1. Clone this repository

git clone https://github.com/aprajitapandeyxcghd/Sysauto.git


cd Sysauto

### 2. Configure the script
Open auto_backup.sh in a text editor and update the configuration variables at the top of the file:
# Directories or files to backup (space-separated)
BACKUP_ITEMS="/etc /home/user/documents"

# Local backup destination directory
LOCAL_BACKUP_DIR="/backup"

# Remote backup directory (leave empty if not used)
REMOTE_BACKUP_DIR=""

# Email notification recipient
EMAIL_TO="youremail@example.com"

# Number of backups to keep
KEEP_BACKUPS=7

### 3. Make the script executable
chmod +x auto_backup.sh

### 4. Run the backup script manually (test)
./auto_backup.sh

