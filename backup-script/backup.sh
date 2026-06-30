#!/bin/bash

# Get current date and time for naming the backup
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Define source (what we're backing up) and destination (where backup goes)
SOURCE_DIR="/data/sample-data"
BACKUP_DIR="/data/backups"
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Create the backups folder if it doesn't already exist
mkdir -p "$BACKUP_DIR"

# Compress the source folder into a single backup file
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

# Confirm what happened
echo "Backup created: $BACKUP_FILE"
ls -lh "$BACKUP_FILE"