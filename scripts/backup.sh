#!/bin/bash

set -e

CONTAINER_NAME="hotel-mysql"
DB_NAME="hotel_booking"
DB_USER="admin"
DB_PASSWORD="password"

BACKUP_DIR="./backups"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql"

echo "Creating backup..."

docker exec $CONTAINER_NAME \
    mysqldump \
    -u$DB_USER \
    -p$DB_PASSWORD \
    $DB_NAME > "$BACKUP_FILE"

echo ""
echo "Backup completed successfully."
echo "Backup file:"
echo "$BACKUP_FILE"