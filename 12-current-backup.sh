#!/bin/bash

# Variables
SOURCE_DIR="/var/log/myapp"
BACKUP_DIR="/backup/logs"
DATE=$(date +%Y-%m-%d)
LOG_FILE="/var/log/log_backup.log"
RETENTION_DAYS=7

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" | tee -a "$LOG_FILE"
}

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    log "ERROR: Source directory $SOURCE_DIR not found."
    exit 1
fi

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR/$DATE"

log "Starting log backup for date: $DATE"

# Find today's log files (modified today)
find "$SOURCE_DIR" -type f -name "*.log" -newermt "$DATE" ! -newermt "$DATE +1 day" -exec cp {} "$BACKUP_DIR/$DATE/" \;

# Check if files copied
if [ "$(ls -A $BACKUP_DIR/$DATE)" ]; then
    tar -czf "$BACKUP_DIR/logs-$DATE.tar.gz" -C "$BACKUP_DIR" "$DATE"
    rm -rf "$BACKUP_DIR/$DATE"
    log "Backup successful: logs-$DATE.tar.gz created"
else
    log "No log files found for today"
    rm -rf "$BACKUP_DIR/$DATE"
fi

# Delete old backups
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

log "Old backups older than $RETENTION_DAYS days deleted"

log "Backup process completed"
