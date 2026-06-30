FROM alpine:latest

# Install bash and tar (alpine is minimal, doesn't include these by default)
RUN apk add --no-cache bash tar coreutils

# Create the working directories inside the container
RUN mkdir -p /data/sample-data /data/backups

# Copy our backup script into the container
COPY backup-script/backup.sh /backup.sh

# Make the script executable
RUN chmod +x /backup.sh

# Default command when the container runs
CMD ["/backup.sh"]
