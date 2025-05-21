#!/bin/bash

# ===== CONFIGURATION =====

# Directories or files to backup (space-separated)
BACKUP_ITEMS="/etc /home/user/documents /var/log/syslog"

# Backup destination directory (local)
LOCAL_BACKUP_DIR="/backup"

# Or remote backup directory, format: user@remotehost:/path/to/backup
REMOTE_BACKUP_DIR=""

# Email notification settings
EMAIL_TO="your-email@example.com"
EMAIL_SUBJECT="Backup Completed Successfully"
EMAIL_BODY="The automated backup was completed successfully on $(hostname) at $(date). Backup file: "

# Number of backups to keep (older will be deleted)
KEEP_BACKUPS=7

# ===== SCRIPT START =====

# Timestamp for backup filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Backup filename
BACKUP_FILE="backup_${TIMESTAMP}.tar.gz"

# Full path for local backup
LOCAL_BACKUP_PATH="${LOCAL_BACKUP_DIR}/${BACKUP_FILE}"

# Create local backup directory if not exists
mkdir -p "$LOCAL_BACKUP_DIR"

# Create the backup archive with compression
echo "Starting backup of: $BACKUP_ITEMS"
tar -czf "$LOCAL_BACKUP_PATH" $BACKUP_ITEMS

if [ $? -ne 0 ]; then
    echo "Backup failed!" >&2
    echo "Backup failed on $(hostname) at $(date)" | mail -s "Backup FAILED" "$EMAIL_TO"
    exit 1
fi

# If remote backup directory is specified, copy backup there
if [ -n "$REMOTE_BACKUP_DIR" ]; then
    echo "Copying backup to remote server..."
    scp "$LOCAL_BACKUP_PATH" "$REMOTE_BACKUP_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to copy backup to remote server!" >&2
        echo "Backup succeeded locally but failed to copy to remote server on $(hostname) at $(date)" | mail -s "Backup Remote Copy FAILED" "$EMAIL_TO"
        exit 1
    fi
fi

# Delete old backups locally
echo "Cleaning up old backups, keeping last $KEEP_BACKUPS..."
ls -1t "$LOCAL_BACKUP_DIR"/backup_*.tar.gz | tail -n +$((KEEP_BACKUPS + 1)) | xargs -r rm --

# Send email notification
echo "${EMAIL_BODY} ${BACKUP_FILE}" | mail -s "$EMAIL_SUBJECT" "$EMAIL_TO"

echo "Backup process completed successfully!"
exit 0
