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

# Generate a checksum (unique fingerprint) of the backup file
# Using cd + filename only, so the checksum stays valid regardless of the file's later location
cd "$BACKUP_DIR"
sha256sum "$(basename "$BACKUP_FILE")" > "$(basename "$BACKUP_FILE").sha256"
echo "Checksum generated: $(basename "$BACKUP_FILE").sha256"
cat "$(basename "$BACKUP_FILE").sha256"

# Record metrics for Prometheus in a simple text format
METRICS_FILE="$BACKUP_DIR/metrics.prom"
BACKUP_STATUS=1
BACKUP_SIZE=$(stat -c%s "$(basename "$BACKUP_FILE")" 2>/dev/null || echo 0)
END_TIME=$(date +%s)

cat > "$METRICS_FILE" << EOF
backup_last_run_timestamp $END_TIME
backup_last_success $BACKUP_STATUS
backup_size_bytes $BACKUP_SIZE
EOF

echo "Metrics written to $METRICS_FILE"
cat "$METRICS_FILE"