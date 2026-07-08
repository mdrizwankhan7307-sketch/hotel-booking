#!/bin/bash

set -e

CONTAINER_NAME="hotel-mysql"
DB_NAME="hotel_booking"
DB_USER="admin"
DB_PASSWORD="password"

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "./scripts/restore.sh <backup-file.sql>"
    exit 1
fi

BACKUP_FILE=$1

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found!"
    exit 1
fi

echo "Dropping existing database..."

docker exec $CONTAINER_NAME mysql \
-u$DB_USER \
-p$DB_PASSWORD \
-e "DROP DATABASE IF EXISTS $DB_NAME;
CREATE DATABASE $DB_NAME;"

echo "Restoring backup..."

docker exec -i $CONTAINER_NAME mysql \
-u$DB_USER \
-p$DB_PASSWORD \
$DB_NAME < "$BACKUP_FILE"

echo ""
echo "Restore completed successfully."